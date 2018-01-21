import QtQuick 2.0
import QtQuick.Controls 2.2

Rectangle
{
    id: canvasContainer

    property var segment: []

    signal addSegmentToGesture(var segment);
    signal clearGesture();

    border.width: 1
    border.color: "light gray"

    Canvas
    {
        id: canvas

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

            segment.push(xpos);
            segment.push(ypos);
        }

        MouseArea
        {
            anchors.fill: parent

            onPressed: {
                segment = []
                parent.context.beginPath();
            }
            onReleased: {
                addSegmentToGesture(segment);
            }
            onPositionChanged: {
                parent.xpos = mouseX;
                parent.ypos = mouseY;
                parent.requestPaint();
            }
        }
    }

    Button
    {
        id: clearButton

        width: 50
        height: 30

        anchors.right: parent.right

        text: "clear"

        background: Rectangle {
            color: clearButton.down ? "light gray" : "white"
            border.width: canvasContainer.border.width
            border.color: canvasContainer.border.color
        }

        onClicked: {
            clearCanvas();
        }
    }

    TextArea
    {
        width: parent.width - 20
        height: 100
        anchors.bottom: parent.bottom
        x: 10

        //in a real app this would display the name of the merchant
        text: "X_________________________________________________________________" +
              "\n\nI agree to pay the above amount to <NAME_OF_MERCHANT>.";
    }

    function clearCanvas()
    {
        canvas.context.reset();
        canvas.requestPaint();
        segment = [];
        clearGesture();
    }
}
