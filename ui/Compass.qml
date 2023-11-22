import QtQuick 2.0

Item {
    width: 250
    height: 250

    FontLoader {
        name: "Teko"
        source: "qrc:/ui/assets/Teko-Regular.ttf"
    }


    Item {
        anchors.fill: parent
        anchors.margins: 0.1 * Math.min(parent.width, parent.height)

        Canvas {
            anchors.centerIn: parent
            width: Math.min(parent.width, parent.height)
            height: width

            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();
                ctx.strokeStyle = "#09e421";
                ctx.lineWidth = (6 / 324) * 0.5 * width
                ctx.moveTo(0.5 * width, 0);
                ctx.lineTo(0.5 * width, (76 / 324) * 0.5 * width);
                ctx.stroke();
            }
        }

        AppleCompass {
            anchors.centerIn: parent
            width: Math.min(parent.width, parent.height)
            height: width
            minimumValue: 0
            maximumValue: 360
            value: osscillatorController.value
            rotation: osscillatorController.value

            Component.onCompleted: {
                osscillatorController.start()
            }
        }
    }
}
