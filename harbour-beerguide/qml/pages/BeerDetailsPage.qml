import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: beerdetailspage

    property int    beerId: -1
    property string beerName
    property string abv
    property int    breweryid: -1
    //property string drunk_y_n
    property bool drunk_y_n: false
    property string where_drunk
    property string notes

    // state: "new"

    function updateBeerinDatabase()
    {
        drunk_y_n = (where_drunkField.text.length > 0);
        if (beerId !== -1) {
            db.updateBeer(beerId, beerNameField.text, abvField.text, breweryid, drunk_y_n, wheredrunkField.text, notesField.text );
            console.debug("BeerAddEdit 23", beerNameField.text, abvField.text, breweryid, drunk_y_n, wheredrunkField.text, notesField.text);
        }
        else {
            console.debug("BeerDetailsPage 26, beerId is wrong!")
        }
    }

    function showbeerdetails()
    {
        var currIndex = listView.currentIndex;
        var currentItem = listmodel.get(currIndex);
    }

    function fillbeerDetailsListModel()
    {
        detailslistView.model = emptydetailsListModel;
        detailslistModel.clear();

        var beerDetails = db.beer(beerId);

        console.log("Beer Id found at line 43 BeerDetailsPage : " + beerId);

        for(var i = 0; i < beerId; i++) {
            var currentItem = beerDetails[i];

            detailslistModel.append({"beername:": currentItem.beerName,
                                        "ABV:": currentItem.abv,
                                        "brewery id:": currentItem.breweryid,
                                        "drunk_y_n:": currentItem.drunk_y_n,
                                        "where_drunk:": currentItem.where_drunk,
                                        "notes:": currentItem.notes});

            currentItem = null;
        }
    }

    ListModel {
        id: detailslistModel
    }

    ListModel {
        id: emptydetailsListModel
    }

    SilicaListView {
        id: detailsView
        model: detailslistModel
        anchors.fill: parent

        // No PullDownMenu on this page. Editing is done by a long press.
        // Editing is yet to be implimented - 20/10/2014

        contentHeight: column.height

        Column {
            id: column
            width: beerdetailspage.width - Theme.paddingLarge
            spacing: Theme.paddingLarge
            PageHeader {
                title: "Beer Details"
            }

            Label {
                x: Theme.paddingLarge
                text: beerName
            }
            Label {
                x: Theme.paddingLarge
                text: abv
            }
            Label {
                x: Theme.paddingLarge
                text: (drunk_y_n ? "Drunk at: " : "Not drunk yet")
            }
            Label {
                width: parent.width - Theme.paddingLarge
                x: Theme.paddingLarge
                wrapMode: Text.Wrap
                text: where_drunk
                font.pixelSize: Theme.fontSizeMedium
            }
            Label {
                width: parent.width - Theme.paddingLarge
                x: Theme.paddingLarge
                wrapMode: Text.Wrap
                elide: Text.ElideRight
                text: notes
                font.pixelSize: Theme.fontSizeMedium
            }
        }
        VerticalScrollDecorator {}
    }
}
