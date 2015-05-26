import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: beerlistpage
    
    property variant breweryid

    SilicaListView {
        id: beerlistView
        model: beersmodel
        anchors.fill: parent
        header: PageHeader {
            title: breweryid.locid
        }

        PushUpMenu {
            MenuItem {
                text: qsTr("Go to top")
                onClicked: beerlistView.scrollToTop()
            }
        }
        VerticalScrollDecorator {}

        delegate: BackgroundItem {
            id: delegate
            // set height to fit info_field text but not less than Theme.itemSizeSmall
            // height: Math.max(beername_field.height, Theme.itemSizeSmall)

            width: parent.width

            Row {
                spacing: Theme.paddingMedium
                id: rowlayout
                x: Theme.paddingLarge
            Image {
                id: beerglass
                fillMode: Image.PreserveAspectCrop
                x: Theme.paddingMedium
                // source: drunk? "../images/empty_glass.png" : "../images/full_glass.png"
                // source: model.drunk_y_n ? "../images/empty_glass.png" : "../images/full_glass.png"
            }
             // Label {
                // id: abvtext
                // width: beerglass.width * 2
                // color: parent.highlighted ? Theme.highlightColor : Theme.primaryColor
                // text: beerinfoModel.beerfieldid.beerfieldvalue
            // }
            Label {
                id: beername_field
                color: parent.highlighted ? Theme.highlightColor : Theme.primaryColor
                // text: breweryinfo.beername
                text: beername
                }
            }
            // onClicked: {
                // showBeerDetails(index);
            // }
        }
    }
}
