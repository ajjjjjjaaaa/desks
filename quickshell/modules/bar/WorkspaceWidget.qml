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

Item {
    id: root
    property bool borderless: false
    
    property int workspaceButtonWidth: Appearance.sizes.barWidth / 2
    property int workspaceButtonHeight: Appearance.sizes.barWidth / 1.70
    property int maxWorkspaces: Config.options.bar.workspaces.shown || 10

    property bool horizontal: false
    property real containerSpacing: 1

    implicitHeight: columnLayout.implicitHeight + (containerSpacing * 2)
    implicitWidth: workspaceButtonWidth + 10

    // Get workspace data from CompositorService
    property var workspaces: CompositorService.workspaces
    property list<bool> workspaceOccupied: []

    // Update workspace occupancy when workspaces change
    Connections {
        target: CompositorService
        function onWorkspaceChanged() {
            updateWorkspaceOccupied()
        }
    }

    Component.onCompleted: {
        updateWorkspaceOccupied()
    }

    function updateWorkspaceOccupied() {
        const occupied = []
        
        // Create array showing which workspace slots are occupied
        for (let i = 0; i < maxWorkspaces; i++) {
            const workspaceId = i + 1
            let isOccupied = false
            
            // Check if workspace exists and is occupied
            for (let j = 0; j < workspaces.count; j++) {
                const ws = workspaces.get(j)
                if (ws.idx === workspaceId && ws.isOccupied) {
                    isOccupied = true
                    break
                }
            }
            
            occupied[i] = isOccupied
        }
        
        workspaceOccupied = occupied
    }

    function isWorkspaceActive(workspaceId) {
        for (let i = 0; i < workspaces.count; i++) {
            const ws = workspaces.get(i)
            if (ws.idx === workspaceId && ws.isFocused) {
                return true
            }
        }
        return false
    }

    function switchToWorkspace(workspaceId) {
        CompositorService.switchToWorkspace(workspaceId)
    }

    WheelHandler {
        property real accumulatedDelta: 0
        readonly property real threshold: 120

        onWheel: event => {
            accumulatedDelta += event.angleDelta.y

            if (Math.abs(accumulatedDelta) >= threshold) {
                // Get current workspace
                let currentId = 1
                for (let i = 0; i < workspaces.count; i++) {
                    const ws = workspaces.get(i)
                    if (ws.isFocused) {
                        currentId = ws.idx
                        break
                    }
                }
                
                // Calculate next workspace
                let nextId = currentId + (accumulatedDelta < 0 ? 1 : -1)
                nextId = Math.max(1, Math.min(maxWorkspaces, nextId))
                
                switchToWorkspace(nextId)
                accumulatedDelta = 0
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
        color: "transparent"

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
            model: maxWorkspaces

            Rectangle {
                z: 1
                implicitWidth: workspaceButtonWidth
                implicitHeight: workspaceButtonHeight
                radius: 0

                property bool isOccupied: index < workspaceOccupied.length ? workspaceOccupied[index] : false
                property bool isActive: root.isWorkspaceActive(index + 1)
                property bool previousOccupied: index > 0 && index - 1 < workspaceOccupied.length ? workspaceOccupied[index - 1] : false
                property bool nextOccupied: index < maxWorkspaces - 1 && index + 1 < workspaceOccupied.length ? workspaceOccupied[index + 1] : false

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
        id: columnLayoutButtons
        z: 3
        spacing: containerSpacing
        anchors.fill: parent
        anchors.margins: 4
        implicitWidth: workspaceButtonWidth

        Repeater {
            model: maxWorkspaces

            Button {
                id: button
                property int workspaceValue: index + 1
                property bool isActive: root.isWorkspaceActive(workspaceValue)
                property bool isOccupied: index < workspaceOccupied.length ? workspaceOccupied[index] : false

                Layout.fillWidth: true
                implicitHeight: workspaceButtonHeight

                onPressed: root.switchToWorkspace(workspaceValue)

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

                    // Simple dot indicator
                    Rectangle {
                        id: wsDot
                        anchors.centerIn: parent
                        width: button.isActive ? 6 : 4
                        height: width
                        radius: width / 2
                        color: button.isActive ? Appearance.m3colors.m3primaryText : (button.isOccupied ? Appearance.m3colors.m3selectionText : Appearance.m3colors.m3selectionText)

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
                }
            }
        }
    }
}