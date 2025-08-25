import qs
import qs.services
import qs.modules.common
import qs
    .modules
    .common
    .widgets
import qs
    .modules
    .common
    .functions
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import Qt5Compat.GraphicalEffects
import Quickshell.Io
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
ContentPage {
    baseWidth : lightDarkButtonGroup.implicitWidth
    forceWidth : true
    Process {
        id : konachanWallProc
        property string status : ""
        command : [
            "bash",
            "-c",
            FileUtils.trimFileProtocol(`${
                Directories.scriptPath
            }/colors/random_konachan_wall.sh`)
        ]
        stdout : SplitParser {
            onRead : data => {
                console.log(`Konachan wall proc output: ${data}`)
                konachanWallProc.status = data.trim()
            }
        }
    }
    ContentSection {
        title : qsTr("Colors & Wallpaper") // Material palette selection
        ContentSubsection {
            title : qsTr("Material palette")
            ConfigSelectionArray {
                currentValue : Config
                    .options
                    .appearance
                    .palette
                    .type
                configOptionName : "appearance.palette.type"
                onSelected : newValue => {
                    Config
                        .options
                        .appearance
                        .palette
                        .type = newValue
                    Quickshell.execDetached([
                        "bash",
                        "-c",
                        `${
                            Directories.wallpaperSwitchScriptPath
                        } --noswitch`
                    ])
                }
                options : [
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
                    }, {
                        "value": "scheme-fruit-salad",
                        "displayName": qsTr("Fruit Salad")
                    }, {
                        "value": "scheme-monochrome",
                        "displayName": qsTr("Monochrome")
                    }, {
                        "value": "scheme-neutral",
                        "displayName": qsTr("Neutral")
                    }, {
                        "value": "scheme-rainbow",
                        "displayName": qsTr("Rainbow")
                    }, {
                        "value": "scheme-tonal-spot",
                        "displayName": qsTr("Tonal Spot")
                    }
                ]
            }
        } // Wallpaper selection
        ContentSubsection {
            title : qsTr("Wallpaper")
            RowLayout {
                Layout.alignment : Qt.AlignHCenter
                spacing : 5
                RippleButtonWithIcon {
                    materialIcon : "light_mode"
                    implicitHeight : 40
                    StyledToolTip {
                        content : qsTr("Switch to light mode")
                    }
                    onClicked : {
                        Quickshell.execDetached([
                            "bash",
                            Quickshell.shellPath("scripts/colors/switchwall.sh"),
                            "--mode",
                            "light",
                            "--noswitch"
                        ])
                    }
                    mainContentComponent : Component {
                        RowLayout {
                            spacing : 10
                            StyledText {
                                font.pixelSize : Appearance
                                    .font
                                    .pixelSize
                                    .small
                                text : qsTr("Light")
                                color : Appearance.colors.colOnSecondaryContainer
                            }
                        }
                    }
                }
                RippleButtonWithIcon {
                    materialIcon : "dark_mode"
                    implicitHeight : 40
                    StyledToolTip {
                        content : qsTr("Switch to dark mode")
                    }
                    onClicked : {
                        Quickshell.execDetached([
                            "bash",
                            Quickshell.shellPath("scripts/colors/switchwall.sh"),
                            "--mode",
                            "dark",
                            "--noswitch"
                        ])
                    }
                    mainContentComponent : Component {
                        RowLayout {
                            spacing : 10
                            StyledText {
                                font.pixelSize : Appearance
                                    .font
                                    .pixelSize
                                    .small
                                text : qsTr("Dark")
                                color : Appearance.colors.colOnSecondaryContainer
                            }
                        }
                    }
                }
                RippleButtonWithIcon {
                    materialIcon : "wallpaper"
                    implicitHeight : 40
                    StyledToolTip {
                        content : qsTr("Pick wallpaper image on your system")
                    }
                    onClicked : {
                        Quickshell.execDetached(`${
                            Directories.wallpaperSwitchScriptPath
                        }`)
                    }
                    mainContentComponent : Component {
                        RowLayout {
                            spacing : 10
                            StyledText {
                                font.pixelSize : Appearance
                                    .font
                                    .pixelSize
                                    .small
                                text : qsTr("Choose file")
                                color : Appearance.colors.colOnSecondaryContainer
                            }
                        }
                    }
                }
            }
        }
    }
    ContentSection {
        title : qsTr("Decorations & Effects")
        ContentSubsection {
            title : qsTr("Transparency")
            ConfigRow {
                ConfigSwitch {
                    text : qsTr("Enable")
                    checked : Config
                        .options
                        .appearance
                        .transparency
                        .enable
                    onCheckedChanged : {
                        Config
                            .options
                            .appearance
                            .transparency
                            .enable = checked
                    }
                    StyledToolTip {
                        content : qsTr("Might look ass. Unsupported.")
                    }
                }
            }
        }
    }
}