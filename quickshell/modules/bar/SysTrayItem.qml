import qs.modules.common
import qs.modules.common.functions
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects
import "."

MouseArea {
    id: root

    property var bar: root.root.root
    required property SystemTrayItem item
    property bool targetMenuOpen: true

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    implicitWidth: 18
    implicitHeight: 18
    onClicked: event => {
        switch (event.button) {
        case Qt.LeftButton:
            item.activate();
            break;
        case Qt.RightButton:
            if (item.hasMenu)
                menu.open();
            break;
        }
        event.accepted = true;
    }

    QsMenuAnchor {
        id: menu

        menu: root.item.menu
        anchor.window: Bar.bar
        anchor.rect.x: root.x + 50
        anchor.rect.y: root.y + 540
        anchor.rect.height: root.height
        anchor.rect.width: root.width
        anchor.edges: (Edges.Bottom | Edges.Right)
    }

    IconImage {
        id: trayIcon
        visible: false
        source: root.item.icon
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
    }

    Loader {
        active: Config.options.bar.tray.monochromeIcons
        anchors.fill: trayIcon
        sourceComponent: Item {
            Desaturate {
                id: desaturatedIcon
                visible: false // There's already color overlay
                anchors.fill: parent
                source: trayIcon
                desaturation: 0.8 // 1.0 means fully grayscale
            }
            ColorOverlay {
                anchors.fill: desaturatedIcon
                source: desaturatedIcon
                color: ColorUtils.transparentize(Appearance.colors.colOnLayer0, 0.9)
            }
        }
    }
}
