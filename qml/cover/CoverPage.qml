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
            text: "SailSecure"
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "---"
	}
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: mainWindow.appIsConnected ? "online" : "offline"
	}
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: textsecure.backendRunning ? "connected" : "disconnected"
	}
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "---"
	}
   }
}
