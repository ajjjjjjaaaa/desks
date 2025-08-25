import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs
import qs.modules.common
import qs.modules.common.widgets
import qs.services

ContentPage {
    forceWidth: true

    ContentSection {
        title: qsTr("Distro")

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20
            Layout.topMargin: 10
            Layout.bottomMargin: 10

            IconImage {
                implicitSize: 80
                source: Quickshell.iconPath(SystemInfo.logo)
            }

            ColumnLayout {
                Layout.alignment: Qt.AlignVCenter

                // spacing: 10
                StyledText {
                    text: SystemInfo.distroName
                    font.pixelSize: Appearance.font.pixelSize.title
                }

                StyledText {
                    font.pixelSize: Appearance.font.pixelSize.normal
                    text: SystemInfo.homeUrl
                    textFormat: Text.MarkdownText
                    onLinkActivated: (link) => {
                        Qt.openUrlExternally(link);
                    }

                    PointingHandLinkHover {
                    }

                }

            }

        }

        Flow {
            Layout.fillWidth: true
            spacing: 5

            RippleButtonWithIcon {
                materialIcon: "auto_stories"
                mainText: qsTr("Documentation")
                onClicked: {
                    Qt.openUrlExternally(SystemInfo.documentationUrl);
                }
            }

            RippleButtonWithIcon {
                materialIcon: "support"
                mainText: qsTr("Help & Support")
                onClicked: {
                    Qt.openUrlExternally(SystemInfo.supportUrl);
                }
            }

            RippleButtonWithIcon {
                materialIcon: "bug_report"
                mainText: qsTr("Report a Bug")
                onClicked: {
                    Qt.openUrlExternally(SystemInfo.bugReportUrl);
                }
            }

            RippleButtonWithIcon {
                materialIcon: "policy"
                materialIconFill: false
                mainText: qsTr("Privacy Policy")
                onClicked: {
                    Qt.openUrlExternally(SystemInfo.privacyPolicyUrl);
                }
            }

        }

    }

}
