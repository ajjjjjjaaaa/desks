import qs
import qs.services
import qs.modules.common
import qs
    .modules
    .common
    .widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
Scope {
    id : overviewScope
    property bool dontAutoCancelSearch : false
    Variants {
        id : overviewVariants
        model : Quickshell.screens
        PanelWindow {
            id : root
            required property var modelData
            property string searchingText : ""
            readonly property var monitor: modelData
            property bool monitorIsFocused : true // For Niri, we'll assume focus for now
            screen : modelData
            visible : GlobalStates.overviewOpen
            WlrLayershell.namespace : "quickshell:overview"
            WlrLayershell.layer : WlrLayer.Overlay
            WlrLayershell.keyboardFocus : GlobalStates.overviewOpen
                ? WlrKeyboardFocus.OnDemand
                : WlrKeyboardFocus.None
            color : "transparent"
            exclusiveZone : 0
            mask : Region {
                item : GlobalStates.overviewOpen
                    ? columnLayout
                    : null
            }
            anchors {
                left : true
                right : true
                bottom : true
            }
            Connections {
                target : GlobalStates
                function onOverviewOpenChanged() {
                    if (!GlobalStates.overviewOpen) {
                        searchWidget.disableExpandAnimation()
                        overviewScope.dontAutoCancelSearch = false
                    } else {
                        if (!overviewScope.dontAutoCancelSearch) {
                            searchWidget.cancelSearch()
                        }
                        delayedGrabTimer.start() // Focus the search widget when overview opens
                        Qt.callLater(() => {
                            searchWidget.forceActiveFocus()
                        })
                    }
                }
            }
            Timer {
                id : delayedGrabTimer
                interval : Config
                    .options
                    .hacks
                    .arbitraryRaceConditionDelay
                repeat : false
                onTriggered :
                // Niri-specific logic can be added here if needed
                {}
            }
            implicitWidth : columnLayout.implicitWidth
            implicitHeight : columnLayout.implicitHeight
            function setSearchingText(text) {
                searchWidget
                    .setSearchingText(text)
                    searchWidget
                    .focusFirstItem() // Ensure keyboard focus
                    searchWidget
                    .forceActiveFocus()
            }
            ColumnLayout {
                id : columnLayout
                visible : GlobalStates.overviewOpen
                anchors {
                    horizontalCenter : parent.horizontalCenter
                    top : parent.top
                    bottom : parent.bottom
                }
                Item {
                    height : 1 // Prevent Wayland protocol error
                    width : 1 // Prevent Wayland protocol error
                }
                SearchWidget {
                    id : searchWidget
                    Layout.alignment : Qt.AlignHCenter
                    focus : GlobalStates.overviewOpen
                    onSearchingTextChanged : text => {
                        root.searchingText = searchingText
                    }
                    Component.onCompleted : {
                        if (GlobalStates.overviewOpen) {
                            forceActiveFocus()
                        }
                    }
                }
            }
        }
    }
    IpcHandler {
        target : "overview"
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
}