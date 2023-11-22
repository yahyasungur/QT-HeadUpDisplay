import QtQuick 2.0

Item {
    property string canvasColor : "#09e421"

    property int headingScaleArcRadius : 400

    property int instantHeading : headingController.currentHeading

    onInstantHeadingChanged: {
        headingScaleCanvas.requestPaint();
        currentHeadingCanvas.requestPaint();
    }

    Canvas {
        id: headingScaleCanvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.font = "bold 10px Arial";
            ctx.strokeStyle = canvasColor;
            ctx.fillStyle = canvasColor;
            ctx.lineWidth = 1;
            ctx.beginPath();

            // 50 degree arc
            ctx.arc(width/2, height/2-50, headingScaleArcRadius, 6.5*Math.PI/18, 11.5*Math.PI/18, false);

            // Scale lines with 2.5 degree spacing
            var scaleFactor = 0;
            for (var i = 0; i < 21; i++) {
                if(i == 0 || i == 20) scaleFactor = 25;
                else if (i % 2 == 0) scaleFactor = 10;
                else scaleFactor = 5;

                ctx.moveTo(width/2 + (headingScaleArcRadius + scaleFactor)*Math.cos(6.5*Math.PI/18 + i*2.5*Math.PI/180),
                            height/2 - 50 + (headingScaleArcRadius + scaleFactor)*Math.sin(6.5*Math.PI/18 + i*2.5*Math.PI/180));
                ctx.lineTo(width/2 + headingScaleArcRadius*Math.cos(6.5*Math.PI/18 + i*2.5*Math.PI/180),
                            height/2 - 50 + headingScaleArcRadius*Math.sin(6.5*Math.PI/18 + i*2.5*Math.PI/180));
            
                // Scale numbers
                if(scaleFactor == 10)
                {
                    ctx.fillText(instantHeading + (5 - i/2), width/2 + (headingScaleArcRadius + scaleFactor + 12)*Math.cos(6.5*Math.PI/18 + i*2.5*Math.PI/180) - 5,
                            height/2 - 50 + (headingScaleArcRadius + scaleFactor + 12)*Math.sin(6.5*Math.PI/18 + i*2.5*Math.PI/180));
                }
            }

            ctx.stroke();
        }
    }

    Canvas {
        id: currentHeadingCanvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.font = "14px Arial";
            ctx.strokeStyle = canvasColor;
            ctx.fillStyle = canvasColor;
            ctx.lineWidth = 1;
            ctx.beginPath();

            // Current heading text
            ctx.fillText(instantHeading, width/2 - 8, height/2 - 50 + headingScaleArcRadius - 18);

            // Needle
            ctx.moveTo(width/2, height/2 - 50 + headingScaleArcRadius);
            ctx.lineTo(width/2 - 10, height/2 - 50 + headingScaleArcRadius - 10);
            ctx.lineTo(width/2 + 10, height/2 - 50 + headingScaleArcRadius - 10);
            ctx.lineTo(width/2, height/2 - 50 + headingScaleArcRadius);
            
            ctx.fill();

            ctx.stroke();
        }
    }
}
