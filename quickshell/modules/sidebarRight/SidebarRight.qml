import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import qs.modules.common
import qs.modules.common.widgets
import qs.services
import "./notifications"
import "../media"

PanelWindow {
    id: root
    color: "transparent"
    visible: false
    exclusiveZone: 0

    function roundVolume(volume) {
        return Math.round((volume * 100) / 1) * 1;
    }

    GlobalShortcut {
        name: "sidebarRightToggle"
        onPressed: {
            root.visible = !root.visible;
        }
    }

    implicitWidth: 500
    margins {
        left: 5
        top: 5
        bottom: 5
    }
    anchors {
        left: true
        top: true
        bottom: true
    }

    Rectangle {
        color: Appearance.m3colors.m3background
        radius: Appearance.rounding.screenRounding - 5
        border.color: Appearance.m3colors.m3borderPrimary
        anchors.fill: parent

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: Appearance.m3colors.m3surface
                radius: Appearance.rounding.small

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 10

                    Text {
                        Layout.fillWidth: true
                        text: "Notifications"
                        font.family: "Rubik"
                        font.pixelSize: 16
                        font.weight: Font.Medium
                        color: Appearance.m3colors.m3onSurface
                    }

                    NotificationList {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                }
            }
        }
    }
}
