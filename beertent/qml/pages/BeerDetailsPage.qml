import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: beerdetailspage
    SilicaListView {
        id: listView
        model: 10
        anchors.fill: parent
        header: PageHeader {
            title: "Beer Details"
        }

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Edit Beer Page next"
                onClicked: pageStack.push(Qt.resolvedUrl("EditBeerPage.qml"))
            }
        }

        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.paddingLarge
                text: "Item " + index
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: console.log("Clicked " + index)
        }
        VerticalScrollDecorator {}
    }
}





