import QtQuick 2.0

Item {
    property string aimCursorColor : "#cfcf40"
    property int aimCursorRadius : 45

    property int aimCursorXAxis : width/2
    property int aimCursorYAxis : height/2

    onAimCursorXAxisChanged: aimCursorCanvas.requestPaint();
    

    Canvas {
        id: aimCursorCanvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.strokeStyle = aimCursorColor;
            ctx.lineWidth = 1;
            ctx.beginPath();

            // cycle in the middle with dashed lines
            ctx.moveTo(aimCursorXAxis + aimCursorRadius, aimCursorYAxis);
            for(var i = 0; i < 36; i+=2)
            {
                ctx.arc(aimCursorXAxis, aimCursorYAxis, aimCursorRadius, i*Math.PI/18, (i+1)*Math.PI/18);
                ctx.moveTo(aimCursorXAxis + Math.cos((i+2)*Math.PI/18)*aimCursorRadius, aimCursorYAxis + Math.sin((i+2)*Math.PI/18)*aimCursorRadius);
            }

            // aim cursor dashed lines (vertical)
            ctx.moveTo(aimCursorXAxis, aimCursorYAxis - aimCursorRadius/2);
            for(var i = 0; i < 18; i+=2)
            {
                ctx.lineTo(aimCursorXAxis, aimCursorYAxis - aimCursorRadius/2 + i*aimCursorRadius/18);
                ctx.moveTo(aimCursorXAxis, aimCursorYAxis - aimCursorRadius/2 + (i+1)*aimCursorRadius/18);
            }

            // aim cursor dashed lines (horizontal)
            ctx.moveTo(aimCursorXAxis - aimCursorRadius*2/3, aimCursorYAxis);
            for(var i = 0; i < 18; i+=2)
            {
                ctx.lineTo(aimCursorXAxis - aimCursorRadius*2/3 + i*aimCursorRadius/13, aimCursorYAxis);
                ctx.moveTo(aimCursorXAxis - aimCursorRadius*2/3 + (i+1)*aimCursorRadius/13, aimCursorYAxis);
            }

            ctx.stroke();
        }
    }
}
