import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.common

Scope {
    id: root
    property bool failed
    property string errorString

    // Connect to the Quickshell global to listen for the reload signals.
    Connections {
        target: Quickshell

        function onReloadCompleted() {
            Quickshell.inhibitReloadPopup();
            root.failed = false;
            popupLoader.loading = true;
        }

        function onReloadFailed(error: string) {
            Quickshell.inhibitReloadPopup();
            // Close any existing popup before making a new one.
            popupLoader.active = false;

            root.failed = true;
            root.errorString = error;
            popupLoader.loading = true;
        }
    }

    // Keep the popup in a loader because it isn't needed most of the timeand will take up
    // memory that could be used for something else.
    LazyLoader {
        id: popupLoader

        PanelWindow {
            id: popup

            anchors {
                top: true
            }

            exclusiveZone: 0

            margins {
                top: 5
                // left: 8
            }

            width: rect.width
            height: rect.height

            // color blending is a bit odd as detailed in the type reference.
            color: "transparent"

            Rectangle {
                id: rect
                color: failed ? Appearance.m3colors.m3error : Appearance.m3colors.m3tertiary
                radius: 5
                implicitHeight: layout.implicitHeight + 40
                implicitWidth: layout.implicitWidth + 40

                // Fills the whole area of the rectangle, making any clicks go to it,
                // which dismiss the popup.
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: popupLoader.active = false

                    // makes the mouse area track mouse hovering, so the hide animation
                    // can be paused when hovering.
                    hoverEnabled: true
                }

                ColumnLayout {
                    id: layout
                    anchors {
                        top: parent.top
                        topMargin: 20
                        horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: root.failed ? "Desktopia Not Reloaded" : "Desktopia reloaded!"
                        color: Appearance.m3colors.m3layerBackground3
                        font.family: Appearance.font.family.uiFont
                    }

                    Text {
                        text: root.errorString
                        color: Appearance.m3colors.m3primaryText
                        font.family: Appearance.font.family.uiFont
                        visible: root.errorString != ""
                    }
                }

                // A progress bar on the bottom of the screen, showing how long until the
                // popup is removed.
                Rectangle {
                    id: bar
                    color: Appearance.m3colors.m3primaryText
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    height: 5
                    radius: 10
                    anchors.margins: 10
                    PropertyAnimation {
                        id: anim
                        target: bar
                        property: "width"
                        from: rect.width
                        to: 0
                        duration: failed ? 10000 : 800
                        onFinished: popupLoader.active = false
                        paused: mouseArea.containsMouse
                    }
                }

                // We could set `running: true` inside the animation, but the width of the
                // rectangle might not be calculated yet, due to the layout.
                // In the `Component.onCompleted` event handler, all of the component's
                // properties and children have been initialized.
                Component.onCompleted: anim.start()
            }
        }
    }
}
