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
        property bool triggerBeginPath
        property bool triggerReset

        anchors.fill: parent

        onPaint: {
            var context = getContext("2d");

            if(triggerBeginPath)
            {
                triggerBeginPath = false;
                context.beginPath();
            }
            if(triggerReset)
            {
                triggerReset = false;
                context.reset();
            }

            context.strokeStyle = "black";
            context.lineWidth = 1;
            context.lineTo(xpos, ypos);
            context.stroke();

            segment.push(xpos, ypos);
        }

        MouseArea
        {
            anchors.fill: parent

            onPressed: {
                parent.xpos = mouseX;
                parent.ypos = mouseY;

                if(signStartTime == 0)
                {
                    signStartTime = new Date().getTime();
                }
                segment = [];
                parent.triggerBeginPath = true;
                parent.requestPaint();
            }
            onReleased: {
                parent.xpos = mouseX;
                parent.ypos = mouseY;
                parent.requestPaint();

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
        canvas.triggerReset = true;
        canvas.requestPaint();

        segment = [];
        clearGesture();
    }

    function reset()
    {
        signStartTime = 0;
        countClearClicks = 0;
        clearCanvas();
    }
}
