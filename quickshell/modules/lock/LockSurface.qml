import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Quickshell.Wayland
import Quickshell
import qs.modules.common
import qs.modules.common.functions


Rectangle {
    id: root
    required property LockContext context

    // Animation properties
    property bool isOpening: true
    property bool isClosing: false

    color: Appearance.m3colors.m3layerBackground2

    // Overall opacity for fade animations
    opacity: 0

    // Scale transform for zoom effect
    transform: Scale {
        id: rootScale
        origin.x: root.width / 2
        origin.y: root.height / 2
        xScale: 0.8
        yScale: 0.8
    }

    // Opening animation
    SequentialAnimation {
        id: openAnimation
        running: root.isOpening

        ParallelAnimation {
            NumberAnimation {
                target: root
                property: "opacity"
                from: 0
                to: 1
                duration: 800
                easing.type: Easing.OutQuart
            }

            NumberAnimation {
                target: rootScale
                property: "xScale"
                from: 0.8
                to: 1
                duration: 800
                easing.type: Easing.OutBack
                easing.overshoot: 1.2
            }

            NumberAnimation {
                target: rootScale
                property: "yScale"
                from: 0.8
                to: 1
                duration: 800
                easing.type: Easing.OutBack
                easing.overshoot: 1.2
            }
        }

        onFinished: root.isOpening = false
    }

    // Closing animation
    SequentialAnimation {
        id: closeAnimation
        running: root.isClosing

        ParallelAnimation {
            NumberAnimation {
                target: root
                property: "opacity"
                from: 1
                to: 0
                duration: 500
                easing.type: Easing.InQuart
            }

            NumberAnimation {
                target: rootScale
                property: "xScale"
                from: 1
                to: 0.7
                duration: 500
                easing.type: Easing.InBack
            }

            NumberAnimation {
                target: rootScale
                property: "yScale"
                from: 1
                to: 0.7
                duration: 500
                easing.type: Easing.InBack
            }
        }

        onFinished: {
            root.isClosing = false
            // Handle actual unlock here if needed
        }
    }

    // Trigger closing animation when unlock succeeds
    Connections {
        target: root.context
        function onUnlockSucceeded() {
            root.isClosing = true
        }
    }

    Label {
        id: clock
        property var date: new Date()
        property real randomX: Math.random() * (parent.width * 0.6) + (parent.width * 0.2)
        property real randomY: Math.random() * (parent.height * 0.4) + (parent.height * 0.1)

        x: randomX
        y: randomY

        // Clock entrance animation
        opacity: 0
        transform: Translate {
            id: clockTransform
            y: -50
        }

        // The native font renderer tends to look nicer at large sizes.
        renderType: Text.NativeRendering
        font.pointSize: 80
        font.family: Appearance.font.family.uiBigFont
        color: Appearance.m3colors.m3primaryText

        // Clock animation - delayed start
        SequentialAnimation {
            running: root.isOpening

            PauseAnimation { duration: 400 }

            ParallelAnimation {
                NumberAnimation {
                    target: clock
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 600
                    easing.type: Easing.OutQuart
                }

                NumberAnimation {
                    target: clockTransform
                    property: "y"
                    from: -50
                    to: 0
                    duration: 600
                    easing.type: Easing.OutBack
                }
            }
        }

        // updates the clock every second
        Timer {
            running: true
            repeat: true
            interval: 1000
            onTriggered: clock.date = new Date()
        }

        // updated when the date changes
        text: {
            const hours = this.date.getHours().toString().padStart(2, '0');
            const minutes = this.date.getMinutes().toString().padStart(2, '0');
            return `${hours}:${minutes}`;
        }
    }

    ColumnLayout {
        id: loginArea
        // Uncommenting this will make the password entry invisible except on the active monitor.
        // visible: Window.active

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.verticalCenter
        }

        // Login area entrance animation
        opacity: 0
        transform: Translate {
            id: loginTransform
            y: 30
        }

        // Login area animation - more delayed
        SequentialAnimation {
            running: root.isOpening

            PauseAnimation { duration: 600 }

            ParallelAnimation {
                NumberAnimation {
                    target: loginArea
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 500
                    easing.type: Easing.OutQuart
                }

                NumberAnimation {
                    target: loginTransform
                    property: "y"
                    from: 30
                    to: 0
                    duration: 500
                    easing.type: Easing.OutQuart
                }
            }
        }

        RowLayout {
            Rectangle {
                id: passwordFieldContainer
                Layout.preferredWidth: 300
                Layout.preferredHeight: 35
                radius: 5
                color: Appearance.m3colors.m3layerBackground1

                // Subtle hover/focus animations
                Behavior on color {
                    ColorAnimation { duration: 200 }
                }

                // Pulse animation on wrong password
                SequentialAnimation {
                    id: shakeAnimation

                    PropertyAnimation {
                        target: passwordFieldContainer
                        property: "x"
                        from: 0; to: -10
                        duration: 50
                    }
                    PropertyAnimation {
                        target: passwordFieldContainer
                        property: "x"
                        from: -10; to: 10
                        duration: 100
                    }
                    PropertyAnimation {
                        target: passwordFieldContainer
                        property: "x"
                        from: 10; to: -5
                        duration: 100
                    }
                    PropertyAnimation {
                        target: passwordFieldContainer
                        property: "x"
                        from: -5; to: 0
                        duration: 50
                    }
                }

                TextField {
                    id: passwordBox
                    anchors.fill: parent
                    anchors.margins: 2
                    leftPadding: 15
                    rightPadding: 15
                    focus: true
                    enabled: !root.context.unlockInProgress
                    echoMode: TextInput.Password
                    inputMethodHints: Qt.ImhSensitiveData
                    font.family: Appearance.font.family.uiFont
                    color: Appearance.m3colors.m3primaryText

                    background: Rectangle {
                        radius: 10
                        color: "transparent"
                    }

                    // Update the text in the context when the text in the box changes.
                    onTextChanged: root.context.currentText = this.text

                    // Try to unlock when enter is pressed.
                    onAccepted: root.context.tryUnlock()

                    // Update the text in the box to match the text in the context.
                    // This makes sure multiple monitors have the same text.
                    Connections {
                        target: root.context
                        function onCurrentTextChanged() {
                            passwordBox.text = root.context.currentText;
                        }

                        function onUnlockFailed() {
                            shakeAnimation.start()
                        }
                    }
                }
            }
        }

        Label {
            id: errorLabel
            visible: root.context.showFailure
            text: "Wrong! try again"
            font.family: Appearance.font.family.uiFont
            color: Appearance.m3colors.m3primaryText

            // Error message animation
            opacity: visible ? 1 : 0
            Behavior on opacity {
                NumberAnimation { duration: 300 }
            }
        }
    }
}
