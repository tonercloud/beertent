import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: beerlistpage

    property int bid: -1
    property int beerId: -1

    // state: "new"

    function fillbeerListModel()
    {
        beerlistView.model = emptybeerListModel;
        beerListModel.clear();

        var beersdata = db.brewery_beers(bid);

        for(var i =0; i < beersdata.length; i++) {
            var currentItem = beersdata[i];

            beerListModel.append({"bid": currentItem.index,
                              "beerName": currentItem.beerName,
                              "abv": currentItem.abv,
                              "beerId": currentItem.beerId,
                              "drunk_y_n": currentItem.drunk_y_n,
                              "where_drunk": currentItem.where_drunk,
                              "notes": currentItem.notes});

            currentItem = null;
        }
        console.log("Line 33 - DataModel: breweryid (bid): " + bid);
        console.log("Line 34 - DataModel: model populated with items: " + beersdata.length);

        if (beerListModel.count < 1)
            addResourcesBtn.opacity = 1;

        else
            addResourcesBtn.opacity = 0;

        beerlistView.model = beerListModel;
    }

    function showBeerDetails(index)
    {
        var currIndex = beerlistView.currentIndex;
        var currentItem = beerListModel.get(index);

        pageStack.push(Qt.createComponent("BeerDetailsPage.qml"),
                       { beerId      : currentItem.beerId,
                         brewery_name : currentItem.brewery_name,
                         beerName    : currentItem.beerName,
                         abv         : currentItem.abv,
                         // bid         : currentItem.bid,
                         drunk_y_n   : currentItem.drunk_y_n,
                         where_drunk : currentItem.where_drunk,
                         notes       : currentItem.notes });
    }

    // Update page data on PageStatus.Activating state
    onStatusChanged: {
        if (status == PageStatus.Activating) {
            fillbeerListModel();
        }
    }

    ListModel {
        id: beerListModel
    }

    ListModel {
        id: emptybeerListModel
    }
/**
    Component {
        id: beerlistDelegate

        ListItem {
            id: beerlistItem
            property int beerId: model.beerId
            property int breweryId: model.breweryId
            property string beerName: model.beerName
            property string abv: model.abv
            property string drunk_y_n: model.drunk_y_n
            property string where_drunk: model.where_drunk
            property string notes: model.notes
        }
    }
**/
    Item {
        id: addResourcesBtn
        anchors.centerIn: parent
        opacity: 0

        Text {
            id: textid
            text: qsTr("No beers")
            color: "white"
            anchors.centerIn: parent
        }
    }

    SilicaListView {
        id: beerlistView
        model: beerListModel
        anchors.fill: parent
        header: PageHeader {
            title: brewerydetailspage.breweryDetails.brewery_name
        }

        // Implement a context menu for editing instead of a drop-down.

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Add a Beer"
                // onClicked: pageStack.push(Qt.resolvedUrl("AddBeerPage.qml"), { breweryId : index })
                onClicked: pageStack.push(Qt.resolvedUrl("AddBeerPage.qml"), {  bid : brewerydetailspage.breweryDetails.bid })
            }
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

            width: parent.width
            height: Theme.itemSizeSmall

            Row {
                spacing: Theme.paddingMedium
                id: rowlayout
                x: Theme.paddingLarge
            Image {
                id: beerglass
                fillMode: Image.PreserveAspectCrop
                x: Theme.paddingMedium
                // source: drunk? "../images/empty_glass.png" : "../images/full_glass.png"
                source: model.drunk_y_n ? "../images/empty_glass.png" : "../images/full_glass.png"
            }
             Label {
                id: abvtext
                width: beerglass.width * 2
                color: parent.highlighted ? Theme.highlightColor : Theme.primaryColor
                text: model.abv
            }
            Label {
                color: parent.highlighted ? Theme.highlightColor : Theme.primaryColor
                text: model.beerName
                }
            }
            Component {
                id: contextMenuComponent
                ContextMenu {
                    MenuItem {
                        text: "Edit"
                        // onClicked: edit()
                    }
                }
            }
            onClicked: {
                showBeerDetails(index);
            }
        }
    }
}
