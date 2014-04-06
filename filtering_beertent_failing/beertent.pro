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

QT += sql

SOURCES += src/beertent.cpp \
           src/DatabaseManager.cpp

HEADERS += src/DatabaseManager.h

OTHER_FILES += qml/beertent.qml \
    rpm/beertent.spec \
    rpm/beertent.yaml \
    beertent.desktop \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/gui/InitialCharacterPicker/InitialCharacterPicker.qml \
    qml/gui/InitialCharacterPicker/CharacterButton.qml \
    qml/gui/InitialCharacterPicker/CharacterGrid.qml \
    qml/gui/InitialCharacterPicker/CharacterRow.qml \
    qml/models/DataModel.qml \
    qml/gui/DataDelegate.qml
