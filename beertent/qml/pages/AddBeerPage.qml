import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: addbeerpage

    property int    beerId: -1
    property string beerName
    property string abv
    property int    bid: -1
    // property string drunk_y_n
    property var drunk_y_n_text: "false"
    property string where_drunk
    property string notes

    state: "new"

    function addBeerToDatabase()
    {
        if (wheredrunkField.text.length > 0) {
            drunk_y_n_text = "true" }
        else drunk_y_n_text = "false"
        if (beerId !== -1) {
            db.updateBeer(beerId, beerNameField.text, abvField.text, brewerydetailspage.breweryDetails.bid, drunk_y_n_text, wheredrunkField.text, tastingNotesField.text );
            console.debug("BeerAddEdit 23", beerNameField.text, abvField.text, brewerydetailspage.breweryDetails.bid, drunk_y_n_text, wheredrunkField.text, tastingNotesField.text);
        }
        else {
            db.insertBeer(beerNameField.text, abvField.text, bid, drunk_y_n_text, wheredrunkField.text, tastingNotesField.text);
            console.debug("BeerAddEdit 27", beerNameField.text, abvField.text, bid, drunk_y_n_text, wheredrunkField.text, tastingNotesField.text);
        }
        if (addbeerpage.beerId === -1) {
            state = "new";
            console.log("31 AddBeerPage StatusChanged", PageStatus.Activating);
        }
        else {
            state = "view";
            console.log("35 AddBeerPage StatusChanged", PageStatus.Activating);
        }
    }
     // Deletes the beer data from the database.
    function deleteBeerFromDatabase()
    {
        db.deleteBeer(beerId);
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

    VerticalScrollDecorator {}

    Column {
        id: column
        anchors { left: parent.left; right: parent.right }
        spacing: Theme.paddingLarge

        PageHeader { title: "Add a Beer" }

        TextField {
            id: beerNameField
            anchors { left: parent.left; right: parent.right }
            focus: true; label: "Beer Name"; placeholderText: label
            EnterKey.enabled: text || inputMethodComposing
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: abvField.focus = true
        }

        TextField {
            id: abvField
            anchors { left: parent.left; right: parent.right }
            focus: true; label: "abv"; placeholderText: label
            EnterKey.enabled: text || inputMethodComposing
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: wheredrunkField.focus = true
        }

        TextField {
            id: wheredrunkField
            anchors { left: parent.left; right: parent.right }
            focus: true; label: "Where beer drunk"; placeholderText: label
            EnterKey.enabled: text || inputMethodComposing
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: tastingNotesField.focus = true
        }

        TextArea {
            id: tastingNotesField
            width: parent.width
            height: Math.max(addbeerpage.width/3, implicitHeight)
            anchors { left: parent.left; right: parent.right }
            focus: true; label: "Tasting Notes"; placeholderText: label
            EnterKey.enabled: text || inputMethodComposing
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: {
                if (errorHighlight)
                    breweryNameField.focus = true
                else
                    addBeerToDatabase();
                pageStack.clear();
                    pageStack.push(Qt.resolvedUrl("BreweryListPage.qml"))
                }
            }
        }
    }
    Component.onCompleted: {
        if (addbeerpage.beerid == -1) {
            state = "new";
            console.log("105 addbeerpage StatusChanged", PageStatus.Activating);
        }
        else {
            state = "view";
            console.log("109 addbeerpage StatusChanged", PageStatus.Activating);
        }
    }
}
