import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "cover"

ApplicationWindow {

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
}

