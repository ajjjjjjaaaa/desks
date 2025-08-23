import qs.modules.common
import qs.modules.common.widgets
import qs
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

Scope {
    id: screenCorners
    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel

    Variants {
        model: Quickshell.screens
        PanelWindow {
            visible: true
            property var modelData
            screen: modelData
            exclusionMode: ExclusionMode.Ignore
            mask: Region {
                item: null
            }
            HyprlandWindow.visibleMask: Region {
                Region {
                    item: topLeftCorner
                }
                Region {
                    item: topRightCorner
                }
                Region {
                    item: bottomLeftCorner
                }
                Region {
                    item: bottomRightCorner
                }
                Region {
                    item: barcornertop
                }
                Region {
                    item: barcornerbottom
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
                id: topLeftCorner
                anchors.top: parent.top
                anchors.left: parent.left
                size: Appearance.rounding.screenRounding
                corner: cornerEnum.topLeft
            }
            RoundCorner {
                id: topRightCorner
                anchors.top: parent.top
                anchors.right: parent.right
                size: Appearance.rounding.screenRounding
                corner: cornerEnum.topRight
                color: Appearance.m3colors.m3background
            }
            RoundCorner {
                id: bottomLeftCorner
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                size: Appearance.rounding.screenRounding
                corner: cornerEnum.bottomLeft
            }
            RoundCorner {
                id: bottomRightCorner
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                size: Appearance.rounding.screenRounding
                corner: cornerEnum.bottomRight
                color: Appearance.m3colors.m3background
            }

            RoundCorner {
                id: barcornertop
                anchors.top: parent.top
                x: Appearance.sizes.barWidth
                size: Appearance.rounding.screenRounding
                corner: cornerEnum.topLeft
                color: Appearance.m3colors.m3background
                visible: !activeWindow.fullscreen
            }
            RoundCorner {
                id: barcornerbottom
                anchors.bottom: parent.bottom
                x: Appearance.sizes.barWidth  // shouldchange
                size: Appearance.rounding.screenRounding
                corner: cornerEnum.bottomLeft // put right next to bar
                color: Appearance.m3colors.m3background
                visible: !activeWindow.fullscreen
            }
        }
    }
}
