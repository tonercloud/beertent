/*
 * BeerGuide, Sailfish application to track breweries and beers from the CAMRA Good Beer Guide
 *
 * Copyright (C) 2015 Chris Walker
 *
 * This file is part of Beerguide.
 *
 * Beerguide is free software: you can redistribute it and/or modify it under the terms of the
 * GNU General Public License as published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * Beerguide is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License for more details. You should have received a copy of the GNU
 * General Public License along with Beerguide. If not, see <http://www.gnu.org/licenses/>.
 *
 * Author: Chris Walker
 */

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <QGuiApplication>
#include <QQuickView>
#include <QQmlContext>

#include <sailfishapp.h>
#include "DatabaseManager.h"
#include "sqlquerymodel.h"

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());

    view->rootContext()->setContextProperty("APP_VERSION", APP_VERSION);

    // qDebug() << "App Version is : " << APP_VERSION;

    DatabaseManager* gbgdb = new DatabaseManager();
    gbgdb->open();

    view->rootContext()->setContextProperty("gbgdb", gbgdb);
    
    // ************* Breweries Data starts here
    SqlQueryModel *breweriesmodel = new SqlQueryModel(0);
    breweriesmodel->setQuery("select * FROM breweries ORDER BY locname ASC");
    
    view->rootContext()->setContextProperty("breweriesmodel", breweriesmodel);

    // ************* Beers Data starts here - needs to be filtered like breweryInfo does
    // ************* So we start with a vanilla SQL call
    SqlQueryModel *beersmodel = new SqlQueryModel(0);
    beersmodel->setQuery("select * FROM 'beers' ORDER BY 'beername' ASC");

    view->rootContext()->setContextProperty("beersmodel", beersmodel);

    QSortFilterProxyModel* beersModelFiltered = new QSortFilterProxyModel(0);

    // set existing model as a source for filtering proxy
    beersModelFiltered->setSourceModel(beersmodel);

    // set subsequent filtering calls to operate on the third column - breweryid
    // column counts start at 0
    beersModelFiltered->setFilterKeyColumn(2);

    view->rootContext()->setContextProperty("beersmodel", beersModelFiltered);

    // ************* Beer_Info Data starts here - needs to be filtered like breweryInfo does
    // ************* So we start with a vanilla SQL call
    SqlQueryModel *beerinfoModel = new SqlQueryModel(0);
    beerinfoModel->setQuery("select * FROM 'beer_info'");

    view->rootContext()->setContextProperty("beerinfoModel", beerinfoModel);

    QSortFilterProxyModel* beerinfoModelFiltered = new QSortFilterProxyModel(0);

    // set existing model as a source for filtering proxy
    beerinfoModelFiltered->setSourceModel(beerinfoModel);

    // set subsequent filtering calls to operate on the first column - beerid
    beerinfoModelFiltered->setFilterKeyColumn(0);

    view->rootContext()->setContextProperty("beerinfoModel", beerinfoModelFiltered);

    // ************* Brewery Info Filter Data starts here
    SqlQueryModel *breweryInfomodel = new SqlQueryModel(0);
    breweryInfomodel->setQuery("SELECT * FROM 'brewery_info'");

    QSortFilterProxyModel* breweryInfoModelFiltered = new QSortFilterProxyModel(0);

    // set existing model as a source for filtering proxy
    breweryInfoModelFiltered->setSourceModel(breweryInfomodel);

    // set subsequent filtering calls to operate on the first column - locid
    breweryInfoModelFiltered->setFilterKeyColumn(0);

    view->rootContext()->setContextProperty("breweryInfomodel", breweryInfoModelFiltered);

    // ************* Database Version info starts here
    SqlQueryModel *versionmodel = new SqlQueryModel(0);
    versionmodel->setQuery("SELECT * FROM 'gbgversioninfo'");

    view->rootContext()->setContextProperty("versionmodel", versionmodel);

    // ************* Back to the usual stuff here
    view->setSource(SailfishApp::pathTo("qml/harbour-beerguide.qml"));

    view->show();

    return app->exec();
}
