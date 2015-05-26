#include "DatabaseManager.h"
#include <QStringList>
#include <QDir>
#include <QVariant>
#include <QBuffer>
#include <QFile>
#include <QDesktopServices>
#include <QDebug>

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
    opengbgdb();
}

void DatabaseManager::close()
{
    if (gbgdb.isOpen())
        gbgdb.close();
}

bool DatabaseManager::opengbgdb()
{
    // Find QSLite driver
    gbgdb = QSqlDatabase::addDatabase("QSQLITE");

    QString path = QStandardPaths::writableLocation(QStandardPaths::DataLocation) + "/gbg_data.db.sqlite";

    QDir dir(QStandardPaths::writableLocation(QStandardPaths::DataLocation));
    if (!dir.exists()) {
        dir.mkpath(QStandardPaths::writableLocation(QStandardPaths::DataLocation));
    }
        gbgdb.setDatabaseName(path);

    return gbgdb.open();
}

QSqlError DatabaseManager::lastError()
{
    return gbgdb.lastError();
}
