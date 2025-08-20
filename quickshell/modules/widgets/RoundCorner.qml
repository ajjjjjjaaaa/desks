import QtQuick 2.9
import Quickshell
import Quickshell.Hyprland
import qs.modules.common

Item {
    id: root

    enum CornerEnum {
        TopLeft,
        TopRight,
        BottomLeft,
        BottomRight
    }

    // Hard-coded size
    property int size: 20
    property color color: Appearance.m3colors.m3background
    property var corner: RoundCorner.CornerEnum.TopLeft

    readonly property bool isLeftCorner: corner === RoundCorner.CornerEnum.TopLeft || corner === RoundCorner.CornerEnum.BottomLeft

    onColorChanged: {
        leftCanvas.requestPaint();
        rightCanvas.requestPaint();
    }

    onCornerChanged: {
        leftCanvas.requestPaint();
        rightCanvas.requestPaint();
    }

    implicitWidth: size + 60
    implicitHeight: size + 32

    Canvas {
        id: leftCanvas
        anchors.fill: parent
        anchors.leftMargin: 44
        anchors.topMargin: 16
        anchors.bottomMargin: 0
        antialiasing: true
        visible: root.isLeftCorner

        onPaint: {
            var ctx = getContext("2d");
            var r = root.size;
            ctx.clearRect(0, 0, leftCanvas.width, leftCanvas.height);
            ctx.beginPath();

            switch (root.corner) {
            case RoundCorner.CornerEnum.TopLeft:
                ctx.arc(r, r, r, Math.PI, 3 * Math.PI / 2);
                ctx.lineTo(0, 0);
                break;
            case RoundCorner.CornerEnum.BottomLeft:
                ctx.arc(r, 0, r, Math.PI / 2, Math.PI);
                ctx.lineTo(0, r);
                break;
            }

            ctx.closePath();
            ctx.fillStyle = root.color;
            ctx.fill();
        }
    }

    Canvas {
        id: rightCanvas
        anchors.fill: parent
        anchors.rightMargin: 16
        anchors.topMargin: 16
        anchors.bottomMargin: 16
        antialiasing: true
        visible: !root.isLeftCorner

        onPaint: {
            var ctx = getContext("2d");
            var r = root.size;
            ctx.clearRect(0, 0, rightCanvas.width, rightCanvas.height);
            ctx.beginPath();

            switch (root.corner) {
            case RoundCorner.CornerEnum.TopRight:
                ctx.moveTo(rightCanvas.width - r, 0);
                ctx.arc(rightCanvas.width - r, r, r, 3 * Math.PI / 2, 2 * Math.PI, false);
                ctx.lineTo(rightCanvas.width, 0);
                break;
            case RoundCorner.CornerEnum.BottomRight:
                ctx.moveTo(rightCanvas.width, rightCanvas.height - r);
                ctx.arc(rightCanvas.width - r, rightCanvas.height - r, r, 0, Math.PI / 2, false);
                ctx.lineTo(rightCanvas.width - r, rightCanvas.height);
                ctx.lineTo(rightCanvas.width, rightCanvas.height);
                break;
            }

            ctx.closePath();
            ctx.fillStyle = root.color;
            ctx.fill();
        }
    }
}
