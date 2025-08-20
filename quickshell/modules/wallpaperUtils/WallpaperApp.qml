import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import qs.modules.common

FloatingWindow {
    id: window
    title: "walpy!"
    width: 600
    height: 500
    visible: false

    readonly property color md3Primary: Appearance.m3colors.m3primary
    readonly property color md3OnPrimary: Appearance.m3colors.m3onPrimary
    readonly property color md3PrimaryContainer: Appearance.m3colors.m3primaryContainer
    readonly property color md3OnPrimaryContainer: Appearance.m3colors.m3onPrimaryContainer
    readonly property color md3Secondary: Appearance.m3colors.m3secondary
    readonly property color md3OnSecondary: Appearance.m3colors.m3onSecondary
    readonly property color md3SecondaryContainer: Appearance.m3colors.m3secondaryContainer
    readonly property color md3OnSecondaryContainer: Appearance.m3colors.m3onSecondaryContainer
    readonly property color md3Surface: Appearance.m3colors.m3surface
    readonly property color md3OnSurface: Appearance.m3colors.m3onSurface
    readonly property color md3SurfaceVariant: Appearance.m3colors.m3surfaceVariant
    readonly property color md3OnSurfaceVariant: Appearance.m3colors.m3onSurfaceVariant
    readonly property color md3Outline: Appearance.m3colors.m3outline
    readonly property color md3OutlineVariant: Appearance.m3colors.m3outlineVariant || md3Outline
    readonly property color md3SurfaceContainer: Appearance.m3colors.m3surfaceContainer
    readonly property color md3SurfaceContainerHigh: Appearance.m3colors.m3surfaceContainerHigh
    readonly property color md3SurfaceContainerHighest: Appearance.m3colors.m3surfaceContainerHighest

    GlobalShortcut {
        name: "settings"
        appid: "app"

        onPressed: {
            window.visible = !window.visible;
        }
    }

    Rectangle {
        anchors.fill: parent
        color: md3Surface

        RowLayout {
            anchors.fill: parent
            anchors.margins: 0
            spacing: 0

            Rectangle {
                Layout.fillHeight: true
                Layout.preferredWidth: 80
                color: md3SurfaceContainer

                ColumnLayout {
                    anchors.fill: parent
                    anchors.topMargin: 24
                    anchors.bottomMargin: 24
                    spacing: 12

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 56
                        color: "transparent"

                        Text {
                            anchors.centerIn: parent
                            text: ":3"
                            font.family: "Rubik"
                            font.pixelSize: 24
                            font.weight: Font.Medium
                            color: md3Primary
                        }
                    }

                    Item {
                        Layout.fillHeight: true
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: md3Surface

                Rectangle {
                    id: header
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 80
                    color: md3Surface
                    z: 1

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 32

                        Text {
                            text: "settings"
                            font.family: "Rubik"
                            font.pixelSize: 32
                            font.weight: Font.Medium
                            color: md3OnSurface
                        }

                        Item {
                            Layout.fillWidth: true
                        }
                    }

                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 1
                        color: md3OutlineVariant
                    }
                }

                ScrollView {
                    anchors.top: header.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 32
                    anchors.topMargin: 16

                    ScrollBar.vertical.policy: ScrollBar.AsNeeded
                    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                    clip: true

                    ColumnLayout {
                        width: parent.width
                        spacing: 24

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 120
                            color: md3SurfaceContainerHigh
                            radius: 5
                            border.width: 1
                            border.color: md3OutlineVariant

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: 24
                                spacing: 20

                                Text {
                                    text: "Wallpaper Settings"
                                    font.family: "Rubik"
                                    font.pixelSize: 20
                                    font.weight: Font.Medium
                                    color: md3OnSurface
                                }

                                RowLayout {
                                    Layout.fillWidth: true
                                    spacing: 16

                                    Rectangle {
                                        Layout.preferredWidth: 180
                                        height: 40
                                        color: md3Primary
                                        radius: 5

                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: {
                                                Quickshell.execDetached([Directories.wallpaperSwitchScriptPath]);
                                            }

                                            hoverEnabled: true
                                            onEntered: parent.opacity = 0.9
                                            onExited: parent.opacity = 1.0
                                        }

                                        Text {
                                            anchors.centerIn: parent
                                            text: "Change Wallpaper"
                                            font.family: "Rubik"
                                            font.pixelSize: 14
                                            font.weight: Font.Medium
                                            color: md3OnPrimary
                                        }
                                    }
                                }
                            }
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 120
                            color: md3SurfaceContainerHigh
                            radius: 5
                            border.width: 1
                            border.color: md3OutlineVariant

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: 24
                                spacing: 20

                                Text {
                                    text: "Volume Control"
                                    font.family: "Rubik"
                                    font.pixelSize: 20
                                    font.weight: Font.Medium
                                    color: md3OnSurface
                                }

                                RowLayout {
                                    Layout.fillWidth: true
                                    spacing: 16

                                    Text {
                                        Layout.preferredWidth: 32
                                        Layout.preferredHeight: 32
                                        text: ""
                                        font.family: Appearance.font.family.iconFont
                                        font.pixelSize: 24
                                        color: md3OnSurface
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    Slider {
                                        id: volumeSlider
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 40
                                        from: 0
                                        to: 100
                                        value: currentVolume

                                        property real currentVolume: 50

                                        background: Rectangle {
                                            x: volumeSlider.leftPadding
                                            y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                                            width: volumeSlider.availableWidth
                                            height: 6
                                            radius: 3
                                            color: md3OutlineVariant

                                            Rectangle {
                                                width: volumeSlider.visualPosition * parent.width
                                                height: parent.height
                                                color: md3Primary
                                                radius: 3
                                            }
                                        }

                                        handle: Rectangle {
                                            x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
                                            y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                                            width: 24
                                            height: 24
                                            radius: 12
                                            color: volumeSlider.pressed ? md3Primary : md3OnPrimary
                                            border.color: md3Primary
                                            border.width: 2

                                            MouseArea {
                                                anchors.fill: parent
                                                hoverEnabled: true
                                                onEntered: parent.opacity = 0.9
                                                onExited: parent.opacity = 1.0
                                            }
                                        }

                                        onMoved: {
                                            volumeSetProcess.command = ["pactl", "set-sink-volume", "@DEFAULT_SINK@", value + "%"];
                                            volumeSetProcess.running = true;
                                        }
                                    }

                                    Text {
                                        Layout.preferredWidth: 48
                                        text: Math.round(volumeSlider.value) + "%"
                                        font.family: "Rubik"
                                        font.pixelSize: 16
                                        font.weight: Font.Medium
                                        color: md3OnSurface
                                        horizontalAlignment: Text.AlignRight
                                    }
                                }
                            }

                            Process {
                                id: volumeGetProcess
                                command: ["pactl", "get-sink-volume", "@DEFAULT_SINK@"]

                                stdout: StdioCollector {
                                    onStreamFinished: {
                                        var match = text.match(/(\d+)%/);
                                        if (match) {
                                            volumeSlider.currentVolume = parseInt(match[1]);
                                        }
                                    }
                                }
                            }

                            Process {
                                id: volumeSetProcess
                                command: ["pactl", "set-sink-volume", "@DEFAULT_SINK@", "50%"]
                            }

                            Process {
                                id: muteProcess
                                command: ["pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle"]
                            }

                            Timer {
                                interval: 2000
                                running: true
                                repeat: true
                                onTriggered: {
                                    if (!volumeGetProcess.running) {
                                        volumeGetProcess.running = true;
                                    }
                                }
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 24
                        }
                    }
                }
            }
        }
    }
}
