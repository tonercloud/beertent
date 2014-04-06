import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: beerlistpage
    SilicaListView {
        id: listView
        model: 30
        anchors.fill: parent
        header: PageHeader {
            title: "Beer List Page"
        }

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Show Beer Details Page"
                onClicked: pageStack.push(Qt.resolvedUrl("BeerDetailsPage.qml"))
            }
        }
        PushUpMenu {
            MenuItem {
                text: "Go to top"
                onClicked: listView.scrollToTop()
            }
        }

        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.paddingLarge
                // if index < 9 then index = "0" + index
                text: "Item " + index
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: console.log("Clicked " + index)
        }
        VerticalScrollDecorator {}
    }
}
