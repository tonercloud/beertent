import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: brewerydetailspage

    property int    bid
    property string brewery_name
    property string web_Url
    property string brewery_email_address
    property string brewery_phone_no
    property string brewery_address

    ListModel {
        id: brewerydetailsmodel
    }
    /**
    onStatusChanged: {
        if (status === PageStatus.Activating) {
        }
    } **/

    SilicaListView {
        id: brewerydetailslist
        width: brewerydetailspage.width
        model: brewerydetailsmodel
        // height: parent.height
        // anchors.top: parent.top
        anchors.fill: parent
        header: PageHeader {
            title: "Brewery Details"
        }

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Edit Brewery"
                onClicked: pageStack.push(Qt.resolvedUrl("AddEditBreweryPage.qml"))
            }
            MenuItem {
                text: "List Beers"
                onClicked: console.log("Clicked " + bid) ;
                // pageStack.push(Qt.resolvedUrl("BeerListPage.qml"))
                // will need to pass details here
            }
        } /**
        delegate: Item {
        // delegate: BackgroundItem {
            //cid: delegate
            // id: detailsdelegate
            **/

        Label {
            id: breweryNameLabel
            anchors.top: parent.top
            anchors.topMargin: 100 // was Theme.paddingLarge
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - Theme.paddingMedium
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingMedium
            wrapMode: Text.Wrap
            text: brewery_name
        }
        Label {
            id: web_UrlLabel
            anchors.top: breweryNameLabel.bottom
            anchors.topMargin: Theme.paddingMedium // was 20
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingMedium
            wrapMode: Text.Wrap
            text: web_Url
        }
        Label {
            id: brewery_email_addressLabel
            anchors.top: web_UrlLabel.bottom
            anchors.topMargin: Theme.paddingMedium // was 20
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingMedium
            wrapMode: Text.Wrap
            text: brewery_email_address
        }
        Label {
            id: brewery_phone_noLabel
            anchors.top: brewery_email_addressLabel.bottom
            anchors.topMargin: Theme.paddingMedium // was 20
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingMedium
            wrapMode: Text.Wrap
            text: brewery_phone_no
        }
        Label {
            id: brewery_addressLabel
            anchors.top: brewery_phone_noLabel.bottom
            anchors.topMargin: Theme.paddingMedium // was 20
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingMedium
            wrapMode: Text.Wrap
            text: brewery_email_address
            }
        }
        VerticalScrollDecorator {}
    /** } **/
}
