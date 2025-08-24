import qs
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland

Scope {
    id: overviewScope
    property bool dontAutoCancelSearch: false
    
    Variants {
        id: overviewVariants
        model: Quickshell.screens
        
        PanelWindow {
            id: root
            required property var modelData
            property string searchingText: ""
            
            // Use CompositorService instead of direct Hyprland
            property bool monitorIsFocused: true // For niri, assume focused for now
            
            screen: modelData
            visible: GlobalStates.overviewOpen

            WlrLayershell.namespace: "quickshell:overview"
            WlrLayershell.layer: WlrLayer.Overlay
            color: "transparent"
            exclusiveZone: 0

            mask: Region {
                item: GlobalStates.overviewOpen ? columnLayout : null
            }

            anchors {
                left: true
                right: true
                bottom: true
            }

            // Replace HyprlandFocusGrab with generic approach
            property bool grabActive: false
            
            function activateGrab() {
                grabActive = true
                columnLayout.forceActiveFocus()
            }
            
            function clearGrab() {
                grabActive = false
                if (!grabActive) {
                    GlobalStates.overviewOpen = false
                }
            }

            Connections {
                target: GlobalStates
                function onOverviewOpenChanged() {
                    if (!GlobalStates.overviewOpen) {
                        searchWidget.disableExpandAnimation()
                        overviewScope.dontAutoCancelSearch = false
                        root.clearGrab()
                    } else {
                        if (!overviewScope.dontAutoCancelSearch) {
                            searchWidget.cancelSearch()
                        }
                        delayedGrabTimer.start()
                    }
                }
            }

            Timer {
                id: delayedGrabTimer
                interval: Config.options.hacks.arbitraryRaceConditionDelay || 100
                repeat: false
                onTriggered: {
                    if (GlobalStates.overviewOpen) {
                        root.activateGrab()
                    }
                }
            }

            implicitWidth: columnLayout.implicitWidth
            implicitHeight: columnLayout.implicitHeight

            function setSearchingText(text) {
                searchWidget.setSearchingText(text)
                searchWidget.focusFirstItem()
            }

            ColumnLayout {
                id: columnLayout
                visible: GlobalStates.overviewOpen
                focus: true
                
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: !Config.options.bar.bottom ? parent.top : undefined
                    bottom: Config.options.bar.bottom ? parent.bottom : undefined
                }

                Keys.onPressed: event => {
                    if (event.key === Qt.Key_Escape) {
                        GlobalStates.overviewOpen = false
                    } else if (event.key === Qt.Key_Left) {
                        if (!root.searchingText) {
                            // Use CompositorService for workspace switching
                            const currentWs = CompositorService.getCurrentWorkspace()
                            if (currentWs && currentWs.idx > 1) {
                                CompositorService.switchToWorkspace(currentWs.idx - 1)
                            }
                        }
                    } else if (event.key === Qt.Key_Right) {
                        if (!root.searchingText) {
                            // Use CompositorService for workspace switching
                            const currentWs = CompositorService.getCurrentWorkspace()
                            if (currentWs) {
                                CompositorService.switchToWorkspace(currentWs.idx + 1)
                            }
                        }
                    }
                }

                Item {
                    height: 0 // Prevent Wayland protocol error
                    width: 1 // Prevent Wayland protocol error
                }

                SearchWidget {
                    id: searchWidget
                    onSearchingTextChanged: text => {
                        root.searchingText = searchingText
                    }
                }


            }
        }
    }

    IpcHandler {
        target: "overview"

        function toggle() {
            GlobalStates.overviewOpen = !GlobalStates.overviewOpen
        }
        function close() {
            GlobalStates.overviewOpen = false
        }
        function open() {
            GlobalStates.overviewOpen = true
        }
        function toggleReleaseInterrupt() {
            GlobalStates.superReleaseMightTrigger = false
        }
    }

    GlobalShortcut {
        name: "overviewToggle"
        description: qsTr("Toggles overview on press")

        onPressed: {
            GlobalStates.overviewOpen = !GlobalStates.overviewOpen
        }
    }
    
    GlobalShortcut {
        name: "overviewClose"
        description: qsTr("Closes overview")

        onPressed: {
            GlobalStates.overviewOpen = false
        }
    }
    
    GlobalShortcut {
        name: "overviewToggleRelease"
        description: qsTr("Toggles overview on release")

        onPressed: {
            GlobalStates.superReleaseMightTrigger = true
        }

        onReleased: {
            if (!GlobalStates.superReleaseMightTrigger) {
                GlobalStates.superReleaseMightTrigger = true
                return
            }
            GlobalStates.overviewOpen = !GlobalStates.overviewOpen
        }
    }
    
    GlobalShortcut {
        name: "overviewToggleReleaseInterrupt"
        description: qsTr("Interrupts possibility of overview being toggled on release. ") + qsTr("This is necessary because GlobalShortcut.onReleased in quickshell triggers whether or not you press something else while holding the key. ") + qsTr("To make sure this works consistently, use binditn = MODKEYS, catchall in an automatically triggered submap that includes everything.")

        onPressed: {
            GlobalStates.superReleaseMightTrigger = false
        }
    }
    
    GlobalShortcut {
        name: "overviewClipboardToggle"
        description: qsTr("Toggle clipboard query on overview widget")

        onPressed: {
            if (GlobalStates.overviewOpen && overviewScope.dontAutoCancelSearch) {
                GlobalStates.overviewOpen = false
                return
            }
            
            // For niri, we don't have monitor focus detection, so use first available
            for (let i = 0; i < overviewVariants.instances.length; i++) {
                let panelWindow = overviewVariants.instances[i]
                // Use first screen or try to match current focused screen
                if (i === 0) {  // Simplified for niri
                    overviewScope.dontAutoCancelSearch = true
                    panelWindow.setSearchingText(Config.options.search.prefix.clipboard)
                    GlobalStates.overviewOpen = true
                    return
                }
            }
        }
    }

    GlobalShortcut {
        name: "overviewEmojiToggle"
        description: qsTr("Toggle emoji query on overview widget")

        onPressed: {
            if (GlobalStates.overviewOpen && overviewScope.dontAutoCancelSearch) {
                GlobalStates.overviewOpen = false
                return
            }
            
            // For niri, we don't have monitor focus detection, so use first available
            for (let i = 0; i < overviewVariants.instances.length; i++) {
                let panelWindow = overviewVariants.instances[i]
                // Use first screen or try to match current focused screen
                if (i === 0) {  // Simplified for niri
                    overviewScope.dontAutoCancelSearch = true
                    panelWindow.setSearchingText(Config.options.search.prefix.emojis)
                    GlobalStates.overviewOpen = true
                    return
                }
            }
        }
    }
}