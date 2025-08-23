import qs
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland

Scope {
    id: root
    property var focusedScreen: Quickshell.screens.find(s => s.name === Hyprland.focusedMonitor?.name)

    Loader {
        id: sessionLoader
        active: false

        sourceComponent: PanelWindow { // Session menu
            id: sessionRoot
            visible: sessionLoader.active
            property string subtitle

            function hide() {
                sessionLoader.active = false;
            }

            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.namespace: "quickshell:session"
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
                bottom: true
            }

            implicitWidth: root.focusedScreen?.width ?? 0
            implicitHeight: root.focusedScreen?.height ?? 0

            MouseArea {
                id: sessionMouseArea
                anchors.fill: parent
                onClicked: {
                    sessionRoot.hide();
                }
            }

            Rectangle {
                anchors.fill: parent
                color: ColorUtils.transparentize(Appearance.m3colors.m3layerBackground2, 0)
                radius: Appearance.rounding.screenRounding
            }

            ColumnLayout {
                // Content column
                anchors.centerIn: parent
                spacing: 5

                Keys.onPressed: event => {
                    if (event.key === Qt.Key_Escape) {
                        sessionRoot.hide();
                    }
                }

                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 0
                    StyledText {
                        // Title
                        Layout.alignment: Qt.AlignHCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: Appearance.font.family.title
                        font.pixelSize: Appearance.font.pixelSize.title
                        font.weight: Font.DemiBold
                        text: qsTr("Session")
                    }

                    StyledText {
                        // Small instruction
                        Layout.alignment: Qt.AlignHCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: Appearance.font.family.title
                        font.pixelSize: Appearance.font.pixelSize.normal
                        text: qsTr("Click to do. \nesc or click anywhere to cancel")
                    }
                }

                GridLayout {
                    columns: 4
                    columnSpacing: 5
                    rowSpacing: 5

                    SessionActionButton {
                        id: sessionLock
                        focus: sessionRoot.visible
                        buttonIcon: "lock"
                        buttonText: qsTr("Lock")
                        onClicked: Hyprland.dispatch("global quickshell:locked")
                        onFocusChanged: {
                            if (focus)
                                sessionRoot.subtitle = buttonText;
                        }
                        KeyNavigation.right: sessionSleep
                        KeyNavigation.down: sessionHibernate
                    }
                    SessionActionButton {
                        id: sessionLogout
                        buttonIcon: "logout"
                        buttonText: qsTr("Logout")
                        onClicked: {
                            Hyprland.dispatch("exec pkill Hyprland");
                            sessionRoot.hide();
                        }
                        onFocusChanged: {
                            if (focus)
                                sessionRoot.subtitle = buttonText;
                        }
                        KeyNavigation.left: sessionSleep
                        KeyNavigation.right: sessionTaskManager
                        KeyNavigation.down: sessionReboot
                    }
                    SessionActionButton {
                        id: sessionShutdown
                        buttonIcon: "power_settings_new"
                        buttonText: qsTr("Shutdown")
                        onClicked: {
                            Hyprland.dispatch("exec systemctl poweroff || loginctl poweroff");
                            sessionRoot.hide();
                        }
                        onFocusChanged: {
                            if (focus)
                                sessionRoot.subtitle = buttonText;
                        }
                        KeyNavigation.left: sessionHibernate
                        KeyNavigation.right: sessionReboot
                        KeyNavigation.up: sessionSleep
                    }
                    SessionActionButton {
                        id: sessionReboot
                        buttonIcon: "restart_alt"
                        buttonText: qsTr("Reboot")
                        onClicked: {
                            Hyprland.dispatch("exec reboot || loginctl reboot");
                            sessionRoot.hide();
                        }
                        onFocusChanged: {
                            if (focus)
                                sessionRoot.subtitle = buttonText;
                        }
                        KeyNavigation.left: sessionShutdown
                        KeyNavigation.right: sessionFirmwareReboot
                        KeyNavigation.up: sessionLogout
                    }
                }

                Rectangle {
                    Layout.alignment: Qt.AlignHCenter
                    radius: Appearance.rounding.small
                    implicitHeight: sessionSubtitle.implicitHeight + 10 * 2
                    implicitWidth: sessionSubtitle.implicitWidth + 15 * 2
                    color: Appearance.m3colors.m3layerBackground3
                    clip: true

                    Behavior on implicitWidth {
                        animation: Appearance.animation.elementMove.numberAnimation.createObject(this)
                    }

                    StyledText {
                        id: sessionSubtitle
                        anchors.centerIn: parent
                        color: Appearance.m3colors.m3primaryText
                        text: sessionRoot.subtitle
                    }
                }
            }
        }
    }

    IpcHandler {
        target: "session"

        function toggle(): void {
            sessionLoader.active = !sessionLoader.active;
        }

        function close(): void {
            sessionLoader.active = false;
        }

        function open(): void {
            sessionLoader.active = true;
        }
    }

    GlobalShortcut {
        name: "sessionToggle"
        description: qsTr("Toggles session screen on press")

        onPressed: {
            sessionLoader.active = !sessionLoader.active;
        }
    }

    GlobalShortcut {
        name: "sessionOpen"
        description: qsTr("Opens session screen on press")

        onPressed: {
            sessionLoader.active = true;
        }
    }
}
