import qs
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects

Item {
    id: root
    property bool borderless: false
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(root.QsWindow.window?.screen)
    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel

    readonly property int workspaceGroup: Math.floor((monitor?.activeWorkspace?.id - 1) / Config.options.bar.workspaces.shown)
    property list<bool> workspaceOccupied: []

    property int workspaceButtonWidth: Appearance.sizes.barWidth / 2
    property int workspaceButtonHeight: Appearance.sizes.barWidth / 1.70
    property real workspaceIconSize: 8
    property real workspaceIconSizeShrinked: 12
    property real workspaceIconOpacityShrinked: 0.7
    property real workspaceIconMarginShrinked: 2
    property int workspaceIndexInGroup: (monitor?.activeWorkspace?.id - 1) % Config.options.bar.workspaces.shown

    property bool horizontal

    property real containerSpacing: 1

    implicitHeight: columnLayout.implicitHeight + (containerSpacing * 2)
    implicitWidth: workspaceButtonWidth + 10

    property bool showNumbers: false
    property bool isHovered: false

    Timer {
        id: showNumbersTimer
        interval: (Config?.options.bar.autoHide.showWhenPressingSuper.delay ?? 150)
        repeat: false
        onTriggered: {
            root.showNumbers = true;
        }
    }

    Timer {
        id: hideNumbersTimer
        interval: 200
        repeat: false
        onTriggered: {
            if (!GlobalStates.superDown && !root.isHovered) {
                root.showNumbers = false;
            }
        }
    }

    Connections {
        target: GlobalStates
        function onSuperDownChanged() {
            if (!Config?.options.bar.autoHide.showWhenPressingSuper.enable)
                return;
            if (GlobalStates.superDown) {
                hideNumbersTimer.stop();
                showNumbersTimer.restart();
            } else {
                showNumbersTimer.stop();
                hideNumbersTimer.restart();
            }
        }
        function onSuperReleaseMightTriggerChanged() {
            showNumbersTimer.stop();
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.BackButton

        onEntered: {
            root.isHovered = true;
            hideNumbersTimer.stop();
        }

        onExited: {
            root.isHovered = false;
            if (!GlobalStates.superDown) {
                hideNumbersTimer.restart();
            }
        }

        onPressed: event => {
            if (event.button === Qt.BackButton) {
                Hyprland.dispatch(`togglespecialworkspace`);
            }
        }
    }

    function updateWorkspaceOccupied() {
        workspaceOccupied = Array.from({
            length: Config.options.bar.workspaces.shown
        }, (_, i) => {
            return Hyprland.workspaces.values.some(ws => ws.id === workspaceGroup * Config.options.bar.workspaces.shown + i + 1);
        });
    }

    Component.onCompleted: updateWorkspaceOccupied()
    Connections {
        target: Hyprland.workspaces
        function onValuesChanged() {
            updateWorkspaceOccupied();
        }
    }
    Connections {
        target: Hyprland
        function onFocusedWorkspaceChanged() {
            updateWorkspaceOccupied();
        }
    }
    onWorkspaceGroupChanged: {
        updateWorkspaceOccupied();
    }

    WheelHandler {
        property real accumulatedDelta: 0
        readonly property real threshold: 120

        onWheel: event => {
            accumulatedDelta += event.angleDelta.y;

            if (Math.abs(accumulatedDelta) >= threshold) {
                if (accumulatedDelta < 0) {
                    Hyprland.dispatch(`workspace r+1`);
                } else {
                    Hyprland.dispatch(`workspace r-1`);
                }
                accumulatedDelta = 0;
            }
        }
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    }

    Rectangle {
        id: containerBackground
        anchors.fill: parent
        anchors.margins: 2
        radius: 12
        rotation: root.horizontal ? 180 : 0
        color: ColorUtils.transparentize(Appearance.m3colors.m3layerBackground3, 0)

        Behavior on color {
            ColorAnimation {
                duration: 150
                easing.type: Easing.OutCubic
            }
        }
    }

    ColumnLayout {
        id: columnLayout
        z: 1
        spacing: containerSpacing
        anchors {
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            margins: 4
        }
        implicitWidth: workspaceButtonWidth

        Repeater {
            model: Config?.options?.bar?.workspaces?.shown

            Rectangle {
                z: 1
                implicitWidth: workspaceButtonWidth
                implicitHeight: workspaceButtonHeight
                radius: 0

                property bool isOccupied: workspaceOccupied[index]
                property bool isActive: monitor?.activeWorkspace?.id === (workspaceGroup * Config.options.bar.workspaces.shown + index + 1)
                property bool previousOccupied: index > 0 && workspaceOccupied[index - 1]
                property bool nextOccupied: index < Config.options.bar.workspaces.shown - 1 && workspaceOccupied[index + 1]

                topLeftRadius: previousOccupied && isOccupied ? 4 : 8
                topRightRadius: previousOccupied && isOccupied ? 8 : 8
                bottomLeftRadius: nextOccupied && isOccupied ? 8 : 8
                bottomRightRadius: nextOccupied && isOccupied ? 4 : 8

                color: Appearance.m3colors.m3borderPrimary

                opacity: isActive ? 0.8 : (isOccupied ? 0.6 : 0.001)

                Behavior on opacity {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: 75
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on topLeftRadius {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }
                Behavior on topRightRadius {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }
                Behavior on bottomLeftRadius {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }
                Behavior on bottomRightRadius {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }
    }

    ColumnLayout {
        id: columnLayoutNumbers
        z: 3
        spacing: containerSpacing
        anchors.fill: parent
        anchors.margins: 4
        implicitWidth: workspaceButtonWidth

        Repeater {
            model: Config.options.bar.workspaces.shown

            Button {
                id: button
                property int workspaceValue: workspaceGroup * Config.options.bar.workspaces.shown + index + 1
                property bool isActive: monitor?.activeWorkspace?.id === workspaceValue
                property bool isOccupied: workspaceOccupied[index]

                Layout.fillWidth: true
                implicitHeight: workspaceButtonHeight

                onPressed: Hyprland.dispatch(`workspace ${workspaceValue}`)

                hoverEnabled: true

                background: Rectangle {
                    color: "transparent"
                    radius: 10

                    Rectangle {
                        anchors.fill: parent
                        radius: parent.radius
                        color: ColorUtils.transparentize(button.isActive ? Appearance.m3colors.m3onPrimary : Appearance.m3colors.m3onSurface, 0.92)
                        opacity: button.hovered ? 1 : 0

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 50
                                easing.type: Easing.OutCubic
                            }
                        }
                    }

                    Rectangle {
                        anchors.fill: parent
                        radius: parent.radius
                        color: ColorUtils.transparentize(button.isActive ? Appearance.m3colors.m3onPrimary : Appearance.m3colors.m3onSurface, 0.88)
                        opacity: button.pressed ? 1 : 0

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 100
                                easing.type: Easing.OutCubic
                            }
                        }
                    }
                }

                contentItem: Item {
                    id: workspaceButtonBackground
                    implicitWidth: workspaceButtonWidth
                    implicitHeight: workspaceButtonHeight

                    property var biggestWindow: HyprlandData.biggestWindowForWorkspace(button.workspaceValue)
                    property var mainAppIconSource: Quickshell.iconPath(AppSearch.guessIcon(biggestWindow?.class), "image-missing")

                    Text {
                        id: workspaceNumber
                        opacity: root.showNumbers || (Config.options?.bar.workspaces.alwaysShowNumbers && (!Config.options?.bar.workspaces.showAppIcons || !workspaceButtonBackground.biggestWindow)) ? 1 : 0
                        z: 3

                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        font.pixelSize: 9
                        font.weight: button.isActive ? Font.Medium : Font.Normal
                        font.family: Appearance.font.family.uiFont

                        text: `${button.workspaceValue}`
                        color: button.isActive ? Appearance.m3colors.m3onPrimary : (button.isOccupied ? Appearance.m3colors.m3onSecondaryContainer : Appearance.m3colors.m3onSurfaceVariant)

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 150
                                easing.type: Easing.OutCubic
                            }
                        }

                        Behavior on color {
                            ColorAnimation {
                                duration: 150
                                easing.type: Easing.OutCubic
                            }
                        }
                    }

                    Rectangle {
                        id: wsDot
                        opacity: (Config.options?.bar.workspaces.alwaysShowNumbers || root.showNumbers || (Config.options?.bar.workspaces.showAppIcons && workspaceButtonBackground.biggestWindow)) ? 0 : 1
                        visible: opacity > 0
                        anchors.centerIn: parent
                        width: button.isActive ? 6 : 4
                        height: width
                        radius: width / 2
                        color: button.isActive ? Appearance.m3colors.m3primaryText : (button.isOccupied ? Appearance.m3colors.m3selectionText : Appearance.m3colors.m3selectionText)

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 150
                                easing.type: Easing.OutCubic
                            }
                        }

                        Behavior on width {
                            NumberAnimation {
                                duration: 45
                                easing.type: Easing.OutCubic
                            }
                        }

                        Behavior on color {
                            ColorAnimation {
                                duration: 150
                                easing.type: Easing.OutCubic
                            }
                        }
                    }

                    Item {
                        anchors.centerIn: parent
                        width: workspaceButtonWidth
                        height: workspaceButtonHeight
                        opacity: !Config.options?.bar.workspaces.showAppIcons ? 0 : (workspaceButtonBackground.biggestWindow && !root.showNumbers && Config.options?.bar.workspaces.showAppIcons) ? 1 : workspaceButtonBackground.biggestWindow ? workspaceIconOpacityShrinked : 0
                        visible: opacity > 0

                        IconImage {
                            id: mainAppIcon
                            anchors.centerIn: parent
                            source: workspaceButtonBackground.mainAppIconSource
                            implicitSize: root.workspaceIconSize

                            Behavior on opacity {
                                NumberAnimation {
                                    duration: 150
                                    easing.type: Easing.OutCubic
                                }
                            }
                            Behavior on implicitSize {
                                NumberAnimation {
                                    duration: 150
                                    easing.type: Easing.OutCubic
                                }
                            }
                        }

                        Loader {
                            active: Config.options.bar.workspaces.monochromeIcons
                            anchors.fill: mainAppIcon
                            sourceComponent: Item {
                                Desaturate {
                                    id: desaturatedIcon
                                    visible: false
                                    anchors.fill: parent
                                    source: mainAppIcon
                                    desaturation: 0.9
                                }
                                ColorOverlay {
                                    anchors.fill: desaturatedIcon
                                    source: desaturatedIcon
                                    color: ColorUtils.transparentize(button.isActive ? Appearance.m3colors.m3onPrimary : Appearance.m3colors.m3onSurfaceVariant, 0.1)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
