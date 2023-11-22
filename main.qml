import QtQuick 2.9
import QtQuick.Window 2.2
import "ui"

Window {
    id: window
    visible: true
    width: 740
    height: 940
    color: "#00000000"
    title: qsTr("HUD")

    Ladder {
        id: hudLadder
        anchors.fill: parent
    }

    AimCursor {
        id: hudAimCursor
        anchors.fill: parent
        aimCursorXAxis: width/2 + aimCursorController.cursorDeviationX
        aimCursorYAxis: height/2 + aimCursorController.cursorDeviationY
    }

    AirspeedScale {
        id: hudAirSpeedScale
        anchors.fill: parent
    }

    AltitudeScale {
        id: hudAltitudeScale
        anchors.fill: parent
    }

    HeadingScale {
        id: hudHeadingScale
        anchors.fill: parent
    }

    GMeter {
        id: hudGMeter
        anchors.fill: parent
    }

    Compass {
        id: hudCompass
        anchors {
            right: parent.right
            top: parent.top
            rightMargin: 50
        }
    }

    InformationComponent {
        id: hudInformationComponent
        anchors.fill: parent
    }
}
