import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

import com.swhitley.classes 1.0

ApplicationWindow
{
    visible: true

    minimumWidth: 480
    minimumHeight: 480
    maximumWidth: 480
    maximumHeight: 480

    title: qsTr("Signature Test")

    Gesture
    {
        id: signGesture
    }

    SignTimer
    {
        id: signTimer
    }

    PostSignature
    {
        id: postSignature
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
        }

        SignCanvas
        {
            id: signCanvas

            Layout.fillWidth: true
            height: 350

            onClearGesture: signGesture.clear()
            onAddSegmentToGesture: signGesture.appendSegment(segment)

            onStartTimer: signTimer.start();
            onSetLastTimestamp: signTimer.setSignTime();
            onStopTimer: signTimer.stop();
        }

        Button
        {
            id: payButton

            Layout.fillWidth: true
            height: 50

            text: "pay"

            background: Rectangle {
                color: payButton.down ? "gray" : "light gray"
            }

            onClicked: {
                var gesture = signGesture.getGesture();
                if(gesture.length < 1)
                {
                    emptyCanvasOnPayDialog.open();
                }
                else
                {
                    var parsedData = postSignature.parseData(gesture, signTimer.getSignTime(), signCanvas.countClearClicks);
                    postSignature.sendPostRequest(parsedData);
                }
                signCanvas.onPay();
            }
        }
    }

    MessageDialog
    {
        id: emptyCanvasOnPayDialog

        text: "Empty Signature Error"
        informativeText: "Please sign in the space provided."
        icon: StandardIcon.Warning
        onAccepted: close()
    }
}
