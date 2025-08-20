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

    implicitWidth: 510
    margins {
        right: 5
        top: 5
        bottom: 5
    }
    anchors {
        right: true
        top: true
        bottom: true
    }

    Rectangle {
        color: Appearance.m3colors.m3background
        radius: Appearance.rounding.normal
        border.color: Appearance.m3colors.m3borderPrimary
        anchors.fill: parent

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 15
            spacing: 15

            Rectangle {
                visible: false
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                color: Appearance.m3colors.m3surface
                radius: Appearance.rounding.small
                border.color: Appearance.m3colors.m3borderSecondary

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 10

                    Text {
                        Layout.fillWidth: true
                        text: "Volume Control"
                        font.family: "Rubik"
                        font.pixelSize: 16
                        font.weight: Font.Medium
                        color: Appearance.m3colors.m3onSurface
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        Slider {
                            id: volumeSlider
                            Layout.fillWidth: true
                            from: 0
                            to: 100
                            value: roundVolume(Pipewire.defaultAudioSink?.audio.volume)
                            stepSize: 1

                            background: Rectangle {
                                x: volumeSlider.leftPadding
                                y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                                implicitWidth: 200
                                implicitHeight: 4
                                width: volumeSlider.availableWidth

                                Behavior on width {
                                    NumberAnimation {
                                        duration: 75
                                        easing.type: Easing.InOutCubic
                                    }
                                }

                                height: implicitHeight
                                radius: 2
                                color: Appearance.m3colors.m3surfaceVariant

                                Rectangle {
                                    width: volumeSlider.visualPosition * parent.width
                                    height: parent.height
                                    color: Appearance.m3colors.m3primary
                                    radius: 2
                                }
                            }

                            handle: Rectangle {
                                x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
                                y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                                implicitWidth: 20
                                implicitHeight: 20
                                radius: 10
                                color: Appearance.m3colors.m3primary
                                border.color: Appearance.m3colors.m3onPrimary
                                border.width: 2
                            }

                            onValueChanged: {
                                volumeText.text = roundVolume(Pipewire.defaultAudioSink?.audio.volume) + "%";
                            }
                        }

                        Text {
                            id: volumeText
                            text: roundVolume(Pipewire.defaultAudioSink?.audio.volume) + "%"
                            font.family: "Rubik"
                            font.pixelSize: 14
                            color: Appearance.m3colors.m3onSurface
                            Layout.preferredWidth: 40
                        }
                    }
                }
            }

            MediaControls {
                Layout.fillWidth: true
                Layout.preferredHeight: 150
            }

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
