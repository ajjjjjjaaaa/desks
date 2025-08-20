import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.modules.common
import qs.modules.common.widgets

RippleButton {
    id: root
    Layout.alignment: Qt.AlignLeft
    implicitWidth: 40
    implicitHeight: 40
    Layout.leftMargin: 8
    onClicked: {
        parent.expanded = !parent.expanded;
    }
    buttonRadius: Appearance.rounding.normal
    contentItem: MaterialSymbol {
        id: icon
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        iconSize: 24
        color: Appearance.colors.colOnLayer1
        text: root.parent.expanded ? "menu_open" : "menu"
    }
}
