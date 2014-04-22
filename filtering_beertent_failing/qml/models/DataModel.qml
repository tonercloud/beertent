// Copyright (C) 2014 Chris Lamb
// This sofware is released under the MIT License --> http://en.wikipedia.org/wiki/MIT_license

import QtQuick 2.0
import Sailfish.Silica 1.0


ListModel {
    id: blistModel

    signal populated

    property bool useCache: true

    Component.onCompleted: fillblistModel();

    function fillblistModel()
    {
        console.log ("DataModel: populating model")
        //blistView.model = emptyblistModel;
        blistModel.clear();

        var brewerydata = db.brewers(useCache);

        for (var i = 0; i < brewerydata.length; i++) {
            var item = brewerydata[i];
            console.log ("DataModel: appending: " +  item.brewery_name);
            blistModel.append({"brewery_name": item.brewery_name,
                                  "bid": item.index,
                                  "web_Url": item.web_Url,
                                  "brewery_email_address": item.brewery_email_address,
                                  "brewery_phone_no": item.brewery_phone_no,
                                  "brewery_address": item.brewery_address});

            item = null;
        }
        console.log ("DataModel: model populated with items: " + brewerydata.length);

        //emit signal that the model is now populated
        populated()
         // Removed for the time being
            // Will be reinstated at some point
/*
        if (blistModel.count < 1) {
            addResourcesBtn.opacity = 1;
        }
        else {
            addResourcesBtn.opacity = 0;
        }

        blistView.model = blistModel;
*/
    }
/*
// CL --> CDW, You had this component as a Page,
// but this Page never becomes active as it is not part of a PageStack, so the models are never filled
// It makes more sense offer this component as a ListModel as it not real a page anyway
// (it's a non visual component that will used on a page).
// Instead of onStatusChanged we use Component.onCompleted the fillblistModel: from Component.onCompleted
    onStatusChanged: {
        if (status === PageStatus.Activating) {
            fillblistModel();
        }
    }
*/

}


