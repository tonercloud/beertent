import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: brewerylistpage

    property bool useCache: false

    property var deleteDialog

    function freePage()
    {
        delete deleteDialog;
    }

    function fillListModel()
    {
        listView.model = emptyListModel;
        listModel.clear();

        var brewerydata = db.brewers(useCache);
        console.debug("Brewery DB ", brewerydata);

        for(var i = 0; i < brewerydata.length; i++) {
            var item = brewerydata[i];

            listModel.append({"brewery_name": item.brewery_name,
                                 "id": item.index,
                                 "web_Url": item.web_Url,
                                 "brewery_email_address": item.brewery_email_address,
                                 "brewery_phone_no": item.brewery_phone_no,
                                 "brewery_address": item.brewery_address});
            item = null;
        }
        // Not sure yet how I will cope with an empty database
        // which is what this code checks for

        if (listModel.count < 1)
            addResourcesBtn.opacity = 1;
        else
            addResourcesBtn.opacity = 0;

        listView.model = listModel;
    }

    function showBrewerDetails()
    {
        var currIndex = listView.currentIndex;
        var currentItem = listModel.get(currIndex);
        console.log("BreweriesListPage 50 currentItem", currentItem);
    }

    ListModel {
        id: listModel
    }

    ListModel {
        id: emptyListModel
    }

    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Add/Edit Brewery"
                onClicked: pageStack.push(Qt.resolvedUrl("AddEditBreweryPage.qml"))
            }
            MenuItem {
                text: "Brewery Details"
                onClicked: pageStack.push(Qt.resolvedUrl("BreweryDetailsPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        SilicaListView {
            id: listView
            model: listModel
            delegate: Item {
                width: brewerylistView.width
                height: Theme.itemSizeSmall
            }
        }
        Column {
            id: column

            width: brewerylistpage.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: "Brewery Management"
            }
            Label {
                x: Theme.paddingLarge
                text: "brewery model count " + model.count
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
            }
        }
    }
}
