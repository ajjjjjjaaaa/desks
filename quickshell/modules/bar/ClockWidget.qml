import qs.modules.common
import qs.modules.common.widgets
import qs.services
import QtQuick
import QtQuick.Layouts
Item {
    id : root
    property bool borderless : Config
        .options
        .bar
        .borderless
    implicitHeight : clockColumn.implicitHeight + 10
    implicitWidth : Appearance
        .sizes
        .verticalBarWidth
        anchors
        .horizontalCenter : parent.horizontalCenter
    ColumnLayout {
        id : clockColumn
        anchors.centerIn : parent
        spacing : 0
        Repeater {
            model : Config ?. options.bar.vertical
                ? DateTime.time.split(/[:]/)
                : [DateTime.time
                ]
            delegate : StyledText {
                required property string modelData
                Layout.alignment : Qt.AlignHCenter
                font.pixelSize : modelData.match(/am|pm/i)
                    ? Appearance
                        .font
                        .pixelSize
                        .smaller
                    : Appearance
                        .font
                        .pixelSize
                        .normal
                color : Appearance.colors.colOnLayer1
                text : modelData.padStart(2, "0") // Changed from 1 to 2 for proper padding
            }
        }
    }
}