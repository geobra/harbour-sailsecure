import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Column {
        id: headerPart
        anchors.top: parent.top
        width: parent.width

        Label {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
	    font.family: Theme.fontFamilyHeading
	    color: Theme.primaryColor
            text: "SailSecure"
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
	    color: Theme.primaryColor
            text: "---"
	}
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
	    font.family: Theme.fontFamily
	    color: mainWindow.appIsConnected ? "green" : "red"
            text: mainWindow.appIsConnected ? "online" : "offline"
	}
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
	    font.family: Theme.fontFamily
	    color: textsecure.backendRunning ? "green" : "red"
            text: textsecure.backendRunning ? "connected" : "disconnected"
	}
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "---"
	}
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
	    color: "blue"
            font.pixelSize: Theme.fontSizeExtraLarge
            text: textsecure.unreadMsg
	}
   }
}
