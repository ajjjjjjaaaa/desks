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
import qs.modules.widgets
import qs.modules.common.widgets
import qs.modules.common

Rectangle {
    Layout.fillWidth: true
    Layout.preferredHeight: childrenRect.height + 8
    color: "transparent"

    property real innerModulesRadius: 3

    Behavior on height {
        NumberAnimation {
            duration: 1000
            easing.type: Easing.InOutQuart
        }
    }

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        spacing: 5
    }
}
