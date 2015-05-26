#ifndef DATABASEMANAGER_H_
#define DATABASEMANAGER_H_

#include "sqlquerymodel.h"

#include <QObject>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QPixmap>
#include <QVariant>

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

    QSqlError lastError();

private:
    bool opengbgdb();

private:
    QSqlDatabase gbgdb;

};

#endif /* DATABASEMANAGER_H_ */
