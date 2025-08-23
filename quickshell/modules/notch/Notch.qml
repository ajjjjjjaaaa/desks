import qs
import qs.modules.common
import qs.modules.common.widgets
import qs.services
import qs.modules.common.functions
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.UPower
import "../bar" as Bar

Scope {
    Variants {
        id: notchBlock
        model: Quickshell.screens
        property int widht: 1

        Behavior on widht {
            NumberAnimation {
                duration: 25
                easing.type: Easing.InOutExpo
            }
        }

        PanelWindow {
            id: notchLeft
            visible: true
            screen: modelData
            anchors {
                top: true
                left: true
            }
            margins.left: Appearance.sizes.barWidth - 46

            implicitHeight: notchBlock.widht
            implicitWidth: 500
            color: "transparent"

            Rectangle {
                width: parent.width - 40
                color: Appearance.m3colors.m3surface
                anchors.left: parent.left
                height: 40

                MouseArea {
                    enabled: true
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        notchBlock.widht = 40;
                        con.visible = true;
                    }

                    onExited: {
                        notchBlock.widht = 1;
                        con.visible = false;
                    }
                }

                RowLayout { // Content
                    id: leftSectionRowLayouts
                    anchors.fill: parent
                    anchors.leftMargin: 30
                    spacing: 10
                    visible: Config.options.bar.showTitle

                    ClockWidget {
                        visible: true
                        Layout.fillWidth: false
                        Layout.fillHeight: true
                    }

                    Active {
                        visible: barRoot.useShortenedForm === 0
                        Layout.leftMargin: Appearance.rounding.screenRounding
                        Layout.rightMargin: 100
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        bar: barRoot
                    }
                }
            }

            Item {
                id: con
                anchors.left: parent.left
                anchors.leftMargin: parent.width - 40
                height: notchBlock.widht
                visible: false
                CornerThingy {
                    anchors.fill: parent
                    corners: [1, 0]
                    rotation: 0
                    cornerType: "cubic"
                    cornerHeight: 40
                    color: Appearance.m3colors.m3surface
                }
            }
        }
    }
}
