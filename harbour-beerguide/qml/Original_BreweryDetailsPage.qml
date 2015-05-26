import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: brewerydetailspage

    property variant breweryDetails
    property var locname
    property var locid

    function fillBreweryDetailsListModel()
    {

        detailslistView.model = emptydetailsListModel;
        detailslistModel.clear();

        var breweryDetails = gbgdb.brewery_info(brewerydetailspage.breweryDetails.locid);

        console.log("Brewery Id found at 19 : " + brewerydetailspage.breweryDetails.locid);

        for(var i = 0; i < brewerydetailspage.breweryDetails.locid; i++) {
            var currentItem = breweryDetails[i];

            // console.log("appending detail at 24 : " + i);
            detailslistModel.append({"locid": currentItem.index,
                                 "locfieldvalue": currentItem.locfieldvalue});

            currentItem = null;
        }
    }

    ListView {
        id: detailslistView
        anchors { left: parent.left; right: parent.right;
            top: parent.top; bottom: parent.bottom }
        clip: true
        delegate: detailslistDelegate
        model: detailslistModel
        focus: true
    }

    ListModel {
        id: detailslistModel
    }

    ListModel {
        id: emptydetailsListModel
    }

    Component {
        id: detailslistDelegate

        ListItem {
            id: dlistItem

            property int bid:                   model.locid
            property string locfieldvalue:      model.locfieldvalue
            }
        }

    onStatusChanged: {
        if (status === PageStatus.Activating) {
            console.log("BreweryDetailsPage Activating ... about to get details with: locid " + brewerydetailspage.breweryDetails.locid + ", locname: " + brewerydetailspage.breweryDetails.locname)
            fillBreweryDetailsListModel();
        }
    }

    SilicaListView {
        id: listView
        model: breweryInfomodel
        anchors.fill: parent
        header: PageHeader {
            title: "Brewery Details"
        }
        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.paddingLarge
                wrapMode: Text.WordWrap
                text: brewerydetailspage.breweryDetails.locname
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            Label {
                x: Theme.paddingLarge
                wrapMode: Text.WordWrap
                text: locfieldvalue // data from a single brewery here
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
        }
    }
}
