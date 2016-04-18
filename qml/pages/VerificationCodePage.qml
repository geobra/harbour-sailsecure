import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    property alias codeTextField: codeTextField
    property alias errorLabel: errorLabel
    property alias countdownText: countdownLabel.text
    property alias countdownTimer: countdownTimer
	property bool busy: false

    id: page
    //head.backAction.visible: false
    objectName: "codeVerificationPage"
    //PageHeader: { title: "Verifying number" }
    //onlineIndicationOnly: true

    SilicaFlickable {
        anchors {
            fill: parent
            //margins: units.gu(2)
        }

        Label {
            id: infoLabel
            anchors {
                top: parent.top
                //margins: units.gu(1)
            }
            width: parent.width
            text: "Signal will now automatically verify your number with a confirmation SMS message."
        }

        Label {
            id: countdownLabel
            anchors {
                top: infoLabel.bottom
                //topMargin: units.gu(1)
            }
            width: parent.width
            // TRANSLATORS: the argument refers to a countdown time
            text: "Waiting for SMS verification..." + " " + countdownTimer.getTimeAsText()
        }

        Label {
            id: errorLabel
            anchors {
                top: countdownLabel.bottom
                //topMargin: units.gu(1)
            }
            width: parent.width
            visible: false
            color: "red"
        }

        TextField {
            id: codeTextField
            anchors {
                top: errorLabel.bottom
                //topMargin: units.gu(1)
                left: parent.left
                right: parent.right
            }
            inputMethodHints: Qt.ImhDigitsOnly

            validator: RegExpValidator {
                regExp: /[\w]+/
            }
            placeholderText: "Code"

            Keys.onEnterPressed: done()
            Keys.onReturnPressed: done()

            horizontalAlignment: TextInput.AlignHCenter

            Component.onCompleted: {
                forceActiveFocus();
            }
        }

        Button {
            id: doneButton
            anchors {
                top: codeTextField.bottom
                //topMargin: units.gu(1)
                right: parent.right
                left: parent.left
            }
            width: parent.width

            text: "OK"
            onClicked: done()
        }
    }

    Timer {
        id: countdownTimer
        readonly property int timeToCall: 120
        property int seconds: timeToCall
        property int timeStarted: 0
        interval: 1000
        repeat: true
        running: false

        onTriggered: {
            seconds = Math.max(0, timeToCall - (Date.now() / 1000 - timeStarted));
            countdownLabel.text = "Waiting for SMS verification..."+ " "+getTimeAsText();
            if (seconds <= 0) {
                stop();
            }
        }

        Component.onCompleted: startTimer()

        function getTimeAsText() {
            var min = Math.floor(seconds / 60);
            var sec = (seconds % 60).toString()

            var pad = "00";
            sec = pad.substring(0, pad.length - sec.length) + sec;
            return min + ':' + sec;
        }
    }

    signal error(int id, int errorCode, int errorText);
    signal authSignInError();
    signal authLoggedIn();
    signal calling();

    onCalling: {
        countdownLabel.text = "Calling you (this may take a while)...";
    }

    onError: {
        if (errorCode === 420) {
            setError("Please wait a moment and try again");
        } else if (errorCode === 400) {
            // handled in onAuthSignInError
        } else {
            console.log("VerificationCode error: " + errorCode + " " + errorText);
        }
        busy = false;
    }

    onAuthSignInError: {
        setError("Incorrect code. Please try again.");
        busy = false;
    }

    Component.onCompleted: {
    }

    Component.onDestruction: {
    }

    function startTimer() {
        countdownTimer.seconds = countdownTimer.timeToCall;
        countdownTimer.timeStarted = Date.now() / 1000;
        countdownTimer.start();
    }

    function stopTimer() {
        countdownTimer.stop();
    }

    signal codeEntered(string text)

    function done() {
        if (busy) return;

        Qt.inputMethod.commit();
        Qt.inputMethod.hide();

        if (codeTextField.text.length > 0) {
            busy = true;
            clearError();
	    countdownTimer.running = false;
	    codeEntered(codeTextField.text);
        }
    }

    function onError(errorMessage) {
        countdownTimer.running = true;
        codeTextField.text = "";
        busy = false;
        setError(errorMessage);
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
