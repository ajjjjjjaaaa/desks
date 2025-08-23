import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower
import qs
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions

Item { // Bar content region
    id: root

    property var screen: root.QsWindow.window?.screen
    property var brightnessMonitor: Brightness.getMonitorForScreen(screen)

    component HorizontalBarSeparator: Rectangle {
        Layout.fillWidth: true
        implicitHeight: 2
        radius: 2
        color: Appearance.m3colors.m3borderPrimary
    }

    // Background shadow
    Loader {
        active: true
        anchors.fill: barBackground
        sourceComponent: StyledRectangularShadow {
            anchors.fill: undefined // The loader's anchors act on this, and this should not have any anchor
            target: barBackground
        }
    }
    // Background
    Rectangle {
        id: barBackground
        anchors.fill: parent
        color: Appearance.m3colors.m3background
        // color: "transparent"
    }

    ColumnLayout { // Middle section
        id: middleSection
        anchors.centerIn: parent
        Layout.alignment: Qt.AlignVCenter
        spacing: 4

        BarGroup {
            vertical: true
            padding: 8
            ClockWidget {
                Layout.fillWidth: true
                Layout.fillHeight: false
            }
        }

        HorizontalBarSeparator {
            visible: false
        }

        BarGroup {
            id: middleCenterGroup
            vertical: true
            padding: 0
            roundness: 0

            WorkspaceWidget {
                id: workspacesWidget
                MouseArea {
                    // Right-click to toggle overview
                    anchors.fill: parent
                    acceptedButtons: Qt.RightButton

                    onPressed: event => {
                        if (event.button === Qt.RightButton) {
                            GlobalStates.overviewOpen = !GlobalStates.overviewOpen;
                        }
                    }
                }
            }
        }

        HorizontalBarSeparator {
            visible: false
        }

        BarGroup {
            vertical: true
            padding: 8

            VertBat {
                visible: UPower.displayDevice.isLaptopBattery
                Layout.fillWidth: true
                Layout.fillHeight: false
            }
        }

        BarGroup {
            vertical: true
            padding: 10

            SysTray {
                vertical: true
                Layout.fillWidth: true
                Layout.fillHeight: false
                invertSide: Config?.options.bar.bottom
            }
        }
    }
    ColumnLayout {
        id: bottomSection
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        visible: false

        BarGroup {
            vertical: true
            padding: 8

            VertBat {
                visible: UPower.displayDevice.isLaptopBattery
                Layout.fillWidth: true
                Layout.fillHeight: false
            }
        }
    }
}
