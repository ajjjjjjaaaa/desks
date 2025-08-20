import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Hyprland
import qs.modules.common

Scope {
    id: root

    // Bind the pipewire node so its volume will be tracked
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    // Volume change connections
    Connections {
        target: Pipewire.defaultAudioSink?.audio
        function onVolumeChanged() {
            root.shouldShowVolumeOsd = true;
            root.shouldShowBrightnessOsd = false;
            hideVolumeTimer.restart();
        }
    }

    // Global shortcuts
    GlobalShortcut {
        name: "volumeshow"
        description: "Opens volume OSD"
        onPressed: showVolumeOsd()
    }

    GlobalShortcut {
        name: "brightnessup"
        description: "Increase brightness"
        onPressed: changeBrightness(5) // Changed to 5 for rounding
    }

    GlobalShortcut {
        name: "brightnessdown"
        description: "Decrease brightness"
        onPressed: changeBrightness(-5) // Added brightness down shortcut
    }

    GlobalShortcut {
        name: "brightnessshow"
        description: "Show brightness OSD"
        onPressed: {
            getBrightnessProcess.running = true;
            showBrightnessOsd();
        }
    }

    // Properties for OSD state
    property bool shouldShowVolumeOsd: false
    property bool shouldShowBrightnessOsd: false
    property int currentBrightness: 50
    property int previousBrightness: 50

    // Timer to periodically check brightness changes
    Timer {
        id: brightnessMonitor
        interval: 500 // Check every 500ms
        running: true
        repeat: true
        onTriggered: {
            getBrightnessProcess.running = true;
        }
    }

    // Process for getting current brightness
    Process {
        id: getBrightnessProcess
        command: ["ddcutil", "getvcp", "10", "--display", "1"]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                // Parse ddcutil output like "VCP code 0x10 (Brightness): current value = 50, max value = 100"
                var output = this.text;
                var match = output.match(/current value\s*=\s*(\d+)/);
                if (match) {
                    var newBrightness = parseInt(match[1]);
                    // Round to nearest 5
                    newBrightness = Math.round(newBrightness / 5) * 5;
                    // Check if brightness changed externally
                    if (newBrightness !== root.previousBrightness && newBrightness !== root.currentBrightness) {
                        root.currentBrightness = newBrightness;
                        showBrightnessOsd();
                    } else {
                        root.currentBrightness = newBrightness;
                    }
                    root.previousBrightness = root.currentBrightness;
                }
            }
        }
    }

    // Process for setting brightness
    Process {
        id: setBrightnessProcess
        running: false

        function setBrightness(value) {
            // Clamp value between 0 and 100 and round to nearest 5
            value = Math.max(0, Math.min(100, value));
            value = Math.round(value / 5) * 5;
            command = ["ddcutil", "setvcp", "10", value.toString(), "--display", "1"];
            running = true;
        }
    }

    // Functions
    function showVolumeOsd() {
        root.shouldShowVolumeOsd = true;
        hideVolumeTimer.restart();
    }

    function showBrightnessOsd() {
        root.shouldShowBrightnessOsd = true;
        hideBrightnessTimer.restart();
    }

    function changeBrightness(delta) {
        // Calculate new brightness based on current value
        var newBrightness = root.currentBrightness + delta;
        newBrightness = Math.max(0, Math.min(100, newBrightness));
        // Round to nearest 5
        newBrightness = Math.round(newBrightness / 5) * 5;

        // Update the display immediately for responsiveness
        root.currentBrightness = newBrightness;
        showBrightnessOsd();

        // Set the actual brightness
        setBrightnessProcess.setBrightness(newBrightness);
    }

    function roundVolume(volume) {
        // Round volume to nearest 5%
        return Math.round((volume * 100) / 1) * 1;
    }

    // Timer to hide Volume OSD
    Timer {
        id: hideVolumeTimer
        interval: 2000
        onTriggered: {
            root.shouldShowVolumeOsd = false;
        }
    }

    // Timer to hide Brightness OSD
    Timer {
        id: hideBrightnessTimer
        interval: 2000
        onTriggered: {
            root.shouldShowBrightnessOsd = false;
        }
    }

    LazyLoader {
        active: root.shouldShowVolumeOsd
        PanelWindow {
            anchors {
                top: true
                left: true
            }
            margins {
                top: 4
                left: 4
            }
            exclusiveZone: 0
            implicitWidth: 200
            implicitHeight: 50
            color: "transparent"
            mask: Region {}

            Rectangle {
                anchors.fill: parent
                color: Appearance.m3colors.m3background
                radius: 10

                RowLayout {
                    anchors {
                        fill: parent
                        leftMargin: 15
                        rightMargin: 15
                        topMargin: 10
                        bottomMargin: 10
                    }
                    spacing: 10

                    Text {
                        text: ""
                        color: Appearance.m3colors.m3primaryText
                        font.pixelSize: 16
                        font.family: "JetBrainsMono NerdFont"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 8
                        color: Appearance.m3colors.m3primaryText
                        radius: 4
                        Layout.alignment: Qt.AlignVCenter

                        Rectangle {
                            anchors {
                                left: parent.left
                                top: parent.top
                                bottom: parent.bottom
                            }
                            radius: 4
                            color: Appearance.m3colors.m3secondaryText
                            implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)

                            Behavior on implicitWidth {
                                NumberAnimation {
                                    duration: 75
                                    easing.type: Easing.InOutCubic
                                }
                            }
                        }
                    }

                    Text {
                        text: roundVolume(Pipewire.defaultAudioSink?.audio.volume ?? 0) + "%"
                        color: Appearance.m3colors.m3primaryText
                        font.pixelSize: 12
                        font.family: Appearance.font.family.uiFont
                        Layout.alignment: Qt.AlignVCenter
                        Layout.preferredWidth: 35
                    }
                }
            }
        }
    }

    // Brightness OSD - Horizontal and positioned at top left (same position as volume)
    LazyLoader {
        active: root.shouldShowBrightnessOsd
        PanelWindow {
            anchors {
                top: true
                left: true
            }
            margins {
                top: 4  // Same position as volume OSD
                left: 4
            }
            exclusiveZone: 0
            implicitWidth: 200
            implicitHeight: 50
            color: "transparent"
            mask: Region {}

            Rectangle {
                anchors.fill: parent
                color: Appearance.m3colors.m3background
                radius: 10

                RowLayout {
                    anchors {
                        fill: parent
                        leftMargin: 15
                        rightMargin: 15
                        topMargin: 10
                        bottomMargin: 10
                    }
                    spacing: 10

                    Text {
                        text: "󰃠"
                        color: Appearance.m3colors.m3primaryText
                        font.pixelSize: 16
                        font.family: "JetBrainsMono NerdFont"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 8
                        color: Appearance.m3colors.m3primaryText
                        radius: 4
                        Layout.alignment: Qt.AlignVCenter

                        Rectangle {
                            anchors {
                                left: parent.left
                                top: parent.top
                                bottom: parent.bottom
                            }
                            radius: 4
                            color: Appearance.m3colors.m3secondaryText
                            implicitWidth: parent.width * (root.currentBrightness / 100.0)
                        }
                    }

                    Text {
                        text: root.currentBrightness + "%"
                        color: Appearance.m3colors.m3primaryText
                        font.pixelSize: 12
                        font.family: "JetBrainsMono NerdFont"
                        Layout.alignment: Qt.AlignVCenter
                        Layout.preferredWidth: 35
                    }
                }
            }
        }
    }

    // Initialize brightness value on startup
    Component.onCompleted: {
        getBrightnessProcess.running = true;
    }
}
