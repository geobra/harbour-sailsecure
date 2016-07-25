import QtQuick 2.0
import Sailfish.Silica 1.0
import MeeGo.Connman 0.2
import "pages"
import "cover"

ApplicationWindow {
	
	id: mainWindow
	onApplicationActiveChanged: {
		if (applicationActive == true) {
			textsecure.appActive = true
		}
		else {
			textsecure.appActive = false
		}
	}

	cover: pageCover;
	initialPage: pageMenu;

	property var messagesModel
	property bool appIsConnected: false
	property var networkType: 0

	Component.onCompleted: {
		pageStack.push (pageSessions, { }, PageStackAction.Immediate);
	}

	Component { id: pageMenu; MenuPage { } }
	Component { id: pageCover; CoverPage { } }
	Component { id: pageContacts; ContactsPage { } }
	Component { id: pageConversations; ConversationsPage { } }
	Component { id: pageSessions; SessionsPage { } }
	Component { id: pagePreferences; PreferencesPage { } }
	Component { id: pageAccount; AccountPage { } }
	Component { id: pageMessaging; MessagingPage { } }

	Component { id: pageVerification; VerificationCodePage { } }
	Component { id: pageSignIn; SignInPage { } }
	Component { id: pageAbout; AboutPage { } }
	Component { id: imagePicker; ImagePickerPage { } }

	ImagePickerPage {
        	id: pageImagePicker
	}

	function error(errorMsg) {
        	console.log(errorMsg)
        }

        function getPhoneNumber() {
                pageStack.push(pageSignIn)
        }
        function getVerificationCode() {
                pageStack.replace(pageVerification)
        }
        function registered() {
		pageStack.pop();
        }

	function hasConnection() {
	        if(wifi.available && wifi.connected) {
			networkType = 1
	            return true
	        }
	        if(cellular.available && cellular.connected) {
			networkType = 2
	            return true
	        }
	        if(ethernet.available && ethernet.connected) {
			networkType = 3
	            return true
	        }

        	return false
	}

    TechnologyModel {
        id: wifi
        name: "wifi"
        onConnectedChanged: {
		console.log("wifi changed!")
		if (wifi.connected)
		{
			console.log("wifi connected " + mainWindow.networkType)
			textsecure.connectEvent()
		}
		else
		{
			console.log("wifi DISconnected " + mainWindow.networkType)
			textsecure.disconnectEvent()
		}
            mainWindow.appIsConnected = mainWindow.hasConnection()
        }
    }

    TechnologyModel {
        id: cellular
        name: "cellular"
        onConnectedChanged: {
		console.log("cellular changed!")
		if (cellular.connected)
		{
			console.log("cellular connected")
			textsecure.connectEvent()
		}
		else
		{
			console.log("cellular DISconnected")
			textsecure.disconnectEvent()
		}
            mainWindow.appIsConnected = mainWindow.hasConnection()
        }
    }

    TechnologyModel {
        id: ethernet
        name: "ethernet"
        onConnectedChanged: {
		console.log("ethernet changed!")
		if (ethernet.connected)
		{
			console.log("ethernet connected")
			textsecure.connectEvent()
		}
		else
		{
			console.log("ethernet DISconnected")
			textsecure.disconnectEvent()
		}
            mainWindow.appIsConnected = mainWindow.hasConnection()
        }
    }
}

