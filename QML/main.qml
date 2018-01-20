import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ApplicationWindow
{
    visible: true

    width: 480
    height: 480

    title: qsTr("Signature Test")

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
            Layout.fillWidth: true
            height: 350
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
        }

    }
}
