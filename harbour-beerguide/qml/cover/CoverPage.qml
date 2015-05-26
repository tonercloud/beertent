import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    id: coverpage
    anchors.centerIn: parent

    Image {
        id: logo
        source: "qrc:///assets/icons/harbour-beerguide.png"
        anchors.centerIn: parent
    }

    Label {
        id: textlabel
        anchors.centerIn: coverpage
        width: coverpage.width - (2 * Theme.paddingLarge)
        height: (coverpage.height /3) * 2
        wrapMode: "WordWrap"
        elide: Text.ElideRight
        font.pixelSize: Theme.fontSizeLarge
        style: Text.Raised
        styleColor: Theme.secondaryColor
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("Beerguide")
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-next"
        }

    }
}
