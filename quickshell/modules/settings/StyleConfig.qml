import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions

ContentPage {
    baseWidth: lightDarkButtonGroup.implicitWidth
    forceWidth: true

    Process {
        id: konachanWallProc
        property string status: ""
        command: ["bash", "-c", FileUtils.trimFileProtocol(`${Directories.scriptPath}/colors/random_konachan_wall.sh`)]
        stdout: SplitParser {
            onRead: data => {
                console.log(`Konachan wall proc output: ${data}`);
                konachanWallProc.status = data.trim();
            }
        }
    }

    ContentSection {
        title: qsTr("Colors & Wallpaper")

        // Light/Dark mode preference
        ButtonGroup {
            id: lightDarkButtonGroup
            Layout.fillWidth: true
            LightDarkPreferenceButton {
                dark: false
            }
            LightDarkPreferenceButton {
                dark: true
            }
        }

        // Material palette selection
        ContentSubsection {
            title: qsTr("Material palette")
            ConfigSelectionArray {
                currentValue: Config.options.appearance.palette.type
                configOptionName: "appearance.palette.type"
                onSelected: newValue => {
                    Config.options.appearance.palette.type = newValue;
                    Quickshell.execDetached(["bash", "-c", `${Directories.wallpaperSwitchScriptPath} --noswitch`]);
                }
                options: [
                    {
                        "value": "auto",
                        "displayName": qsTr("Auto")
                    },
                    {
                        "value": "scheme-content",
                        "displayName": qsTr("Content")
                    },
                    {
                        "value": "scheme-expressive",
                        "displayName": qsTr("Expressive")
                    },
                    {
                        "value": "scheme-fidelity",
                        "displayName": qsTr("Fidelity")
                    },
                    {
                        "value": "scheme-fruit-salad",
                        "displayName": qsTr("Fruit Salad")
                    },
                    {
                        "value": "scheme-monochrome",
                        "displayName": qsTr("Monochrome")
                    },
                    {
                        "value": "scheme-neutral",
                        "displayName": qsTr("Neutral")
                    },
                    {
                        "value": "scheme-rainbow",
                        "displayName": qsTr("Rainbow")
                    },
                    {
                        "value": "scheme-tonal-spot",
                        "displayName": qsTr("Tonal Spot")
                    }
                ]
            }
        }

        // Wallpaper selection
        ContentSubsection {
            title: qsTr("Wallpaper")
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                RippleButtonWithIcon {
                    materialIcon: "wallpaper"
                    implicitHeight: 40
                    StyledToolTip {
                        content: qsTr("Pick wallpaper image on your system")
                    }
                    onClicked: {
                        Quickshell.execDetached(`${Directories.wallpaperSwitchScriptPath}`);
                    }
                    mainContentComponent: Component {
                        RowLayout {
                            spacing: 10
                            StyledText {
                                font.pixelSize: Appearance.font.pixelSize.small
                                text: qsTr("Choose file")
                                color: Appearance.colors.colOnSecondaryContainer
                            }
                        }
                    }
                }
            }
        }

        StyledText {
            Layout.topMargin: 5
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Alternatively use /dark, /light, /img in the launcher")
            font.pixelSize: Appearance.font.pixelSize.smaller
            color: Appearance.colors.colSubtext
        }
    }

    ContentSection {
        title: qsTr("Decorations & Effects")

        ContentSubsection {
            title: qsTr("Transparency")

            ConfigRow {
                ConfigSwitch {
                    text: qsTr("Enable")
                    checked: Config.options.appearance.transparency.enable
                    onCheckedChanged: {
                        Config.options.appearance.transparency.enable = checked;
                    }
                    StyledToolTip {
                        content: qsTr("Might look ass. Unsupported.")
                    }
                }
            }
        }

        ContentSubsection {
            title: qsTr("Wallpaper parallax")

            ConfigRow {
                uniform: true
                ConfigSwitch {
                    text: qsTr("Depends on workspace")
                    checked: Config.options.background.parallax.enableWorkspace
                    onCheckedChanged: {
                        Config.options.background.parallax.enableWorkspace = checked;
                    }
                }
                ConfigSwitch {
                    text: qsTr("Depends on sidebars")
                    checked: Config.options.background.parallax.enableSidebar
                    onCheckedChanged: {
                        Config.options.background.parallax.enableSidebar = checked;
                    }
                }
            }
            ConfigSpinBox {
                text: qsTr("Preferred wallpaper zoom (%)")
                value: Config.options.background.parallax.workspaceZoom * 100
                from: 100
                to: 150
                stepSize: 1
                onValueChanged: {
                    console.log(value / 100);
                    Config.options.background.parallax.workspaceZoom = value / 100;
                }
            }
        }
    }
}
