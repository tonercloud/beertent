import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    id: coverpage
    anchors.fill: parent

    Image {
        id: logo
        source: "images/beertent.png"
        // Note that as positioned, it will overwrite the text above
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
        text: "Beertent"
    }

    // Note that the two icons listed below will only appear
    // when the app is 'docked' i.e. minimised on the front screen
    // but it is possible to slide into an action from here too.
    // See this video for an example -
    // http://www.jollausers.com/2013/11/beginning-programming/

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-next"
        }
        /**
        CoverAction {
            iconSource: "image://theme/icon-cover-pause"
        } **/
    }
}
