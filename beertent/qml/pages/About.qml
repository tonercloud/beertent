import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: aboutpage

    SilicaFlickable {
        id: aboutFlickable
        anchors.fill: parent
        contentWidth: aboutpage.width
        contentHeight: pagecolumn.height

        Column {
            width: parent.width
            id: pagecolumn

            PageHeader {
                title: qsTr("About")
            }

            Label {
                x: Theme.paddingMedium
                text: "Beertent Version 0.1"
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.highlightColor
            }

            Label {
                // anchors.verticalCenter: parent.verticalCenter
                width: pagecolumn.width - Theme.paddingMedium * 2
                x: Theme.paddingMedium
                textFormat: Text.RichText
                font.pixelSize: Theme.fontSizeMedium
                text: "<style>a:link { color: " + Theme.hightlightColor +
                      "; }</style>BeerTent is an application written for a Jolla phone that allows a user to add breweries and beers into a database to maintain a list of beers which the user has consumed.</p><p>The UI is implemented to allow fast searching and data entry as the most important thing is drinking, not computing. </p><h3>Instructions</h3><p>When the application is run for the first time, the database is empty. The user can then start defining breweries followed by beers. You cannot enter beers on their own. They have to be tied to a brewery. After one or more breweries have been created, beers can be entered. If you enter a location, the beer will be automatically marked as 'Drunk'. That is signified by the indication of an empty glass on the beer list for each brewery. If no location is entered, the beer is assumed to have not been consumed and a full glass will be shown."
                wrapMode: Text.WordWrap

            }
        }
    }
}
