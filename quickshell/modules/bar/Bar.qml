import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.modules.common
import qs.modules.widgets

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            visible: !activeWindow.fullscreen
            property var modelData
            screen: modelData
            exclusionMode: ExclusionMode.Ignore
            mask: Region {
                item: null
            }
            HyprlandWindow.visibleMask: Region {
                Region {
                    item: topRightCorner
                }
                Region {
                    item: bottomRightCorner
                }
            }
            WlrLayershell.namespace: "quickshell:screenCorners"
            WlrLayershell.layer: WlrLayer.Overlay
            color: "transparent"
            anchors {
                top: true
                left: true
                right: true
                bottom: true
            }
            RoundCorner {
                id: topRightCorner
                anchors.top: parent.top
                anchors.right: parent.right
                size: Appearance.rounding.screenRounding
                corner: cornerEnum.topRight
            }
            RoundCorner {
                id: bottomRightCorner
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                size: Appearance.rounding.screenRounding
                corner: cornerEnum.bottomRight
            }
        }
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
