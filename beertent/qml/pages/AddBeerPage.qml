import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: addbeerpage

    property int    beerid: -1
    property string beerName
    property string abv
    property int    breweryid: -1
    property bool   drunk
    property string where_drunk
    property string notes

    state: "new"

    /** Adds the beer data into the database. */
    function addBeerToDatabase()
    {
        drunk = (wheredrunkField.text.length > 0);
        if (beerId !== -1) {
            db.updateBeer(beerId, beerNameField.text, abvField.text, breweryid, drunk, wheredrunkField.text, notesField.text );
            // db.updateBeer(beerId, beerNameField.text, abvField.text, breweryid, drunk, wheredrunkField.text, notesField.text );
            console.debug("BeerAddEdit 25", beerNameField.text, abvField.text, breweryid, drunk, wheredrunkField.text, notesField.text);
        }
        else {
            db.insertBeer(beerNameField.text, abvField.text, breweryid, drunk, wheredrunkField.text, notesField.text);
            console.debug("BeerAddEdit 31", beerNameField.text, abvField.text, breweryid, drunk, wheredrunkField.text, notesField.text);
        }
    }
     // Deletes the beer data from the database.
    function deleteBeerFromDatabase()
    {
        db.deleteBeer(beerId);
    }

    onBeeridChanged: {
        if (beerAddPage.beerId === -1) {
            state = "new";
            console.log("41 BeAEPage StatusChanged", PageStatus.Activating);
        }
        else {
            state = "view";
            console.log("65 BeAEPage StatusChanged", PageStatus.Activating);
        }
    }

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

    // Look at WizardPage.qml in the gallery code for how to impliment an Account Creation
    // wizard including placeholder text.

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
            focus: true; label: "ABV"; placeholderText: label
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
            EnterKey.onClicked: tastingNotes.focus = true
        }

        TextField {
            id: tastingNotesField
            anchors { left: parent.left; right: parent.right }
            focus: true; label: "Tasting Notes"; placeholderText: label
            EnterKey.enabled: text || inputMethodComposing
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: {
                if (errorHighlight)
                    breweryNameField.focus = true
                else
                    pageStack.push(Qt.resolvedUrl("BeerListPage.qml"))
                }
            }
        }
    }

    Component.onCompleted: {
        if (addbeerpage.beerid == -1) {
            state = "new";
            console.log("122 addbeerpage StatusChanged", PageStatus.Activating);
        }
        else {
            state = "view";
            console.log("126 addbeerpage StatusChanged", PageStatus.Activating);
        }
    }
}
