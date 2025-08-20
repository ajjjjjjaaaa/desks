import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.modules.common

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: bar
            screen: modelData
            required property var modelData
            WlrLayershell.namespace: "quickshell:bar"
            anchors {
                top: true
                bottom: true
                left: true
            }
            implicitWidth: 50
            color: Appearance.m3colors.m3background
            Item {
                anchors.fill: parent
                // Top
                Top {
                    id: top
                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                    }
                    visible: false
                }
                Center {
                    anchors.centerIn: parent
                }
                Bottom {
                    id: bottom
                    anchors {
                        bottom: parent.bottom
                        left: parent.left
                        right: parent.right
                    }
                    visible: true
                }
            }
        }
    }
}
