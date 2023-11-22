import QtQuick 2.0
import QtQuick.Controls.Styles 1.4

CircularGaugeStyle {
    tickmarkInset: (76 / 324) * outerRadius
    minorTickmarkInset: (76 / 324) * outerRadius

    tickmark: Rectangle {
        implicitWidth: (6 / 324) * outerRadius
        implicitHeight: (34 / 324) * outerRadius
        color: "#cfcf40"
        antialiasing: true
    }

    minorTickmark: Rectangle {
        implicitWidth: (2 / 324) * outerRadius
        implicitHeight: (34 / 324) * outerRadius
        color: "#09e421"
        antialiasing: true
    }

    tickmarkLabel: Item {}
    needle: Item {}
    foreground: Item {}
}
