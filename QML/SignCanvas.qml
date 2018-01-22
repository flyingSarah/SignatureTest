import QtQuick 2.0
import QtQuick.Controls 2.2

import com.swhitley.classes 1.0

Rectangle
{
    id: canvasContainer

    property var segment: []
    property double signStartTime: 0
    property int signEndTime: 0

    property int countClearClicks: 0

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
                if(signStartTime == 0)
                {
                    signStartTime = new Date().getTime();
                }

                segment = [];
                parent.context.beginPath();
            }
            onReleased: {
                signEndTime = new Date().getTime() - signStartTime;

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
            countClearClicks++;
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

    function onPay()
    {
        //reset timer
        signStartTime = 0;
        //reset clear count
        countClearClicks = 0;

        clearCanvas();
    }

    function getSignEndTime()
    {
        return signEndTime;
    }
}
