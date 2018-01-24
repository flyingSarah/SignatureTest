import QtQuick 2.0
import QtQuick.Controls 2.2

import com.swhitley.classes 1.0

Rectangle
{
    id: canvasContainer

    property var segment: []
    property double signStartTime: 0
    property int signDuration: 0

    property int countClearClicks: 0

    border.width: 1
    border.color: "light gray"

    Gesture
    {
        id: signGesture
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
        color: "#444444"
        readOnly: true
    }

    Canvas
    {
        id: canvas

        property int xpos
        property int ypos
        property int prevX
        property int prevY
        property double timestamp: 0
        property double velocity: 0
        property bool triggerReset

        anchors.fill: parent

        onPaint: {
            var context = getContext("2d");

            if(triggerReset)
            {
                triggerReset = false;
                context.reset();
                return;
            }

            context.lineJoin = "round";
            context.lineCap = "round";
            context.strokeStyle = "#444444";

            velocity = calculateVelocity(prevX, prevY, xpos, ypos, timestamp);
            var varyingLineWidth = Math.min(.5 / velocity, 2.5) + 1.7;

            context.lineWidth = varyingLineWidth;
            context.beginPath();
            context.moveTo(prevX, prevY);
            context.lineTo(xpos, ypos);
            context.stroke();
            timestamp = new Date().getTime();

            segment.push(xpos, ypos);
            prevX = xpos;
            prevY = ypos;
        }

        MouseArea
        {
            anchors.fill: parent

            onPressed: {
                parent.prevX = mouseX;
                parent.prevY = mouseY;
                segment = [];
                segment.push(parent.prevX, parent.prevY);
                parent.timestamp = new Date().getTime();

                if(signStartTime == 0)
                {
                    signStartTime = new Date().getTime();
                }
            }
            onReleased: {
                parent.xpos = mouseX;
                parent.ypos = mouseY;
                parent.requestPaint();

                signDuration = new Date().getTime() - signStartTime;
                signGesture.appendSegment(segment);
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

        text: qsTr("clear")

        contentItem: Text {
            text: clearButton.text
            color: "#444444"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

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

    function clearCanvas()
    {
        canvas.triggerReset = true;
        canvas.requestPaint();

        segment = [];
        signGesture.clear();
    }

    function reset()
    {
        signStartTime = 0;
        countClearClicks = 0;
        clearCanvas();
    }

    function getGesture()
    {
        return signGesture.getGesture();
    }

    function calculateVelocity(prevX, prevY, xpos, ypos, timestamp)
    {
        var xDist = xpos - prevX;
        var yDist = ypos - prevY;
        var interval = new Date().getTime() - timestamp;
        var velocity = Math.sqrt(xDist*xDist+yDist*yDist)/interval;
        return velocity;
    }
}
