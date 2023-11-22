import QtQuick 2.0

Item {
    readonly property string canvasColor : "#09e421"

    readonly property int xPosition : width / 2 - 250
    readonly property int yPosition : height / 2 - 300
    
    readonly property int arcRadius : 40
    
    property double instantG : gController.currentG

    onInstantGChanged: {
        gMeterCanvas.requestPaint();
        currentGCanvas.requestPaint();
    }
    

    Canvas {
        id: gMeterCanvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.font = "10px sans-serif";
            ctx.fillStyle = canvasColor;
            ctx.strokeStyle = canvasColor;
            ctx.lineWidth = 1;
            ctx.beginPath();

            // Half circle
            ctx.arc(xPosition, yPosition, arcRadius, 0, Math.PI, true);

            // Scale lines per 36 degrees
            ctx.moveTo(xPosition - arcRadius, yPosition);
            for (var i = 0; i < 6; i++) {
                ctx.moveTo(xPosition - Math.cos(Math.PI / 5 * i) * (arcRadius - 2), yPosition - Math.sin(Math.PI / 5 * i) * (arcRadius - 2));
                ctx.lineTo(xPosition - Math.cos(Math.PI / 5 * i) * (arcRadius + 3), yPosition - Math.sin(Math.PI / 5 * i) * (arcRadius + 5));
            
                // Scale numbers
                ctx.fillText(Math.round(instantG - (i - 2.5)), xPosition - Math.cos(Math.PI / 5 * i) * (arcRadius + 10) - 4, yPosition - Math.sin(Math.PI / 5 * i) * (arcRadius + 10));
            }

            ctx.stroke();
        }
    }

    Canvas {
        id: currentGCanvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.font = "15px Arial";
            ctx.fillStyle = canvasColor;
            ctx.strokeStyle = canvasColor;
            ctx.lineWidth = 1;
            ctx.beginPath();

            // Current G text
            ctx.fillText(instantG + " G", xPosition - 18, yPosition - 2);

            // Needle
            ctx.moveTo(xPosition - 10, yPosition - arcRadius + 12);
            ctx.lineTo(xPosition + 10, yPosition - arcRadius + 12);
            ctx.lineTo(xPosition, yPosition - arcRadius + 2);
            ctx.lineTo(xPosition - 10, yPosition - arcRadius + 12);
            
            ctx.fill();

            ctx.stroke();
        }
    }
}
