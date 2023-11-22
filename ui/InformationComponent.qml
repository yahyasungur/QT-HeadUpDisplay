import QtQuick 2.0

Item {
    readonly property string canvasColor : "#09e421"
    readonly property string textFont: "18px sans-serif"

    Text {
        id: pilotInfo
        anchors {
            top: parent.top
            topMargin: 15
            left: parent.left
            leftMargin: 15
        }
        color: canvasColor
        font.family: textFont
        text: qsTr("TCHKK854254584222238 \nJOHN DOE \n29")
    }

    Text {
        id: modes
        anchors {
            top: parent.top
            topMargin: 15
            horizontalCenter: parent.horizontalCenter
        }
        color: canvasColor
        font.family: textFont
        font.bold: true
        text: qsTr("SPD  |  LMAV  |  VNAV ALT")
    }

    Text {
        id: dateTimeDisplay
        anchors {
            bottom: parent.bottom
            bottomMargin: 15
            right: parent.right
            rightMargin: 15
        }
        color: canvasColor
        font.family: textFont
        text: qsTr(systemController.currentTime)
    }

    Text {
        id: coordinates
        anchors {
            bottom: parent.bottom
            bottomMargin: 15
            left: parent.left
            leftMargin: 15
        }
        color: canvasColor
        font.family: textFont
        text: qsTr("39.9334° N \n32.8597° E ") // Ankara
    }
}






