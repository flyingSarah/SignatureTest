import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

ApplicationWindow
{
    visible: true

    minimumWidth: 480
    minimumHeight: 480
    maximumWidth: 480
    maximumHeight: 480

    title: qsTr("Signature Test")

    Connections
    {
        target: postSignature
        onSignatureReply: {
            busyIndicator.running = false;
            if(status)
            {
                postRequestFailedDialog.detailedText = error;
                postRequestFailedDialog.open();
            }
            else
            {
                postRequestSuccessDialog.open()
            }
        }
    }

    ColumnLayout
    {
        width: 440
        x: (parent.width - width) / 2
        anchors.verticalCenter: parent.verticalCenter

        spacing: 10

        Layout.fillHeight: true

        //in a real app this would display the amount the user is paying
        Text
        {
            Layout.fillWidth: true
            height: 50

            text: "Payment Amount: € 00,00"
            color: "#444444"
        }

        SignCanvas
        {
            id: signCanvas

            Layout.fillWidth: true
            height: 350
        }

        Button
        {
            id: payButton

            Layout.fillWidth: true
            height: 50

            text: qsTr("pay")

            contentItem: Text {
                text: payButton.text
                color: "#444444"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            background: Rectangle {
                color: payButton.down ? "gray" : "light gray"
            }

            onClicked: {
                var gesture = signCanvas.getGesture();
                if(gesture.length < 1)
                {
                    emptyCanvasOnPayDialog.open();
                }
                else
                {
                    busyIndicator.running = true;

                    var parsedData = postSignature.parseData(gesture, signCanvas.signDuration, signCanvas.countClearClicks);
                    postSignature.sendPostRequest(parsedData);
                }
                signCanvas.reset();
            }
        }
    }

    // ----------------------------------------------------- Message Dialogs

    MessageDialog
    {
        id: emptyCanvasOnPayDialog

        text: qsTr("Empty Signature Error")
        informativeText: qsTr("Please sign in the space provided.")
        icon: StandardIcon.Warning
        onAccepted: close()
    }

    MessageDialog
    {
        id: postRequestFailedDialog
        text: qsTr("Network Error")
        informativeText: qsTr("The request to send your signature failed. Please try again.")
        icon: StandardIcon.Critical
        onAccepted: close()
    }

    MessageDialog
    {
        id: postRequestSuccessDialog
        text: qsTr("Success!")
        informativeText: qsTr("Your signature has been sent.")
        icon: StandardIcon.Information
        onAccepted: close()
    }

    BusyIndicator {
        id: busyIndicator

        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height / 3

        running: false
    }
}
