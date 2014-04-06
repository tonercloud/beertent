#ifndef DATABASEMANAGER_H_
#define DATABASEMANAGER_H_

#include <QObject>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QPixmap>
#include <QDate>
#include <QVariant>

// ---------------------------------------------------------------------------
// Brewery
// ---------------------------------------------------------------------------
class Brewery : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int index READ index WRITE setIndex)
    Q_PROPERTY(QString brewery_name READ brewery_name WRITE setbrewery_name)
    Q_PROPERTY(QString web_Url READ web_Url WRITE setWeb_Url)
    Q_PROPERTY(QString brewery_email_address READ brewery_email_address WRITE setbrewery_email_address)
    Q_PROPERTY(QString brewery_phone_no READ brewery_phone_no WRITE setbrewery_phone_no)
    Q_PROPERTY(QString brewery_address READ brewery_address WRITE setbrewery_address)

public:
    Brewery(QObject* parent=0);
    ~Brewery();

    int index() const;
    void setIndex(const int);

    QString brewery_name() const;
    void setbrewery_name(const QString);

    QString web_Url() const;
    void setWeb_Url(const QString);

    QString brewery_email_address() const;
    void setbrewery_email_address(const QString);

    QString brewery_phone_no() const;
    void setbrewery_phone_no(const QString);

    QString brewery_address() const;
    void setbrewery_address(const QString);

public:
    int m_id;
    QString m_brewery_name;
    QString m_web_Url;
    QString m_brewery_email_address;
    QString m_brewery_phone_no;
    QString m_brewery_address;
};

// ---------------------------------------------------------------------------
// Beer
// ---------------------------------------------------------------------------
class Beer : public QObject // Beer details
{
    Q_OBJECT
    Q_PROPERTY(int index READ index WRITE setIndex)
    Q_PROPERTY(QString beername READ beername WRITE setbeername)
    Q_PROPERTY(QString ABV READ ABV WRITE setABV)
    Q_PROPERTY(int breweryid READ breweryid WRITE setbreweryid)
    Q_PROPERTY(bool drunk_y_n READ drunk_y_n WRITE setdrunk_y_n)
    Q_PROPERTY(QString where_drunk READ where_drunk WRITE setwhere_drunk)
    Q_PROPERTY(QString notes READ notes WRITE setnotes)

public:
    Beer(QObject* parent=0);
    ~Beer();

    int index() const;
    void setIndex(const int);

    QString beername() const;
    void setbeername(const QString);

    QString ABV() const;
    void setABV(const QString);

    int breweryid() const;
    void setbreweryid(const int);

    bool drunk_y_n() const;
    void setdrunk_y_n(const bool);

    QString where_drunk() const;
    void setwhere_drunk(const QString);

    QString notes() const;
    void setnotes(const QString);

public:
    int m_id;
    QString m_beername;
    QString m_ABV;
    int m_breweryid;
    bool m_drunk_y_n;
    QString m_where_drunk;
    QString m_notes;
};

// ---------------------------------------------------------------------------
// DatabaseManager
// ---------------------------------------------------------------------------
class DatabaseManager: public QObject
{
    Q_OBJECT

public:
    DatabaseManager(QObject *parent = 0);
    ~DatabaseManager();

public:
    Q_INVOKABLE void open();
    Q_INVOKABLE void close();
    Q_INVOKABLE void deletedb();

    // for BrewersTable
    Q_INVOKABLE QVariant insertBrewery(const QVariant& brewery_name,
                                      const QVariant& web_Url,
                                      const QVariant& brewery_email_address,
                                      const QVariant& brewery_phone_no,
                                      const QVariant& brewery_address);
    Q_INVOKABLE QList<QObject*> brewers(const QVariant& useCache);
    Q_INVOKABLE QVariant updateBrewery(const QVariant& id,
                                      const QVariant& brewery_name,
                                      const QVariant& web_Url,
                                      const QVariant& brewery_email_address,
                                      const QVariant& brewery_phone_no,
                                      const QVariant& brewery_address);
    Q_INVOKABLE void deleteBrewery(const int id);

    // for BeerTable
    Q_INVOKABLE int insertBeer(const QVariant& beername,
                               const QVariant& ABV,
                               const QVariant& breweryid,
                               const QVariant& drunk_y_n,
                               const QVariant& where_drunk,
                               const QVariant& notes);
    Q_INVOKABLE void updateBeer(const int beerId,
                                const QVariant& beername,
                                const QVariant& ABV,
                                const QVariant& breweryid,
                                const QVariant& drunk_y_n,
                                const QVariant& where_drunk,
                                const QVariant& notes);
    Q_INVOKABLE void deleteBeer(const int id);
    Q_INVOKABLE QList<QObject*> brewery_beers(const QVariant& breweryid);
    Q_INVOKABLE QObject* beer(const int id);

    QSqlError lastError();

private:
    bool opendb();
    bool initdb();
    bool createBreweryTable();
    bool createBeerTable();

private:
    QSqlDatabase db;

    QList<QObject*>     m_brewersCache;
};

#endif /* DATABASEMANAGER_H_ */
