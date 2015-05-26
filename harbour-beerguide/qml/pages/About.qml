import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: aboutpage

    SilicaListView {
        id: alistView
        model: versionmodel
        anchors.fill: parent
        header: PageHeader {
            title: "About Beerguide"
        }

        delegate: BackgroundItem {
            id: delegate

            Label {
                id: progversion
                x: Theme.paddingMedium
                text: "Beertent Version: " + APP_VERSION
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.highlightColor
            }

            Label {
                id: dataversion
                x: Theme.paddingMedium
                text: "DataBase Version: " + edition + " v" + version
                anchors.top: progversion.bottom
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.highlightColor
            }

            Label {
                // anchors.verticalCenter: parent.verticalCenter
                width: alistView.width - Theme.paddingMedium * 2
                x: Theme.paddingMedium
                textFormat: Text.RichText
                font.pixelSize: Theme.fontSizeMedium
                anchors.top: dataversion.bottom
                text:  "<style>a:link { color: " + Theme.hightlightColor +
                       "; }</style><p><br>BeerGuide is an application written for a Jolla phone that allows a user to track consumption of beers which are listed in the CAMRA database.</p><p>The UI is implemented to allow fast searching and data entry as the most important thing is drinking, not computing. </p><h3>Instructions</h3><p>When the application is run for the first time, the database is empty. The user will need to obtain a copy of the CAMRA database which will need to copied to the phone. You cannot track beers on their own. They are tied to a brewery. If you enter a location (data for which is also provided by the CAMRA database), the beer will be automatically marked as 'Drunk'. That is signified by the indication of an empty glass on the beer list for each brewery."
                wrapMode: Text.WordWrap

            }
        }
    }
}
