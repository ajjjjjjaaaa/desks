import qs.modules.common
import qs.modules.common.widgets
import qs.services
import qs.modules.common.functions
import Qt5Compat.GraphicalEffects
import Qt.labs.platform
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Hyprland

RippleButton {
    id: root
    property string displayText
    property string url

    property real faviconSize: 20
    implicitHeight: 30
    leftPadding: (implicitHeight - faviconSize) / 2
    rightPadding: 10
    buttonRadius: Appearance.rounding.normal
    colBackground: Appearance.m3colors.m3layerBackground1
    colBackgroundHover: Appearance.m3colors.m3layerBackground2
    colRipple: Appearance.m3colors.m3layerBackground3

    PointingHandInteraction {}
    onClicked: {
        if (url) {
            Qt.openUrlExternally(url);
            Hyprland.dispatch("global quickshell:sidebarLeftClose");
        }
    }

    contentItem: Item {
        anchors.centerIn: parent
        implicitWidth: rowLayout.implicitWidth
        implicitHeight: rowLayout.implicitHeight
        RowLayout {
            id: rowLayout
            anchors.fill: parent
            spacing: 5
            Favicon {
                url: root.url
                size: root.faviconSize
                displayText: root.displayText
            }
            StyledText {
                id: text
                horizontalAlignment: Text.AlignHCenter
                text: displayText
                color: Appearance.m3colors.m3primaryText
            }
        }
    }
}
