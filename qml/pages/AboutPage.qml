// Copyright (c) 2015 Piotr Tworek. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE.YTPlayer file.

import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    objectName: "aboutPage"

    Column {
        id: headerPart
        anchors.top: parent.top
        width: parent.width

        PageHeader {
            //: Title of about page
            title: "About SailSecure"
        }
        Item {
            width: parent.width
            height: Theme.paddingMedium
        }
        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            height: 256
            fillMode: Image.PreserveAspectFit
            source: "../harbour-sailsecure.png"
        }
        Item {
            width: parent.width
            height: Theme.paddingMedium
        }
        Label {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Theme.fontSizeSmall
            wrapMode: Text.WordWrap
            maximumLineCount: 2
            horizontalAlignment: Text.AlignHCenter
            text: "Unofficial Signal (Textsecure) client for Sailfish OS"
        }
        Item {
            width: parent.width
            height: Theme.paddingMedium
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.secondaryColor
            text: "Version 0.1"
        }
        Item {
            width: parent.width
            height: Theme.paddingMedium
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.secondaryColor
            text: "Copyright \u00A9 2016 Georg Brand"
        }
        Label {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.secondaryColor
            wrapMode: Text.WordWrap
            maximumLineCount: 2
            horizontalAlignment: Text.AlignHCenter
            text: qsTrId("License: GPL v3")
        }
        Item {
            width: parent.width
            height: Theme.paddingLarge
        }
        Label {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.secondaryColor
            wrapMode: Text.WordWrap
            maximumLineCount: 2
            horizontalAlignment: Text.AlignHCenter
            text: qsTrId("Client backend by\nhttps://github.com/janimo/textsecure/")
        }
        Item {
            width: parent.width
            height: Theme.paddingLarge
        }
        Label {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.secondaryColor
            wrapMode: Text.WordWrap
            maximumLineCount: 3
            horizontalAlignment: Text.AlignHCenter
            text: qsTrId("UI based on\nhttp://gitlab.unique-conception.org/thebootroo/mitakuuluu-ui-ng")
        }
        Item {
            width: parent.width
            height: Theme.paddingLarge
        }
        Label {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.secondaryColor
            wrapMode: Text.WordWrap
            maximumLineCount: 2
            horizontalAlignment: Text.AlignHCenter
            text: qsTrId("Some ideas, code and concepts from\nhttps://github.com/aebruno/whisperfish")
        }
    }

    Label {
        id: urlPart
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Theme.paddingSmall
        color: Theme.secondaryColor
        font.pixelSize: Theme.fontSizeTiny
        text: "https://github.com/geobra/harbour-sailsecure"
    }
}

