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

        // No PullDownMenu on this page. Editing is done by a long press.

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





