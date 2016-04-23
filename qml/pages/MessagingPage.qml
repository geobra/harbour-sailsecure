import QtQuick 2.0
import QtQuick.Window 2.0;
import Sailfish.Silica 1.0

Page {
    allowedOrientations: Orientation.All

    id: page;

    // remove the active session from textsecure api on PageBack
    onStatusChanged: {
         if (status == PageStatus.Deactivating) {
             if (_navigation == PageNavigation.Back) {
		textsecure.activeSessionID = ""
             }
         }
     }

    property string conversationId : "";

    Image {
        //source: "image://glass/qrc:///qml/img/photo.png";
        //source: "../img/avatar.png";
        //source: "image://glass/file:///tmp/tst.png";
        opacity: 0.85;
        sourceSize: Qt.size (Screen.width, Screen.height);
        asynchronous: false
        anchors.centerIn: parent;
    }
    Item {
        id: banner;
        height: Theme.itemSizeLarge;
        anchors {
            top: parent.top;
            left: parent.left;
            right: parent.right;
        }

        Rectangle {
            z: -1;
            color: "black";
            opacity: 0.15;
            anchors.fill: parent;
        }
        Image {
            id: avatar;
            width: Theme.iconSizeMedium;
            height: width;
            smooth: true;
            source: "qrc:///qml/img/avatar.png";
            fillMode: Image.PreserveAspectCrop;
            antialiasing: true;
            anchors {
                right: parent.right;
                margins: Theme.paddingMedium;
                verticalCenter: parent.verticalCenter;
            }

            Rectangle {
                z: -1;
                color: "black";
                opacity: 0.35;
                anchors.fill: parent;
            }
        }
        Column {
            anchors {
                right: avatar.left;
                margins: Theme.paddingMedium;
                verticalCenter: parent.verticalCenter;
            }

            Label {
                text:  messagesModel.name;
                color: Theme.highlightColor;
                font {
                    family: Theme.fontFamilyHeading;
                    pixelSize: Theme.fontSizeLarge;
                }
                anchors.right: parent.right;
            }
            Label {
                text: qsTr ("last seen ") + messagesModel.when;
                color: Theme.secondaryColor;
                font {
                    family: Theme.fontFamilyHeading;
                    pixelSize: Theme.fontSizeTiny;
                }
                anchors.right: parent.right;
            }
        }
    }
    SilicaListView {
        id: view;
        clip: true;
	rotation: 180

	model: messagesModel.len

        header: Item {
            height: view.spacing;
            anchors {
                left: parent.left;
                right: parent.right;
            }
        }
        footer: Item {
            height: view.spacing;
            anchors {
                left: parent.left;
                right: parent.right;
            }
        }
        spacing: Theme.paddingMedium;
        delegate: Item {
		rotation: 180
            id: item;
            height: shadow.height;
            anchors {
                left: parent.left;
                right: parent.right;
                margins: view.spacing;
            }

            readonly property bool alignRight      : (! msg.outgoing);
            readonly property int  maxContentWidth : (width * 0.85);

		property int ii: messagesModel.len - 1 - index
                property var msg: messagesModel.messages(ii)

//	Component.onCompleted: {
//		listProperty(msg)	
//	}

            Rectangle {
                id: shadow;
                color: "white";
                radius: 3;
                opacity: (item.alignRight ? 0.05 : 0.15);
                antialiasing: true;
                anchors {
                    fill: layout;
                    margins: -Theme.paddingSmall;
                }
            }
            Column {
                id: layout;
                anchors {
                    left: (item.alignRight ? parent.left : undefined);
                    right: (!item.alignRight ? parent.right : undefined);
                    margins: -shadow.anchors.margins;
                    verticalCenter: parent.verticalCenter;
                }

                Text {
                    text: (visible ? msg.message || "" : "");
                    color: Theme.primaryColor;
                    width: Math.min (item.maxContentWidth, contentWidth);
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
                    visible: (msg.cType === 0);
                    font {
                        family: Theme.fontFamilyHeading;
                        pixelSize: Theme.fontSizeMedium;
                    }
                    anchors {
                        left: (item.alignRight ? parent.left : undefined);
                        right: (!item.alignRight ? parent.right : undefined);
                    }
                }
                Image {
                    source: (visible ? msg.attachment || "" : "");   // FIXME!
                    width: Math.min (item.maxContentWidth, sourceSize.width);
                    fillMode: Image.PreserveAspectFit;
                    visible: (msg.cType === 2);
                    anchors {
                        left: (item.alignRight ? parent.left : undefined);
                        right: (!item.alignRight ? parent.right : undefined);
                    }
                }
                Label {
		    text: getReceivedMessageTimeAndName(item, msg)
                    color: Theme.secondaryColor;
                    font {
                        family: Theme.fontFamilyHeading;
                        pixelSize: Theme.fontSizeTiny;
                    }
                    anchors {
                        left: (item.alignRight ? parent.left : undefined);
                        right: (!item.alignRight ? parent.right : undefined);
                    }
                }
		Image {
			source: getMessageStatus(msg) 
		}
            }
        }
        anchors {
            top: banner.bottom;
            left: parent.left;
            right: parent.right;
            bottom: sendmsgview.top;
        }
    }


	Row {
		id: sendmsgview
       		anchors {
     			left: parent.left;
       			right: parent.right;
       			bottom: parent.bottom;
       		}

		TextArea {
//			anchors {
//        	            bottom: parent.bottom
//                	    left: parent.left
//                	}
        		id: editbox;
			width: parent.width - 100 
        		placeholderText: qsTr ("Enter message...");
    		}

		Button {
//			anchors {
//        	            bottom: parent.bottom
//                	    right: parent.right
//                	}

			id: sendButton
			text: "Send"
			width: 100
			onClicked: {
				sendMessage(editbox.text);
			}
		}
	}

        function listProperty(item)
        {
                 for (var p in item)
                        console.log(p + ": " + item[p]);
        }

	function sendMessage(text) {
        	if (text.length === 0) return;
        	editbox.text = "";
        	textsecure.sendMessage(messagesModel.tel, text);

		//var info = textsecure.groupInfo(messagesModel.tel)
		//console.log(info)
    	}

	function getReceivedMessageTimeAndName(item, msg)
	{
		var returnText = "";
		if (messagesModel.isGroup)
		{
			returnText = "(" + msg.name() + ")";
		}

		/*
                returnText += (item.alignRight ? 
			Qt.formatDateTime (new Date (msg.receivedAt || ""), "hh:mm:ss") : Qt.formatDateTime (new Date (msg.sentAt || ""), "hh:mm:ss"));
		*/
                returnText += Qt.formatDateTime (new Date (msg.sentAt || ""), "hh:mm:ss") + " -> " + Qt.formatDateTime (new Date (msg.receivedAt || ""), "hh:mm:ss");

		return returnText;
	}
	
	function getMessageStatus(msg) {
		var returnText = "";
		if (msg.isRead) {
			return "../img/Checks2_2x_white.png";
			//console.log("isRead!");
		} 
		else if (msg.isSent) { 
			//console.log("isSent!");
			returnText = "../img/Checks1_2x_white.png";
		}
		return returnText;
	}
}
