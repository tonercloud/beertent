import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: addbrewerypage

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
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

    VerticalScrollDecorator {}

    Column {
        id: column
        anchors { left: parent.left; right: parent.right }
        spacing: Theme.paddingLarge

        PageHeader { title: "Add a Brewery" }

        TextField {
            id: breweryNameField
            anchors { left: parent.left; right: parent.right }
            focus: true; label: "Brewery Name"; placeholderText: label
            EnterKey.enabled: text || inputMethodComposing
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: web_UrlField.focus = true
        }

        TextField {
            id: web_UrlField
            anchors { left: parent.left; right: parent.right }
            focus: true; label: "Web Url"; placeholderText: label
            EnterKey.enabled: text || inputMethodComposing
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: breweryemailaddressField.focus = true
        }

        TextField {
            id: breweryemailaddressField
            anchors { left: parent.left; right: parent.right }
            focus: true; label: "Brewery Email Address"; placeholderText: label
            EnterKey.enabled: text || inputMethodComposing
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: breweryphonenoField.focus = true
        }

        TextField {
            id: breweryphonenoField
            anchors { left: parent.left; right: parent.right }
            focus: true; label: "Brewery Phone Number"; placeholderText: label
            EnterKey.enabled: text || inputMethodComposing
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: breweryaddressField.focus = true
        }

        TextField {
            id: breweryaddressField
            anchors { left: parent.left; right: parent.right }
            focus: true; label: "Brewery Address"; placeholderText: label
            EnterKey.enabled: text || inputMethodComposing
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: {
                if (errorHighlight)
                    breweryNameField.focus = true
                else
                    addBreweryToDatabase();
                    pageStack.push(Qt.resolvedUrl("BreweryListPage.qml"))
                }
            }
        }
    }
}
