import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: brewerylistpage

    property bool useCache: true

    property var deleteDialog

    function fillblistModel()
    {
        blistView.model = emptyblistModel;
        blistModel.clear();

        var brewerydata = db.brewers(useCache);
        // console.debug("BreweryListPage 17 ", brewerydata);

        for (var i = 0; i < brewerydata.length; i++) {
            var item = brewerydata[i];

            blistModel.append({"brewery_name": item.brewery_name,
                                 "bid": item.index,
                                 "web_Url": item.web_Url,
                                 "brewery_email_address": item.brewery_email_address,
                                 "brewery_phone_no": item.brewery_phone_no,
                                 "brewery_address": item.brewery_address});
            item = null;
        }

        if (blistModel.count < 1) {
            addResourcesBtn.opacity = 1;
        }
        else {
            addResourcesBtn.opacity = 0;
        }

        blistView.model = blistModel;
    }

    function showbreweryDetails(breweryDetails)
    {
        console.log("about to push to BreweryDetailsPage, for brewery - bid: " + breweryDetails.bid + ", name: " + breweryDetails.brewery_name)
        pageStack.push(Qt.resolvedUrl("BreweryDetailsPage.qml"),
                       { breweryDetails : breweryDetails });
    }

    function deletebreweryFromDatabase()
    {
        var currIndex = blistView.currentIndex;
        var currentItem = blistModel.get(currIndex);
        if (currIndex !== -1) {
            db.deleteBrewer(currentItem.id);
        }
        fillbListModel();
    }

    onStatusChanged: {
        if (status === PageStatus.Activating) {
            fillblistModel();
        }
    }

    ListModel {
        id: blistModel
    }

    ListModel {
        id: emptyblistModel
    }

    Component {
        id: blistDelegate

        ListItem {
            id: blistItem
            // property int beerId: model.beerId
            property int breweryId: model.breweryId
            // property string beerName: model.beerName
            property string web_Url: model.web_Url
            property string brewery_email_address: model.brewery_email_address
            property string brewery_phone_no: model.brewery_phone_no
            property string brewery_address: model.brewery_address
        }
    }

    Item {
        id: addResourcesBtn
        anchors.centerIn: parent
        opacity: 0

        Text {
            id: textid
            text: qsTr("No breweries")
            color: "white"
            anchors.centerIn: parent
        }
    }

    SilicaListView {
        id: blistView
        model: blistModel
        anchors.fill: parent
        // width: blistView.width
        header: PageHeader {
            title: "Breweries List"
        }

        // Implement a context menu for editing instead of a drop-down.

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("About");
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("About.qml"))
                }
            }
            MenuItem {
                text: "Add Brewery"
                onClicked: pageStack.push(Qt.resolvedUrl("AddBreweryPage.qml"))
            }
        }
        PushUpMenu {
            MenuItem {
                text: "Go to top"
                onClicked: blistView.scrollToTop()
            }
        }

        delegate: BackgroundItem {
            id: delegate

            Label {
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - Theme.paddingLarge
                x: Theme.paddingMedium
                wrapMode: Text.Wrap
                // elide: Text.ElideRight
                font.pixelSize: Theme.fontSizeMedium
                // style: Text.Raised
                text: model.brewery_name
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: {
                showbreweryDetails(model);
            }
        }
        VerticalScrollDecorator {}
    }
}
