import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.UPower
import Quickshell.Services.SystemTray
import Quickshell.Services.Pipewire
import Quickshell.Services.Mpris
import Qt5Compat.GraphicalEffects
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions

Rectangle {
    Layout.fillHeight: true
    Layout.fillWidth: true
    color: "transparent"

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Layout.fillHeight: true
        Layout.fillWidth: true
        spacing: 10

        ClockWidget {
            Layout.fillWidth: true
            Layout.fillHeight: false
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.topMargin: 10
            Layout.bottomMargin: 1
            radius: 10
            Layout.fillHeight: true
            implicitWidth: 25
            implicitHeight: 2
            color: ColorUtils.transparentize(Appearance.m3colors.m3borderPrimary, 0.3)
        }

        WorkspaceWidget {
            anchors.horizontalCenter: parent.horizontalCenter
            // leftPadding: 2
        }
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.topMargin: 10
            Layout.bottomMargin: 0
            radius: 10
            Layout.fillHeight: true
            implicitWidth: 25
            implicitHeight: 2
            color: ColorUtils.transparentize(Appearance.m3colors.m3borderPrimary, 0.3)
        }
        VertBat {
            visible: UPower.displayDevice.isLaptopBattery
            Layout.fillWidth: true
            Layout.fillHeight: false
        }

        SysTray {
            vertical: true
            Layout.fillWidth: true
            Layout.fillHeight: false
        }
    }
}
