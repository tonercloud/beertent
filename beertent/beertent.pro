# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = beertent

CONFIG += sailfishapp

QT += sql gui

SOURCES += src/beertent.cpp \
    src/DatabaseManager.cpp

HEADERS += src/DatabaseManager.h

OTHER_FILES += qml/beertent.qml \
    qml/cover/CoverPage.qml \
    qml/pages/About.qml \
    qml/pages/AddEditBreweryPage.qml \
    qml/pages/BreweryListPage.qml \
    qml/pages/BreweryDetailsPage.qml \
    qml/pages/BeerListPage.qml \
    qml/pages/BeerDetailsPage.qml \
    qml/pages/EditBeerPage.qml \
    rpm/beertent.spec \
    rpm/beertent.yaml \
    beertent.desktop
