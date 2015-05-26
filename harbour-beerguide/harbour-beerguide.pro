# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-beerguide

CONFIG += sailfishapp

DEFINES += APP_VERSION=\\\"$$VERSION\\\"

QT += sql

RESOURCES += resources.qrc

SOURCES += src/beerguide.cpp \
           src/DatabaseManager.cpp \
           src/sqlquerymodel.cpp

HEADERS += src/DatabaseManager.h \
           src/sqlquerymodel.h

OTHER_FILES += qml/harbour-beerguide.qml \
    qml/cover/CoverPage.qml \
    qml/pages/About.qml \
    qml/pages/BeerDetailsPage.qml \
    qml/pages/BeerListPage.qml \
    qml/pages/BreweryDetailsPage.qml \
    qml/pages/BreweryListPage.qml \
    rpm/harbour-beerguide.changes.in \
    rpm/harbour-beerguide.spec \
    rpm/harbour-beerguide.yaml \
    translations/*.ts \
    harbour-beerguide.desktop

# to disable building translations every time, comment out the
# following CONFIG line
# CONFIG += sailfishapp_i18n
# TRANSLATIONS += translations/harbour-beerguide-de.ts
