// Test change
#include "DatabaseManager.h"
#include <QStringList>
#include <QDir>
#include <QVariant>
#include <QBuffer>
#include <QFile>
#include <QDesktopServices>
#include <QDebug>

// ---------------------------------------------------------------------------
// Brewery details
// ---------------------------------------------------------------------------
Brewery::Brewery(QObject* parent) : QObject(parent)
{
    m_id = 0;
}

Brewery::~Brewery()
{
}

int Brewery::index() const
{
    return m_id;
}

void Brewery::setIndex(const int id)
{
    m_id = id;
}

QString Brewery::brewery_name() const
{
    return m_brewery_name;
}

void Brewery::setbrewery_name(const QString brewery_name)
{
    m_brewery_name = brewery_name;
}

QString Brewery::web_Url() const
{
    return m_web_Url;
}

void Brewery::setWeb_Url(const QString web_Url)
{
    m_web_Url = web_Url;
}

QString Brewery::brewery_email_address() const
{
    return m_brewery_email_address;
}

void Brewery::setbrewery_email_address(const QString brewery_email_address)
{
    m_brewery_email_address = brewery_email_address;
}

QString Brewery::brewery_phone_no() const
{
    return m_brewery_phone_no;
}

void Brewery::setbrewery_phone_no(const QString brewery_phone_no)
{
    m_brewery_phone_no = brewery_phone_no;
}

QString Brewery::brewery_address() const
{
    return m_brewery_address;
}

void Brewery::setbrewery_address(const QString brewery_address)
{
    m_brewery_name = brewery_address;
}

// ---------------------------------------------------------------------------
// Beer
// ---------------------------------------------------------------------------
Beer::Beer(QObject* parent) : QObject(parent)
{
    m_id = 0;
}
Beer::~Beer()
{
}

int Beer::index() const
{
    return m_id;
}

void Beer::setIndex(const int index)
{
    m_id = index;
}

QString Beer::beername() const
{
    return m_beername;
}

void Beer::setbeername(const QString beername)
{
    m_beername = beername;
}

QString Beer::ABV() const
{
    return m_ABV;
}

void Beer::setABV(const QString ABV)
{
    m_ABV = ABV;
}

int Beer::breweryid() const
{
    return m_breweryid;
}

void Beer::setbreweryid(const int breweryid)
{
    m_breweryid = breweryid;
}

bool Beer::drunk_y_n() const
{
    return m_drunk_y_n;
}

void Beer::setdrunk_y_n(const bool drunk_y_n)
{
    m_drunk_y_n = drunk_y_n;
}

QString Beer::where_drunk() const
{
    return m_where_drunk;
}

void Beer::setwhere_drunk(const QString where_drunk)
{
    m_where_drunk = where_drunk;
}

QString Beer::notes() const
{
    return m_notes;
}

void Beer::setnotes(const QString notes)
{
    m_notes = notes;
}

// ---------------------------------------------------------------------------
// DatabaseManager
// ---------------------------------------------------------------------------
DatabaseManager::DatabaseManager(QObject *parent) :
    QObject(parent)
{
}

DatabaseManager::~DatabaseManager()
{
    close();
}

void DatabaseManager::open()
{
    opendb();
    initdb();
}

void DatabaseManager::close()
{
    if (db.isOpen())
        db.close();
}

bool DatabaseManager::opendb()
{
    // Find QSLite driver
    db = QSqlDatabase::addDatabase("QSQLITE");

    QString path(QDir::home().path());
    path.append(QDir::separator()).append("beertent.db.sqlite");
    path = QDir::toNativeSeparators(path);
    db.setDatabaseName(path);

    // Open databasee
    return db.open();
}

bool DatabaseManager::initdb()
{
    bool ret = true;

    // Create 2 tables
    createBreweryTable();
    createBeerTable();

    // Check that tables exists
    if (db.tables().count() != 2)
        ret = false;

    return ret;
}

void DatabaseManager::deletedb()
{
    db.close();

    QString path(QDir::home().path());
    path.append(QDir::separator()).append("beertent.db.sqlite");
    path = QDir::toNativeSeparators(path);

    QFile::remove(path);
}

QSqlError DatabaseManager::lastError()
{
    return db.lastError();
}

bool DatabaseManager::createBeerTable()
{
    // Create table
    bool ret = false;
    if (db.isOpen()) {
        QSqlQuery query;
        ret = query.exec("create table beers "
                         "(id integer primary key, "
                         "beername VARCHAR(100), "
                         "ABV VARCHAR(5), "
                         "breweryid INT, "
                         "drunk_y_n bool, "
                         "where_drunk VARCHAR(100), "
                         "notes VARCHAR(250), "
                         "FOREIGN KEY (breweryid) REFERENCES brewers)");
    }
    return ret;
}

bool DatabaseManager::createBreweryTable()
{
    // Create table
    bool ret = false;
    if (db.isOpen()) {
        QSqlQuery query;
        ret = query.exec("create table brewers "
                         "(id integer primary key, " // this is autoincrement field http://www.sqlite.org/autoinc.html
                         "brewery_name VARCHAR(50), "
                         "web_Url VARCHAR(100), "
                         "brewery_email_address VARCHAR(100), "
                         "brewery_phone_no VARCHAR(20), "
                         "brewery_address VARCHAR(100))");
    }
    return ret;
    // qDebug() << "Return Values: " << ret;
}

QVariant DatabaseManager::updateBrewery(const QVariant& id,
                                       const QVariant& brewery_name,
                                       const QVariant& web_Url,
                                       const QVariant& brewery_email_address,
                                       const QVariant& brewery_phone_no,
                                       const QVariant& brewery_address)
{
    bool ret = false;
    QSqlQuery query;
    ret = query.prepare("UPDATE brewers SET brewery_name = :brewery_name, web_Url = :web_Url, brewery_email_address =:brewery_email_address, brewery_phone_no =:brewery_phone_no, brewery_address =:brewery_address where id = :id");
    if (ret) {
        query.bindValue(":brewery_name", brewery_name);
        query.bindValue(":web_Url", web_Url);
        query.bindValue(":brewery_email_address", brewery_email_address);
        query.bindValue(":brewery_phone_no", brewery_phone_no);
        query.bindValue(":brewery_address", brewery_address);
        query.bindValue(":id", id);
        ret = query.exec();
    }
    return QVariant(ret);
}

void DatabaseManager::deleteBrewery(const int id)
{
    QSqlQuery query;
    query.exec(QString("delete from brewers where id = %1").arg(id));
}

QVariant DatabaseManager::insertBrewery(const QVariant& brewery_name,
                                       const QVariant& web_Url,
                                       const QVariant& brewery_email_address,
                                       const QVariant& brewery_phone_no,
                                       const QVariant& brewery_address)
{
    Brewery item;
    item.m_brewery_name = brewery_name.toString();
    item.m_web_Url = web_Url.toString();
    item.m_brewery_email_address = brewery_email_address.toString();
    item.m_brewery_phone_no = brewery_phone_no.toString();
    item.m_brewery_address = brewery_address.toString();

    bool ret = false;
    int retVal = -1;
    if (db.isOpen()) {
        // item->id = nextId(); // We demonstrate autoincrement in this case

        // http://www.sqlite.org/autoinc.html
        // NULL = is the keyword for the autoincrement to generate next value

        QSqlQuery query;
        ret = query.prepare("INSERT INTO brewers (brewery_name, web_Url, brewery_email_address, brewery_phone_no, brewery_address) "
                            "VALUES (:brewery_name, :web_Url, :brewery_email_address, :brewery_phone_no, :brewery_address)");
        if (ret) {
            query.bindValue(":brewery_name", item.m_brewery_name);
            query.bindValue(":web_Url", item.m_web_Url);
            query.bindValue(":brewery_email_address", item.m_brewery_email_address);
            query.bindValue(":brewery_phone_no", item.m_brewery_phone_no);
            query.bindValue(":brewery_address", item.m_brewery_address);
            ret = query.exec();
        }

        // Get database given autoincrement value
        if (ret) {
            // http://www.sqlite.org/c3ref/last_insert_rowid.html  
            item.m_id = query.lastInsertId().toInt();
            retVal = item.m_id;
        }
    }
    return QVariant(retVal);
}

QList<QObject*> DatabaseManager::brewers(const QVariant& useCache)
{
    bool cache = useCache.toBool();

    if (cache && m_brewersCache.length()>0) {
        // qDebug() << "Using Cache";
        // qDebug() << "Brewery items count at start :" << m_brewersCache.length();
        return m_brewersCache;
    } else {
        // qDebug() << "Filling Cache";
        m_brewersCache.clear();
        QSqlQuery query("select * FROM brewers ORDER BY brewery_name ASC");
        while (query.next()) {
            Brewery* item = new Brewery();
            item->m_id = query.value(0).toInt();
            item->m_brewery_name = query.value(1).toString();
            item->m_web_Url = query.value(2).toString();
            item->m_brewery_email_address = query.value(3).toString();
            item->m_brewery_phone_no = query.value(4).toString();
            item->m_brewery_address = query.value(5).toString();
            m_brewersCache.append(item);
            // Note: the debug statement returns all the db data and so is only useful on a small file.
            // qDebug() << "DBM 363 brewersCache" << m_brewersCache;
        }
        return m_brewersCache;
    }
}

QList<QObject*> DatabaseManager::brewery_beers(const QVariant& breweryid)
{
    int brewery = breweryid.toInt();

    // TODO: support cache?

    // qDebug() << "DBM 376 Reading beers for breweryid" << brewer ;
    QList<QObject*> rtn;
    QSqlQuery query(QString("select * from beers where breweryid = %1 ORDER BY beername ASC").arg(brewery));
    // QSqlQuery query(QString("select * from beers where breweryid = %1 ORDER BY beername ASC"));
    while (query.next()) {
        Beer* beer = new Beer(this);
        beer->m_id = query.value(0).toInt();
        beer->m_beername = query.value(1).toString();
        beer->m_ABV = query.value(2).toString();
        beer->m_breweryid = query.value(3).toInt();
        beer->m_drunk_y_n = query.value(4).toBool(); //Changed from Int to try and identify runtime error.
        beer->m_where_drunk = query.value(5).toString();
        beer->m_notes = query.value(6).toString();


/*
        beer->m_id = query.value(0).toInt();
        beer->m_beername = query.value(1).toString();
        beer->m_ABV = query.value(2).toString();
        beer->m_drunk_y_n = query.value(3).toBool(); //Changed from Int to try and identify runtime error.
        beer->m_where_drunk = query.value(4).toString();
        beer->m_notes = query.value(5).toString();
*/

        rtn.append(beer);
    }
    // qDebug() << "DBM 389 brewery " << brewery ;
    // qDebug() << "DBM 390 beer count for brewery is " << rtn.length();
    return rtn;
}

int DatabaseManager::insertBeer(const QVariant& beername,
                                const QVariant& ABV,
                                const QVariant& breweryid,
                                const QVariant& drunk_y_n,
                                const QVariant& where_drunk,
                                const QVariant& notes)
{
    // bool ret = false;
    int beerId = -1;

    if (db.isOpen()) {
        QSqlQuery query;
        bool ret = query.prepare("INSERT INTO beers (beername, ABV, breweryid, drunk_y_n, where_drunk, notes) "
                                 "VALUES (:beername, :ABV, :breweryid, :drunk_y_n, :where_drunk, :notes)");
        if (ret) {
            query.bindValue(":beername", beername);
            query.bindValue(":ABV", ABV);
            query.bindValue(":breweryid", breweryid);
            query.bindValue(":drunk_y_n", false);
            query.bindValue(":where_drunk", where_drunk);
            query.bindValue(":notes", notes);
            query.exec();
        }
    }
        // return QVariant(beerId);
        return beerId;
}

void DatabaseManager::updateBeer(const int beerId,
                                 const QVariant& beername,
                                 const QVariant& ABV,
                                 const QVariant& breweryid,
                                 const QVariant& drunk_y_n,
                                 const QVariant& where_drunk,
                                 const QVariant& notes)
{
    QSqlQuery query;
    bool ret = query.prepare("UPDATE beers SET beername = :beername, ABV = :ABV, breweryid = :breweryid, drunk_y_n = :drunk_y_n, where_drunk = :where_drunk, notes = :notes where id = :id");
    if (ret) {
        query.bindValue(":beername", beername);
        query.bindValue(":ABV", ABV);
        query.bindValue(":breweryid", breweryid);
        query.bindValue(":drunk_y_n", drunk_y_n);
        query.bindValue(":where_drunk", where_drunk);
        query.bindValue(":notes", notes);
        query.bindValue(":id", beerId);
        ret = query.exec();
    }
}

void DatabaseManager::deleteBeer(const int id)
{
    QSqlQuery query;
    query.exec(QString("delete from beers where id = %1").arg(id));
}

QObject* DatabaseManager::beer(const int id)
{
    Beer* beer = new Beer(this);
    QSqlQuery query(QString("select * from beers where id = %1").arg(id));
    if (query.next()) {
        beer->m_id = query.value(0).toInt();
        beer->m_beername = query.value(1).toString();
        beer->m_ABV = query.value(2).toString();
        beer->m_drunk_y_n = query.value(3).toInt(); // was Bool but changed to try and fix 'undefined' error
        beer->m_where_drunk = query.value(4).toString();
        beer->m_notes = query.value(5).toString();
    }
    return beer;
}
