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
TARGET = harbour-beertent

CONFIG += sailfishapp

DEFINES += APP_VERSION=\\\"$$VERSION\\\"

QT += sql

RESOURCES += resources.qrc

SOURCES += src/beertent.cpp \
           src/DatabaseManager.cpp

HEADERS += src/DatabaseManager.h

OTHER_FILES += qml/harbour-beertent.qml \
    qml/cover/CoverPage.qml \
    qml/pages/About.qml \
    qml/pages/AddBreweryPage.qml \
    qml/pages/AddBeerPage.qml \
    qml/pages/BreweryDetailsPage.qml \
    qml/pages/BreweryListPage.qml \
    qml/pages/BeerListPage.qml \
    qml/pages/BeerDetailsPage.qml \
    qml/pages/EditBreweryPage.qml \
    qml/AdaptiveSearch/AdaptiveSearch.qml \
    qml/AdaptiveSearch/AdaptiveSearchPanel.qml \
    qml/AdaptiveSearch/PanelButton.qml \
    rpm/harbour-beertent.changes.in \
    rpm/harbour-beertent.spec \
    rpm/harbour-beertent.yaml \
    translations/*.ts \
    harbour-beertent.desktop

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-beertent-de.ts

