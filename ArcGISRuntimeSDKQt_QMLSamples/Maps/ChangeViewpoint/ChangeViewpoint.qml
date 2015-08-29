// Copyright 2015 Esri.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import Esri.ArcGISRuntime 100.00
import Esri.ArcGISExtras 1.1

Rectangle {
    width: 800
    height: 600

    property real   scaleFactor: System.displayScaleFactor
    property real   rotationValue: 0.0
    property int    scaleIndex: -1

    PointBuilder {
        id: ptBuilder
        spatialReference: SpatialReference.createWgs84()
    }

    EnvelopeBuilder {
        id: envBuilder
        spatialReference: SpatialReference.createWgs84()
    }

    // Map view UI presentation at top
    MapView {
        id: mv

        anchors.fill: parent

        Map {
            BasemapImageryWithLabels {}
        }
    }

    // Controls UI presentation at bottom
    Rectangle {
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
        }
        height: 100 * scaleFactor
        color: "lightblue"
        Grid {
            anchors {
                centerIn: parent
            }
            spacing: 5

            Button {
                text: "Center"
                onClicked: {
                    console.log("In button Center...");
                    ptBuilder.setXY(-117.195681, 34.056218); // Esri Headquarters
                    mv.setViewpointCenter(ptBuilder.toGeometry());
                }
            }
            Button {
                text: "Center & Scale"
                onClicked: {
                    console.log("In button Center & Scale...");
                    ptBuilder.setXY(-157.564, 20.677); // Hawai'i
                    mv.setViewpointCenterAndScale(ptBuilder.toGeometry(), 4000000.0);
                }
            }
            Button {
                text: "Geometry"
                onClicked: {
                    console.log("In button Geometry...");
                    envBuilder.setCoords(116.385, 39.92, 116.395, 39.93, 0, 0, 0, 0); // Beijing
                    mv.setViewpointGeometry(envBuilder.toGeometry());
                }
            }
            Button {
                text: "Geometry && Padding"
                onClicked: {
                    console.log("In button Geometry & padding...");
                    envBuilder.setCoords(116.385, 39.92, 116.395, 39.93, 0, 0, 0, 0); // Beijing
                    mv.setViewpointGeometryAndPadding(envBuilder.toGeometry(), 200);
                }
            }
            Button {
                text: "Rotation"
                onClicked: {
                    console.log("In button Rotation...");
                    rotationValue = (rotationValue + 45.0) % 360.0;
                    mv.setViewpointRotation(rotationValue);
                }
            }
            Button {
                text: "Scale"
                onClicked: {
                    var scaleValues = [2000000.0, 5000000.0, 10000000.0, 50000000.0];
                    var scaleCount = scaleValues.length;

                    scaleIndex = (scaleIndex + 1) % scaleCount;
                    console.log("scaleIndex=", scaleIndex);
                    console.log("scaleValues.length=", scaleCount);
                    scaleIndex = scaleIndex % scaleValues.length;
                    console.log("scaleIndex=", scaleIndex);
                    mv.setViewpointScale(scaleValues[scaleIndex]);
                    console.log("In button scale, scale =", scaleValues[scaleIndex], "scaleIndex=", scaleIndex);
                }
            }
            Button {
                text: "Animation"
                onClicked: {
                    console.log("In button Animation...");
                }
            }
        }
    }

    // Neatline rectangle
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border {
            width: 0.5 * scaleFactor
            color: "black"
        }
    }
}
