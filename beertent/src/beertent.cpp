#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <QGuiApplication>
#include <QQuickView>

#include <sailfishapp.h>
#include "DatabaseManager.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());

    DatabaseManager* db = new DatabaseManager();
    db->open();

    view->rootContext()->setContextProperty("db", db);

    view->setSource(SailfishApp::pathTo("qml/beertent.qml"));

    view->show();

    return app->exec();
}
