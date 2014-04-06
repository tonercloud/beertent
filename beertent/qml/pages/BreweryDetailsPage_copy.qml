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

    onStatusChanged: {
        if (status === PageStatus.Activating) {
        }
    }

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
                onClicked: pageStack.push(Qt.resolvedUrl("BeerListPage.qml"))
            }
        }

        delegate: BackgroundItem {
            id: delegate
            width: parent.width

            Label {
                id: breweryNameLabel
                anchors {
                    leftMargin: Theme.paddingSmall
                    verticalCenter: parent.verticalCenter
                }
                wrapMode: Text.Wrap
                text: brewery_name
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            Label {
                id: webUrlLabel
                anchors {
                    leftMargin: Theme.paddingSmall
                    top: breweryNameLabel.bottom
                }
                text: web_Url
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            Label {
                id: breweryemailaddressLabel
                anchors {
                    leftMargin: Theme.paddingSmall
                    top: webUrlLabel.bottom
                }
            }
        }
        /**
        TextField {
            id: breweryNameField
            text: brewery_name
            // anchors.verticalCenter: parent.verticalCenter
            color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            // breweryName : currentItem.brewery_name
        }
        TextField {
            id: webUrlField
            anchors.leftMargin: breweryNameField.bottom
            text: web_Url
            // webUrl : currentItem.web_Url
        }
        TextField {
            id: breweryemailaddressField
            // anchors.verticalCenter: parent.verticalCenter
            text: brewery_email_address
            // breweryemailaddress : currentItem.brewery_email_address
        }
        Text {
            id: breweryphonenoField
            anchors.verticalCenter: parent.verticalCenter
            text: brewery_phone_no
            // breweryphoneno : currentItem.brewery_phone_no
        }
        Text {
            id: breweryaddressField
            anchors.verticalCenter: parent.verticalCenter
            text: brewery_address
            // breweryaddress : currentItem.brewery_address
        } **/
        VerticalScrollDecorator {}
    }
}
