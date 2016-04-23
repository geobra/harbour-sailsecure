import QtQuick 2.0
import Sailfish.Silica 1.0

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
                title: qsTr ("Contacts");
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

	model: contactsModel.len

        delegate: ListItem {
            id: item;
            contentHeight: Theme.itemSizeMedium;
            //onClicked: { pageStack.push (pageMessaging, { "conversationId" : "123" }); }
            onClicked: { openChatById(contact.name, contact.tel) }

	property var contact : contactsModel.contact(index)

            Image {
                id: img;
                width: height;
                source: contact.photo
                anchors {
                    top: parent.top;
                    left: parent.left;
                    bottom: parent.bottom;
                }

                Rectangle {
                    z: -1;
                    color: (model.index % 2 ? "black" : "white");
                    opacity: 0.15;
                    anchors.fill: parent;
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
                    text: contact.name
                    color: (item.highlighted ? Theme.highlightColor : Theme.primaryColor);
                    font.pixelSize: Theme.fontSizeMedium;
                }
                Label {
                    id: details;
                    text: contact.tel
                    color: Theme.secondaryColor;
                    font.pixelSize: Theme.fontSizeSmall;
                }
            }
        }        anchors.fill: parent;

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


