import QtQuick
import QtQuick.Shapes
import qs.modules.common.widgets

// Your existing corner component (assumed to be saved as "Corner.qml")
// This creates a Mac-style notch at the top center
Item {
    id: notchContainer

    // Notch dimensions - adjust these to match your desired size
    property int notchWidth: 200
    property int notchHeight: 30
    property int cornerRadius: 15

    // Background color (should match your window/panel background)
    property color backgroundColor: "#000000"

    width: notchWidth
    height: notchHeight

    // Left rounded corner of the notch
    Item {
        id: leftCorner
        width: cornerRadius
        height: cornerRadius
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        // Use your Corner component - assuming it's in Corner.qml
        CornerThingy {
            anchors.fill: parent
            cornerType: "inverted"
            cornerHeight: cornerRadius
            cornerWidth: cornerRadius
            color: backgroundColor
            corners: [2] // bottom-left corner
        }
    }

    // Center rectangle of the notch
    Rectangle {
        id: centerRect
        anchors.left: leftCorner.right
        anchors.right: rightCorner.left
        anchors.bottom: parent.bottom
        height: cornerRadius
        color: backgroundColor
    }

    // Right rounded corner of the notch
    Item {
        id: rightCorner
        width: cornerRadius
        height: cornerRadius
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        CornerThingy {
            anchors.fill: parent
            cornerType: "inverted"
            cornerHeight: cornerRadius
            cornerWidth: cornerRadius
            color: backgroundColor
            corners: [3] // bottom-right corner
        }
    }
}
