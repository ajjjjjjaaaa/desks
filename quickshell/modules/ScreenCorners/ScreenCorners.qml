import qs.modules.common
import qs.modules.common.widgets
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
            visible: !activeWindow.fullscreen
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

            // Original screen corners
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

            // Bar edge corners - positioned next to the 50px bar
            RoundCorner {
                id: barcornertop
                anchors.top: parent.top
                // Don't use anchors.left when you want to position with x
                x: 50  // Position right next to the 50px bar
                size: Appearance.rounding.screenRounding
                corner: cornerEnum.topLeft  // Creates rounded right edge of bar
                color: Appearance.m3colors.m3background
            }
            RoundCorner {
                id: barcornerbottom
                anchors.bottom: parent.bottom
                // Don't use anchors.left when you want to position with x
                x: 50  // Position right next to the 50px bar
                size: Appearance.rounding.screenRounding
                corner: cornerEnum.bottomLeft  // Creates rounded right edge of bar
                color: Appearance.m3colors.m3background
            }
        }
    }
}
