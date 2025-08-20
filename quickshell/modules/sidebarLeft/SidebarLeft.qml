import qs
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import Qt5Compat.GraphicalEffects
import Quickshell.Io
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland

Scope { // Scope
    id: root
    property int sidebarPadding: 15
    property bool detach: false
    property Component contentComponent: SidebarLeftContent {}
    property Item sidebarContent

    Component.onCompleted: {
        root.sidebarContent = contentComponent.createObject(null, {
            "scopeRoot": root
        });
        sidebarLoader.item.contentParent.children = [root.sidebarContent];
    }

    onDetachChanged: {
        if (root.detach) {
            sidebarContent.parent = null; // Detach content from sidebar
            sidebarLoader.active = false; // Unload sidebar
            detachedSidebarLoader.active = true; // Load detached window
            detachedSidebarLoader.item.contentParent.children = [sidebarContent];
        } else {
            sidebarContent.parent = null; // Detach content from window
            detachedSidebarLoader.active = false; // Unload detached window
            sidebarLoader.active = true; // Load sidebar
            sidebarLoader.item.contentParent.children = [sidebarContent];
        }
    }

    Loader {
        id: sidebarLoader
        active: true

        sourceComponent: PanelWindow { // Window
            id: sidebarRoot
            visible: GlobalStates.sidebarLeftOpen

            property bool extend: false
            property real sidebarWidth: Appearance.sizes.sidebarWidth
            property var contentParent: sidebarLeftBackground

            function hide() {
                GlobalStates.sidebarLeftOpen = false;
            }

            exclusiveZone: 0
            implicitWidth: 460
            WlrLayershell.namespace: "quickshell:sidebarLeft"
            // Hyprland 0.49: OnDemand is Exclusive, Exclusive just breaks click-outside-to-close
            // WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
            color: "transparent"

            anchors {
                left: true
                bottom: true
                top: true
            }

            implicitHeight: 520

            mask: Region {
                item: sidebarLeftBackground
            }

            HyprlandFocusGrab { // Click outside to close
                id: grab
                windows: [sidebarRoot]
                active: sidebarRoot.visible
                onCleared: () => {
                    if (!active)
                        sidebarRoot.hide();
                }
            }

            // Content
            StyledRectangularShadow {
                target: sidebarLeftBackground
                radius: sidebarLeftBackground.radius
                visible: Config.options.appearance.transparency
            }
            Rectangle {
                id: sidebarLeftBackground
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: Appearance.sizes.hyprlandGapsOut
                anchors.leftMargin: Appearance.sizes.hyprlandGapsOut
                width: sidebarRoot.sidebarWidth - Appearance.sizes.hyprlandGapsOut - Appearance.sizes.elevationMargin
                height: parent.height - Appearance.sizes.hyprlandGapsOut * 2
                color: Appearance.m3colors.m3background
                radius: Appearance.rounding.normal
                border.color: Appearance.m3colors.m3borderPrimary

                Behavior on width {
                    animation: Appearance.animation.elementMove.numberAnimation.createObject(this)
                }
            }
        }
    }

    Loader {
        id: detachedSidebarLoader
        active: false

        sourceComponent: FloatingWindow {
            id: detachedSidebarRoot
            visible: GlobalStates.sidebarLeftOpen
            property var contentParent: detachedSidebarBackground

            Rectangle {
                id: detachedSidebarBackground
                anchors.fill: parent
                color: Appearance.colors.colLayer0

                Keys.onPressed: event => {
                    if (event.modifiers === Qt.ControlModifier) {
                        if (event.key === Qt.Key_P) {
                            root.detach = !root.detach;
                        }
                        event.accepted = true;
                    }
                }
            }
        }
    }

    IpcHandler {
        target: "sidebarLeft"

        function toggle(): void {
            GlobalStates.sidebarLeftOpen = !GlobalStates.sidebarLeftOpen;
        }

        function close(): void {
            GlobalStates.sidebarLeftOpen = false;
        }

        function open(): void {
            GlobalStates.sidebarLeftOpen = true;
        }
    }

    GlobalShortcut {
        name: "sidebarLeftToggle"
        description: qsTr("Toggles left sidebar on press")

        onPressed: {
            GlobalStates.sidebarLeftOpen = !GlobalStates.sidebarLeftOpen;
        }
    }

    GlobalShortcut {
        name: "sidebarLeftOpen"
        description: qsTr("Opens left sidebar on press")

        onPressed: {
            GlobalStates.sidebarLeftOpen = true;
        }
    }

    GlobalShortcut {
        name: "sidebarLeftClose"
        description: qsTr("Closes left sidebar on press")

        onPressed: {
            GlobalStates.sidebarLeftOpen = false;
        }
    }

    GlobalShortcut {
        name: "sidebarLeftToggleDetach"
        description: qsTr("Detach left sidebar into a window/Attach it back")

        onPressed: {
            root.detach = !root.detach;
        }
    }
}
