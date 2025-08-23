import qs.modules.common
import qs.modules.common.widgets
import qs.services
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    property bool borderless: Config.options.bar.borderless
    implicitHeight: clockRow.implicitHeight
    implicitWidth: clockRow.implicitWidth - 48

    RowLayout {
        id: clockRow
        anchors.centerIn: parent
        spacing: 4

        Repeater {
            // Only take hours and minutes
            model: DateTime.time.split(/[:]/).slice(0, 2)

            delegate: StyledText {
                required property string modelData
                Layout.alignment: Qt.AlignVCenter
                font.pixelSize: modelData.match(/am|pm/i) ? Appearance.font.pixelSize.smaller : Appearance.font.pixelSize.normal
                color: Appearance.m3colors.m3primaryText
                text: modelData.padStart(2, "0")
            }
        }
    }
}
