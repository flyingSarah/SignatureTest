import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.2

ApplicationWindow
{
    visible: true

    width: 480
    height: 480

    title: qsTr("Signature Test")

    SignCanvas
    {
        width: 440
        height: 350
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
    }
}
