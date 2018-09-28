// [WriteFile Name=DisplayKmlNetworkLinks, Category=Layers]
// [Legal]
// Copyright 2018 Esri.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// [Legal]

import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.3
import Esri.ArcGISRuntime 100.4

Item {
    id: messageButton
    signal clicked()

    Rectangle {
        anchors.fill: messageContents
        radius: 4 * scaleFactor

        border {
            color: "darkgray"
            width: 1 * scaleFactor
        }

        MouseArea {
            anchors.fill: parent
            onClicked: messageButton.clicked()
        }
    }

    Row {
        id: messageContents
        leftPadding: 5 * scaleFactor
        rightPadding: leftPadding
        spacing: 5 * scaleFactor
        anchors {
            horizontalCenter: messageButton.horizontalCenter
            bottom: messageButton.bottom
        }

        Image {
            anchors.verticalCenter: parent.verticalCenter
            id: messageImage
            width: 32 * scaleFactor
            height: 32 * scaleFactor
            source: "qrc:/Samples/Layers/DisplayKmlNetworkLinks/iOS8_TabBar_Email90.png"
            anchors.margins: 5 * scaleFactor

            SequentialAnimation on opacity {
                running: messageContents.visible
                loops: Animation.Infinite

                PropertyAnimation { to: 1; duration: 1000; easing.type: Easing.InOutQuad }
                PropertyAnimation { to: 0; duration: 1000; easing.type: Easing.InOutQuad }
            }
        }

        Text{
            id: messageText
            anchors {
                verticalCenter: messageImage.verticalCenter
                margins: 5 * scaleFactor
            }

            text: "Message Recieved"
            color: "#2f2f2f"
            font.pixelSize: 13 * scaleFactor
            renderType: Text.NativeRendering
        }
    }
}
