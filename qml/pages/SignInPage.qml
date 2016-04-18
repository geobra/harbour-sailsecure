import QtQuick 2.0
import Sailfish.Silica 1.0
//import "../js/country_data.js" as CountryData
//import "../components"

Page {
    id: root
    property alias errorLabel: errorLabel
    //pageTitle: "Connect with Signal"

    objectName: "signInPage"
    //head.backAction.visible: false

    //onlineIndicationOnly: true

    Item {
        anchors {
            fill: parent
            //margins: units.gu(2)
        }

        Text {
            id: country
            text: "bla"
            anchors {
                top: parent.top
                //topMargin: units.gu(2)
            }
        }

/*
        OptionSelector {
            id: countrySelector
            anchors {
                top: country.bottom
                topMargin: units.gu(2)
            }
            containerHeight: itemHeight * 4

            onDelegateClicked: {
                var country = model[index]
                var tel = CountryData.name_to_tel[country]
                countryTextField.text = tel
                userTextField.defaultRegion = CountryData.tel_to_iso[tel]
                userTextField.focus = true
            }

            Component.onCompleted: {
                var countries = []
                for (var c in CountryData.name_to_tel) {
                    countries.push(c)
                }
                countrySelector.model = countries
                // lolz
                //countrySelector.selectedIndex = countries.indexOf('United States')

            }
        }
*/

        Text {
            id: countryCode
            text: "bla"
            anchors {
                top: country.bottom
                //topMargin: units.gu(2)
            }
        }

        Row {
            id: userEntryRow
            anchors {
                top: countryCode.bottom
                //topMargin: units.gu(2)
            }
            height: userTextField.itemHeight
            width: parent.width
            //spacing: units.gu(1)

            Label {
                id: label
                text: ":"
                //width: units.gu(2)
                //height: parent.height
                verticalAlignment: TextInput.AlignVCenter
                horizontalAlignment: TextInput.AlignHCenter
            }

/*
            TextField {
                id: countryTextField
                horizontalAlignment: TextInput.AlignHCenter
                width: units.gu(8)
                height: parent.height

                inputMethodHints: Qt.ImhDialableCharactersOnly
                placeholderText: {
                    CountryData.iso_to_tel[userTextField.defaultRegion]
                }

                KeyNavigation.tab: userTextField
                onDisplayTextChanged: {
                    var tel = countryTextField.text
                    var country = CountryData.tel_to_name[tel]
                    if (country !== "") {
                        countrySelector.selectedIndex = countrySelector.model.indexOf(country);
                    }
                    if (tel !== "") {
                        var iso = CountryData.tel_to_iso[tel];
                        if (typeof iso != "undefined") {
                            userTextField.defaultRegion = iso;
                        }
                    }
                }
            }
*/


            TextField {
            	anchors {
                	top: label.bottom
                	//topMargin: units.gu(2)
            	}
                id: userTextField
                horizontalAlignment: TextInput.AlignHCenter
                width: parent.width
                //height: parent.height

		placeholderText: qsTr("Your phone nr. E.g. +49 167 987654321")
                //updateOnlyWhenFocused: false
                //defaultRegion: "US"
                //autoFormat: userTextField.text.length > 0 && userTextField.text.charAt(0) !== "*" && userTextField.text.charAt(0) !== "#"
                inputMethodHints: Qt.ImhDialableCharactersOnly

                onTextChanged: clearError()
                Keys.onEnterPressed: done()
                Keys.onReturnPressed: done()
            }
        }

        Label {
            id: infoLabel
            anchors {
                top: userEntryRow.bottom
                //margins: units.gu(1)
                //topMargin: units.gu(4)
            }
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignLeft
            width: parent.width
            text: "Verify your phone number to connect with Signal."+"\n\n"+
                  "Registration transmits some contact information to the server. It is not stored."
        }

        Button {
            id: doneButton
            anchors {
                top: infoLabel.bottom
                //topMargin: units.gu(3)
                left: parent.left
                right: parent.right
            }
            enabled: userTextField.text !== ""
            text: "Register"
            onClicked: done()
        }

        Label {
            id: errorLabel
            anchors {
                top: infoLabel.bottom
                //margins: units.gu(1)
            }
            width: parent.width
            visible: false
            color: "red"
        }
    }

    signal numberEntered(string text)

    function done() {
        //if (busy) return;

        Qt.inputMethod.commit();
        Qt.inputMethod.hide();

        //busy = true
        var num = getPhoneNumber()

/*
        PopupUtils.open(Qt.resolvedUrl("dialogs/ConfirmationDialog.qml"),
        root, {
            title: num,
            text: "Double-check that this is your number! We're about to verify it with an SMS.",
            onAccept: function() {
                numberEntered(num)
            },
            onCancel: function() {
                busy = false
            }
        })
*/
	numberEntered(num)
    }

    function getPhoneNumber() {
	    var n = userTextField.text;
	    return n.replace(/[\s\-\(\)]/g, '')
    }

    function setError(message) {
        errorLabel.text = message;
        errorLabel.visible = true;
    }

    function clearError() {
        if (errorLabel.visible) {
            errorLabel.visible = false;
            errorLabel.text = "";
        }
    }
}
