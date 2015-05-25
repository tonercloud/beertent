import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
     id: brewerydetailspage

     property variant breweryDetails
     property var brewery_name
     property var bid

     property bool useCache: true

     function showbdetails()
     {
         var currIndex = listView.currentIndex;
         var currentItem = listmodel.get(currIndex);
/**
         pageStack.push(Qt.createComponent("BeerListPage.qml"),
                        { bid : currentItem.bid }); **/
     }
/**
     function getBreweryDetails()
     {
         // insert code here to fetch single brewery details from bid
         // and call it from somewhere !!
     }
**/
     function fillBreweryDetailsListModel()
     {

         detailslistView.model = emptydetailsListModel;
         detailslistModel.clear();

         var breweryDetails = db.brewers(brewerydetailspage.breweryDetails.bid);

         console.log("Brewery Id found at 35 : " + brewerydetailspage.breweryDetails.bid);

         for(var i = 0; i < brewerydetailspage.breweryDetails.bid; i++) {
             var currentItem = breweryDetails[i];

             // console.log("appending detail at 42 : " + i);
             detailslistModel.append({"bid": currentItem.index,
                                  "brewery_name": currentItem.brewery_name,
                                  "web_Url": currentItem.web_Url,
                                  "brewery_email_address": breweryDetails.brewery_email_address,
                                  "brewery_phone_no": currentItem.brewery_phone_no,
                                  "brewery_address": currentItem.brewery_address});

             currentItem = null;
         }
     }

     onStatusChanged: {
         if (status === PageStatus.Activating) {
             console.log("BreweryDetailsPage Activating ... about to get details with: bid " + brewerydetailspage.breweryDetails.bid + ", name: " + brewerydetailspage.breweryDetails.brewery_name)
             fillBreweryDetailsListModel();
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

             property int bid:                   model.bid
             property string brewery_name:       model.brewery_name
             property string web_Url:            model.web_Url
             property string brewery_phone_no:   model.brewery_phone_no
             property string brewery_address:    model.brewery_address
             }
         }

     SilicaListView {
         id: detailsView
         model: detailslistModel
         anchors.fill: parent

         contentHeight: column.height

         Column {
             id: column
             width: brewerydetailspage.width - Theme.paddingLarge
             spacing: Theme.paddingLarge
             PageHeader {
                 title: brewerydetailspage.breweryDetails.brewery_name
                 }

             Label {
                 width: parent.width - Theme.paddingLarge
                 x: Theme.paddingLarge
                 wrapMode: Text.Wrap
                 text: breweryDetails.brewery_name
                 // text: brewerydetailspage.breweryDetails.brewery_name
                 font.pixelSize: Theme.fontSizeMedium
             }
             Label {
                 width: parent.width - Theme.paddingLarge
                 x: Theme.paddingLarge
                 wrapMode: Text.Wrap
                 text: brewerydetailspage.breweryDetails.web_Url
                 font.pixelSize: Theme.fontSizeMedium
             }
             Label {
                 x: Theme.paddingLarge
                 text: brewerydetailspage.breweryDetails.brewery_phone_no
                 font.pixelSize: Theme.fontSizeMedium
             }
             Label {
                 width: parent.width - Theme.paddingLarge
                 x: Theme.paddingLarge
                 wrapMode: Text.Wrap
                 elide: Text.ElideRight
                 text: brewerydetailspage.breweryDetails.brewery_address
                 font.pixelSize: Theme.fontSizeMedium
             }
             Button {
                 id: beerlist

                 property string selection

                 anchors.horizontalCenter: parent.horizontalCenter
                 text: "List Beers"
                 onClicked: pageStack.push(Qt.createComponent("BeerListPage.qml"),
                                           { bid : brewerydetailspage.breweryDetails.bid })
             }
         }
    }
}
