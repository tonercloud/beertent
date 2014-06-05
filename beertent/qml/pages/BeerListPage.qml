import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: beerlistpage

    property int bid: -1
    property int beerid: -1

    state: "new"

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
                              "beerid": currentItem.beerid,
                              "drunk_y_n": currentItem.drunk_y_n,
                              "where_drunk": currentItem.where_drunk,
                              "notes": currentItem.notes});

            currentItem = null;
        }
/**
        if (beerListModel.count < 1)
            addResourcesBtn.opacity = 1;

        else
            addResourcesBtn.opacity = 0;
**/
        beerlistView.model = beerListModel;
    }

    function showBeerDetails(index)
    {
        var currIndex = beerlistView.currentIndex;
        var currentItem = beerListModel.get(index);

        // Used to identify why the brewery name wasn't being populated
        console.log("BeerList showBeerDetails bid", currentItem.bid);
        console.log("BeerList showBeerDetails beerName", currentItem.beerName);
        console.log("BeerList showBeerDetails breweryName", currentItem.brewery_name);
        console.log("BeerList showBeerDetails abv", currentItem.abv);
        console.log("BeerList showBeerDetails breweryId", currentItem.breweryId);
        console.log("BeerList showBeerDetails drunk_y_n", currentItem.drunk_y_n);
        console.log("BeerList showBeerDetails where_drunk", currentItem.where_drunk);
        console.log("BeerList showBeerDetails notes", currentItem.notes);

        pageStack.push(Qt.createComponent("BeerDetailsPage.qml"),
                       { beerId      : currentItem.bid,
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
                // change page name to reflect the choice change above
                onClicked: pageStack.push(Qt.resolvedUrl("AddBeerPage.qml"))
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
                source: model.drunk_y_n? "../images/empty_glass.png" : "../images/full_glass.png"
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
            onClicked: {
                showBeerDetails(index);
            }
        }
    }
}
