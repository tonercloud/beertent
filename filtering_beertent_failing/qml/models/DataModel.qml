// Copyright (C) 2014 Chris Lamb
// This sofware is released under the MIT License --> http://en.wikipedia.org/wiki/MIT_license

import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: datamodelpage

    property bool useCache: true

    function fillblistModel()
    {
        blistView.model = emptyblistModel;
        blistModel.clear();

        var brewerydata = db.brewers(useCache);

        for (var i = 0; i < brewerydata.length; i++) {
            var item = brewerydata[i];

            blistModel.append({"brewery_name": item.brewery_name,
                                  "bid": item.index,
                                  "web_Url": item.web_Url,
                                  "brewery_email_address": item.brewery_email_address,
                                  "brewery_phone_no": item.brewery_phone_no,
                                  "brewery_address": item.brewery_address});

            item = null;
        }
         // Removed for the time being
            // Will be reinstated at some point
        if (blistModel.count < 1) {
            addResourcesBtn.opacity = 1;
        }
        else {
            addResourcesBtn.opacity = 0;
        }

        blistView.model = blistModel;

    }

    onStatusChanged: {
        if (status === PageStatus.Activating) {
            fillblistModel();
        }
    }
    /**
    ListModel {
        id: contactModel
        ListElement {
            displayLabel: "Achim"
        }
        ListElement {
            displayLabel: "Ana"
        }
        ListElement {
            displayLabel: "Barnie"
        }
    } **/

    ListModel {
        id: blistModel
    }
}
