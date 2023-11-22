import QtQuick 2.0


Rectangle {
    width: 512
    height: 512
    color: "#00000000"

    // properties
    readonly property string canvasColor : "#09e421";

    readonly property int lineVerticalSpacing : 80
    readonly property int lineHorizontalSpacing : 30
    
    readonly property int dashLineWidth : 18
    readonly property int dashSpacing : 8
    
    readonly property int lineMargin : 100
    
    readonly property int leftHalfEnd : width/2 - lineHorizontalSpacing/2
    readonly property int rightHalfStart : width/2 + lineHorizontalSpacing/2

    readonly property int aimCursorRadius : 45

    property int uppestLineValue : ladderController.pitchValue
    property int upperLineValue : uppestLineValue - 5
    property int lowerLineValue : uppestLineValue - 15
    property int lowestLineValue : uppestLineValue - 20

    onUpperLineValueChanged: canvas.requestPaint();


    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.strokeStyle = canvasColor;
            ctx.lineWidth = 2;
            ctx.beginPath();

            for(var i = 1; i < 3; i++) // 2 undashed lines
            {
                ctx.moveTo(lineMargin*(i+1), height/2 - lineVerticalSpacing*i);
                ctx.lineTo(leftHalfEnd, height/2 - lineVerticalSpacing*i);
                ctx.moveTo(rightHalfStart, height/2 - lineVerticalSpacing*i);
                ctx.lineTo(width - lineMargin*(i+1), height/2 - lineVerticalSpacing*i);
            }

            // middle line
            ctx.moveTo(lineMargin + 30, height/2);
            ctx.lineTo(leftHalfEnd - aimCursorRadius, height/2);
            ctx.moveTo(rightHalfStart + aimCursorRadius, height/2);
            ctx.lineTo(width - lineMargin - 30, height/2);

            for(var i = 1; i < 3; i++) // 2 dashed lines
            {
                // left half
                var dashStart = leftHalfEnd;
                while(dashStart > lineMargin*(i+1)){
                    ctx.moveTo(dashStart, height/2 + lineVerticalSpacing*i);
                    
                    if((dashStart - dashLineWidth) <= lineMargin*(i+1))
                    {
                        ctx.lineTo(lineMargin*(i+1) + 2, height/2 + lineVerticalSpacing*i);
                        break;
                    }
                    
                    ctx.lineTo(dashStart - dashLineWidth, height/2 + lineVerticalSpacing*i);
                    dashStart -= (dashSpacing + dashLineWidth);
                }

                // right half
                dashStart = rightHalfStart;
                while(dashStart < width - lineMargin*(i+1))
                {
                    ctx.moveTo(dashStart, height/2 + lineVerticalSpacing*i);
                    
                    if(dashStart + dashLineWidth > width - lineMargin*(i+1))
                    {
                        ctx.lineTo(width - lineMargin*(i+1), height/2 + lineVerticalSpacing*i);
                        break;
                    }
                    
                    ctx.lineTo(dashStart + dashLineWidth, height/2 + lineVerticalSpacing*i);
                    dashStart += dashSpacing + dashLineWidth;
                }
            }

            ctx.font = "14px Arial";
            ctx.fillStyle = canvasColor;

            // line texts
            ctx.fillText(uppestLineValue, lineMargin*3-24, height/2 - lineVerticalSpacing*2 + 4);
            ctx.fillText(uppestLineValue, width - lineMargin*3 + 7, height/2 - lineVerticalSpacing*2 + 4);
            ctx.fillText(lowestLineValue, lineMargin*3-24, height/2 + lineVerticalSpacing*2 + 4);
            ctx.fillText(lowestLineValue, width - lineMargin*3 + 7, height/2 + lineVerticalSpacing*2 + 4);
            ctx.fillText(upperLineValue, lineMargin*2-20, height/2 - lineVerticalSpacing + 4);
            ctx.fillText(upperLineValue, width - lineMargin*2 + 7, height/2 - lineVerticalSpacing + 4);
            ctx.fillText(lowerLineValue, lineMargin*2-20, height/2 + lineVerticalSpacing + 4);
            ctx.fillText(lowerLineValue, width - lineMargin*2 + 7, height/2 + lineVerticalSpacing + 4);
            
            ctx.stroke();
        }
    }
}

