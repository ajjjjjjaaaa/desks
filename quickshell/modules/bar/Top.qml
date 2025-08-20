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
import qs.modules.common.widgets
import qs.modules.common
import qs

Rectangle {
    Layout.fillWidth: true
    Layout.preferredHeight: columnLayout.implicitHeight + 12
    color: "transparent"

    property real innerModulesRadius: 3

    // System info properties
    property real cpuUsage: 0.3
    property real ramUsage: 0.6

    Behavior on Layout.preferredHeight {
        NumberAnimation {
            duration: 1000
            easing.type: Easing.InOutQuart
        }
    }

    ColumnLayout {
        id: columnLayout
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 20
        spacing: 6

        RippleButton {
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.fillWidth: false
            property real buttonPadding: 5
            implicitWidth: distroIcon.width + buttonPadding * 2
            implicitHeight: distroIcon.height + buttonPadding * 2

            buttonRadius: Appearance.rounding.full
            colBackground: "transparent"
            colBackgroundHover: Appearance.m3colors.m3layerBackground2
            colRipple: Appearance.m3colors.m3layerBackground2
            colBackgroundToggled: Appearance.m3colors.m3background
            colBackgroundToggledHover: Appearance.m3colors.m3background
            colRippleToggled: Appearance.m3colors.m3background
            toggled: GlobalStates.sidebarLeftOpen
            property color colText: toggled ? Appearance.m3colors.m3background : Appearance.m3colors.m3background

            onPressed: {
                GlobalStates.overviewOpen = !GlobalStates.overviewOpen;
            }

            CustomIcon {
                id: distroIcon
                anchors.centerIn: parent
                width: 18
                height: 18
                source: "spark-symbolic.svg"
                colorize: true
                color: Appearance.m3colors.m3primaryText
            }
        }
    }
}
