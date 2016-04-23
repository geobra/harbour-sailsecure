import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.notifications 1.0

Page {
    id: page;

    SilicaListView {
        header: Column {
            spacing: Theme.paddingMedium;
            anchors {
                left: parent.left;
                right: parent.right;
            }

            PageHeader {
                title: qsTr ("Conversations");
            }
/*
            SearchField {
                placeholderText: qsTr ("Filter");
                anchors {
                    left: parent.left;
                    right: parent.right;
                }
            }
*/
        }

	model: sessionsModel.len

        delegate: ListItem {
            id: item;
            contentHeight: Theme.itemSizeMedium;
            onClicked: { openChatById(ses.name, ses.tel) }

	property var ses: sessionsModel.session(index)

            Image {
                id: img;
                width: height;
                //source: ses.photo
                anchors {
                    top: parent.top;
                    left: parent.left;
                    bottom: parent.bottom;
                }

                Rectangle {
                    z: -1;
                    //color: (model.index % 2 ? "black" : "white");
                    color: (sessionsModel.get(ses.tel).unread === 0 ? "white" : "yellow");
                    opacity: 0.5;
                    anchors.fill: parent;
			Text {
				font.pixelSize: 80 // FIXME
				color: "black"
				text: sessionsModel.get(ses.tel).unread
			}			
                }
            }
            Column {
                anchors {
                    left: img.right;
                    margins: Theme.paddingMedium;
                    verticalCenter: parent.verticalCenter;
                }

                Label {
                    id: lbl;
                    text: ses.name
                    color: (item.highlighted ? Theme.highlightColor : Theme.primaryColor);
                    font.pixelSize: Theme.fontSizeMedium;
                }
                Label {
                    id: details;
                    text: sessionsModel.get(ses.tel).last
                    color: Theme.secondaryColor;
                    font.pixelSize: Theme.fontSizeSmall;
		}
            }

		Component.onCompleted: {
			//listProperty(contact)			
			//var msgModel = sessionsModel.get(ses.tel)
			//console.log(msgModel.unread)
		}
        }
        anchors.fill: parent;

/*
        PullDownMenu {
            MenuItem {
                text: qsTr ("Add new contact...");
            }
        }
*/
    }

    function openChatById(chatId, tel, properties) {
                if (typeof properties === "undefined") properties = { };
                textsecure.activeSessionID = tel
                textsecure.markSessionsRead(tel)
                messagesModel = sessionsModel.get(tel);
//		listProperty(sessionsModel)
                properties['chatId'] = uid(tel);
                pageStack.push(pageMessaging, properties)
        }

        function uid(tel) {
                return parseInt(tel.substring(3, 10), 16)
        }

        function listProperty(item)
        {
                 for (var p in item)
                        console.log(p + ": " + item[p]);
        }

}


