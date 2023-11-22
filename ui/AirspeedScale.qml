import QtQuick 2.0

Item {
    readonly property string canvasColor : "#09e421"

    readonly property int verticalLength : 500
    readonly property int horizontalLength : 20

    readonly property int lineMarginLeft : 25

    readonly property int scaleLineLength : 5
    readonly property int scaleLineVerticalSpacing : verticalLength / 10
    
    property int plusMinusOscillator: osscillatorController.plusMinusOscillator
    property int instantAirSpeed : airspeedController.currentAirspeed


    onPlusMinusOscillatorChanged: {
        airSpeedCanvas.requestPaint();
        currentAirSpeedCanvas.requestPaint();
    }

    
    Canvas {
        id: airSpeedCanvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.font = "10px Arial";
            ctx.strokeStyle = canvasColor;
            ctx.fillStyle = canvasColor;
            ctx.lineWidth = 1;
            ctx.beginPath();
            
            // Main line
            ctx.moveTo(lineMarginLeft, height/2 - verticalLength/2);
            ctx.lineTo(lineMarginLeft + horizontalLength, height/2 - verticalLength/2);
            ctx.lineTo(lineMarginLeft + horizontalLength, height/2 + verticalLength/2);
            ctx.lineTo(lineMarginLeft, height/2 + verticalLength/2);

            // Horizontal scale lines
            for (var i = 1; i < 11; i++) {
                // 3 small scale lines
                for (var j = 1; j < 4; j++) {
                    ctx.moveTo(lineMarginLeft + horizontalLength, height/2 - verticalLength/2 + i * scaleLineVerticalSpacing - j * scaleLineVerticalSpacing/4);
                    ctx.lineTo(lineMarginLeft + horizontalLength - scaleLineLength, height/2 - verticalLength/2 + i * scaleLineVerticalSpacing - j * scaleLineVerticalSpacing/4);
                }

                ctx.moveTo(lineMarginLeft + horizontalLength, height/2 - verticalLength/2 + i * scaleLineVerticalSpacing);
                ctx.lineTo(lineMarginLeft + horizontalLength - scaleLineLength*2.5, height/2 - verticalLength/2 + i * scaleLineVerticalSpacing);
                
                // Airspeed value
                if (i == 10) break;
                ctx.fillText(instantAirSpeed + (5 - i)* 9, lineMarginLeft + horizontalLength - scaleLineLength*2.5 - 21, height/2 - verticalLength/2 + i*scaleLineVerticalSpacing + 3);
            }

            ctx.stroke();
        }
    }

    Canvas {
        id: currentAirSpeedCanvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.font = "13px Arial";
            ctx.strokeStyle = canvasColor;
            ctx.fillStyle = canvasColor;
            ctx.lineWidth = 1;
            ctx.beginPath();

            // Instant airspeed on main line
            ctx.fillText(instantAirSpeed, lineMarginLeft, height/2 - verticalLength/2 - 5);

            // Current airspeed indicator needle (triangle)
            ctx.moveTo(lineMarginLeft + horizontalLength, height/2 + plusMinusOscillator);
            ctx.lineTo(lineMarginLeft + horizontalLength + 10, height/2 - 10 + plusMinusOscillator);
            ctx.lineTo(lineMarginLeft + horizontalLength + 10, height/2 + 10 + plusMinusOscillator);
            ctx.lineTo(lineMarginLeft + horizontalLength, height/2 + plusMinusOscillator);

            context.fill();

            ctx.stroke();
        }
    }
}
