import qs.modules.common
import qs.modules.common.widgets
import qs.services
import qs.modules.common.functions
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell

GroupButton {
    id: button
    property string buttonIcon
    property bool activated: false
    toggled: activated

    baseWidth: height

    contentItem: MaterialSymbol {
        horizontalAlignment: Text.AlignHCenter
        iconSize: Appearance.font.pixelSize.larger
        text: buttonIcon
        color: button.activated ? Appearance.m3colors.m3primaryText : button.enabled ? Appearance.m3colors.m3secondaryText : Appearance.m3colors.m3secondaryText

        Behavior on color {
            animation: Appearance.animation.elementMoveFast.colorAnimation.createObject(this)
        }
    }
}
