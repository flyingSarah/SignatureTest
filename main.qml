import QtQuick 2.6
import QtQuick.Window 2.2

Window
{
    visible: true
    width: 480
    height: 480
    title: qsTr("Signature Test")

    Rectangle
    {
        width: 440
        height: 380

        border.width: 2
        border.color: "gray"

        Canvas
        {
            id: sigCanvas

            property int xpos
            property int ypos
            property var context

            anchors.fill: parent

            onPaint: {
                context = getContext("2d");

                context.strokeStyle = "black";
                context.lineWidth = 1;
                context.lineTo(xpos, ypos);
                context.stroke();
            }

            MouseArea
            {
                anchors.fill: parent

                onPressed: {
                    parent.context.beginPath();
                }
                onReleased: {
                    parent.context.closePath();
                }
                onPositionChanged: {
                    parent.xpos = mouseX;
                    parent.ypos = mouseY;
                    parent.requestPaint();
                }
            }
        }
    }
}
