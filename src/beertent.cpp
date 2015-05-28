#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <QGuiApplication>
#include <QQuickView>
#include <QQmlContext>

#include <sailfishapp.h>
#include "DatabaseManager.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());

    view->rootContext()->setContextProperty("APP_VERSION", APP_VERSION);

    // qDebug() << "App Version is : " << APP_VERSION;

    DatabaseManager* db = new DatabaseManager();
    db->open();

    view->rootContext()->setContextProperty("db", db);

    view->setSource(SailfishApp::pathTo("qml/harbour-beertent.qml"));

    view->show();

    return app->exec();
}
