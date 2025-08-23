import QtQuick
import QtQuick.Shapes

Item {
    id: root

    // Public API
    property string cornerType: "cubic" // "cubic", "rounded", or "inverted"
    property int cornerSize: 30
    property color color: "#000000"
    property var activeCorners: [0, 1, 2, 3] // 0=top-right, 1=top-left, 2=bottom-left, 3=bottom-right

    // Private properties for better organization
    readonly property var _cornerPositions: [
        {
            right: true,
            top: true,
            rotation: 0
        } // top-right
        ,
        {
            left: true,
            top: true,
            rotation: 90
        } // top-left
        ,
        {
            left: true,
            bottom: true,
            rotation: 180
        } // bottom-left
        ,
        {
            right: true,
            bottom: true,
            rotation: 270
        }  // bottom-right
    ]

    // Single repeater handles all corner types
    Repeater {
        model: root.activeCorners

        delegate: Shape {
            id: cornerShape

            readonly property int corner: modelData
            readonly property var position: root._cornerPositions[corner]

            width: root.cornerSize
            height: root.cornerSize
            asynchronous: true
            preferredRendererType: Shape.CurveRenderer

            // Dynamic anchoring based on corner position
            anchors.right: position.right ? root.right : undefined
            anchors.left: position.left ? root.left : undefined
            anchors.top: position.top ? root.top : undefined
            anchors.bottom: position.bottom ? root.bottom : undefined

            ShapePath {
                fillColor: root.color
                strokeWidth: 0

                // Dynamic path based on corner type
                Component.onCompleted: buildPath()
            }

            transform: Rotation {
                origin.x: root.cornerSize / 2
                origin.y: root.cornerSize / 2
                angle: position.rotation
            }

            function buildPath() {
                const path = cornerShape.children[0]; // ShapePath

                // Clear existing path elements
                for (let i = path.pathElements.length - 1; i >= 0; i--) {
                    path.pathElements[i].destroy();
                }

                const size = root.cornerSize;

                switch (root.cornerType) {
                case "cubic":
                    buildCubicPath(path, size);
                    break;
                case "rounded":
                    buildRoundedPath(path, size);
                    break;
                case "inverted":
                    buildInvertedPath(path, size);
                    break;
                }
            }

            function buildCubicPath(path, size) {
                path.startX = 0;
                path.startY = 0;

                const cubic = Qt.createQmlObject(`
                    import QtQuick.Shapes
                    PathCubic {
                        x: ${size}; y: ${size}
                        control1X: ${size / 2}; control1Y: 0
                        control2X: ${size / 2}; control2Y: ${size}
                    }`, path);

                const line = Qt.createQmlObject(`
                    import QtQuick.Shapes
                    PathLine { x: ${size}; y: 0 }`, path);
            }

            function buildRoundedPath(path, size) {
                path.startX = 0;
                path.startY = 0;

                const line1 = Qt.createQmlObject(`
                    import QtQuick.Shapes
                    PathLine { x: ${size}; y: 0 }`, path);

                const line2 = Qt.createQmlObject(`
                    import QtQuick.Shapes
                    PathLine { x: ${size}; y: ${size} }`, path);

                const arc = Qt.createQmlObject(`
                    import QtQuick.Shapes
                    PathArc {
                        x: 0; y: 0
                        radiusX: ${size}; radiusY: ${size}
                    }`, path);
            }

            function buildInvertedPath(path, size) {
                path.startX = 0;
                path.startY = 0;

                const arc = Qt.createQmlObject(`
                    import QtQuick.Shapes
                    PathArc {
                        x: ${size}; y: ${size}
                        radiusX: ${size}; radiusY: ${size}
                    }`, path);

                const line = Qt.createQmlObject(`
                    import QtQuick.Shapes
                    PathLine { x: ${size}; y: 0 }`, path);
            }

            // Rebuild path when corner type changes
            Connections {
                target: root
                function onCornerTypeChanged() {
                    cornerShape.buildPath();
                }
                function onCornerSizeChanged() {
                    cornerShape.buildPath();
                }
            }
        }
    }
}
