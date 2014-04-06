import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: addeditbrewerypage

    property int    breweryid: -1
    property string breweryName
    property string webUrl
    property string breweryemailaddress
    property string breweryphoneno
    property string breweryaddress

    state: "new"

    function addBreweryToDatabase()
    {
        if (breweryid !== -1) {
            db.updateBrewery(breweryid, breweryNameField.text, web_UrlField.text, breweryemailaddressField.text, breweryphonenoField.text, breweryaddressField.text );
        }
        else {
            db.insertBrewery(breweryNameField.text, web_UrlField.text, breweryemailaddressField.text, breweryphonenoField.text, breweryaddressField.text );
        }
        doBack();
    }

    SilicaListView {
        id: listView
        model: 10
        anchors.fill: parent
        header: PageHeader {
            title: "Add/Edit Breweries here"
        }
        // This page will only return to the BreweryListPage

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





