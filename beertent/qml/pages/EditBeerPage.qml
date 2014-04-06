import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: editbeerpage
    SilicaListView {
        id: listView
        model: 6
        anchors.fill: parent
        header: PageHeader {
            title: "Edit Beer Page\nwith Text Box\nfor notes"
            // Not all the above text shows in the emulator
            // Only 21 characters appear.
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
