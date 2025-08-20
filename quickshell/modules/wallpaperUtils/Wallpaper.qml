import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.modules.common

Scope {

    Variants {
        model: Quickshell.screens

        PanelWindow {
            mask: Region {}
            color: "transparent"
            required property var modelData
            screen: modelData

            PanelWindow {
                screen: modelData
                color: "transparent"

                implicitWidth: 225
                exclusiveZone: 0
                aboveWindows: false

                margins {
                    right: 0
                    bottom: 16
                }

                anchors {
                    right: true
                    bottom: true
                }

                Item {
                    id: clockColumn

                    width: clockLayout.width
                    height: clockLayout.height

                    property bool dragActive: false

                    Behavior on x {
                        enabled: !clockColumn.dragActive
                        NumberAnimation {
                            duration: 2000
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on y {
                        enabled: !clockColumn.dragActive
                        NumberAnimation {
                            duration: 2000
                            easing.type: Easing.InOutQuad
                        }
                    }

                    ColumnLayout {
                        id: clockLayout
                        spacing: -5

                        Text {
                            id: timeText
                            Layout.fillWidth: true
                            font.family: "Rubik"
                            font.pixelSize: 40
                            color: Appearance.m3colors.m3secondaryText
                            text: Qt.formatDateTime(new Date(), "hh.mm")
                        }

                        Text {
                            id: dateText
                            Layout.fillWidth: true
                            font.family: "Rubik"
                            font.pixelSize: 20
                            color: Appearance.m3colors.m3primaryText
                            text: Qt.formatDateTime(new Date(), "dddd, dd/MMM")
                        }
                    }

                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: {
                            let now = new Date();
                            timeText.text = Qt.formatDateTime(now, "hh.mm");

                            if (now.getSeconds() === 0) {
                                dateText.text = Qt.formatDateTime(now, "dddd, dd/MMM");
                            }
                        }
                    }
                }
            }
        }
    }
}
