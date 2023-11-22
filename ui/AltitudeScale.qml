import QtQuick 2.0

Item {
    property string canvasColor : "#09e421"

    property int verticalLength : 500
    property int horizontalLength : 20

    property int lineMarginRight : 25

    property int scaleLineLength : 5
    property int scaleLineVerticalSpacing : verticalLength / 10


    property double altitude : altitudeController.currentAltitude
    property int plusMinusOscillator: osscillatorController.plusMinusOscillator

    onPlusMinusOscillatorChanged: {
        altitudeCanvas.requestPaint();
        currentAltitudeCanvas.requestPaint();
    }

    Canvas {
        id: altitudeCanvas
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
            ctx.moveTo(width - lineMarginRight, height/2 - verticalLength/2);
            ctx.lineTo(width - lineMarginRight - horizontalLength, height/2 - verticalLength/2);
            ctx.lineTo(width - lineMarginRight - horizontalLength, height/2 + verticalLength/2);
            ctx.lineTo(width - lineMarginRight, height/2 + verticalLength/2);

            // Horizontal scale lines
            for (var i = 1; i < 11; i++) {
                // 3 small scale lines
                for (var j = 1; j < 4; j++) {
                    ctx.moveTo(width - lineMarginRight - horizontalLength, height/2 - verticalLength/2 + i * scaleLineVerticalSpacing - j * scaleLineVerticalSpacing/4);
                    ctx.lineTo(width - lineMarginRight - horizontalLength + scaleLineLength, height/2 - verticalLength/2 + i * scaleLineVerticalSpacing - j * scaleLineVerticalSpacing/4);
                }

                ctx.moveTo(width - lineMarginRight - horizontalLength, height/2 - verticalLength/2 + i * scaleLineVerticalSpacing);
                ctx.lineTo(width - lineMarginRight - horizontalLength + scaleLineLength * 2, height/2 - verticalLength/2 + i * scaleLineVerticalSpacing);
            
                // Altitude value
                if (i == 10) break;
                ctx.fillText(Math.round(10*(altitude + (5 - i)* 0.7))/10, width - lineMarginRight - horizontalLength + scaleLineLength * 2 + 5, height/2 - verticalLength/2 + i * scaleLineVerticalSpacing + 3);
            }

            ctx.stroke();
        }
    }

    Canvas {
        id: currentAltitudeCanvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.font = "13px Arial";
            ctx.strokeStyle = canvasColor;
            ctx.fillStyle = canvasColor;
            ctx.lineWidth = 1;
            ctx.beginPath();

            // Instant altitude on main line
            ctx.fillText(altitude, width - lineMarginRight - horizontalLength - 5, height/2 - verticalLength/2 - 5);

            // Current altitude indicator needle (triangle)
            ctx.moveTo(width - lineMarginRight - horizontalLength - 10, height/2 - 10 - plusMinusOscillator);
            ctx.lineTo(width - lineMarginRight - horizontalLength - 10, height/2 + 10 - plusMinusOscillator);
            ctx.lineTo(width - lineMarginRight - horizontalLength, height/2 - plusMinusOscillator);
            ctx.lineTo(width - lineMarginRight - horizontalLength - 10, height/2 - 10 - plusMinusOscillator);

            ctx.fill();

            ctx.stroke();
        }
    }
}
