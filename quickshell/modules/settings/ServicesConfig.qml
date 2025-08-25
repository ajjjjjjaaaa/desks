import QtQuick
import QtQuick.Layouts
import qs
import qs.services
import qs.modules.common
import qs
    .modules
    .common
    .functions
import qs
    .modules
    .common
    .widgets
import Quickshell
ContentPage {
    forceWidth : true
    ContentSection {
        title : qsTr("AI")
        MaterialTextField {
            Layout.fillWidth : true
            placeholderText : qsTr("System prompt")
            text : Config
                .options
                .ai
                .systemPrompt
            wrapMode : TextEdit.Wrap
            onTextChanged : {
                Qt.callLater(() => {
                    Config
                        .options
                        .ai
                        .systemPrompt = text
                })
            }
        }
    }
    ContentSection {
        title : qsTr("Networking")
        MaterialTextField {
            Layout.fillWidth : true
            placeholderText : qsTr("User agent (for services that require it)")
            text : Config
                .options
                .networking
                .userAgent
            wrapMode : TextEdit.Wrap
            onTextChanged : {
                Config
                    .options
                    .networking
                    .userAgent = text
            }
        }
    }
    ContentSection {
        title : qsTr("Resources")
        ConfigSpinBox {
            text : qsTr("Polling interval (ms)")
            value : Config
                .options
                .resources
                .updateInterval
            from : 100
            to : 10000
            stepSize : 100
            onValueChanged : {
                Config
                    .options
                    .resources
                    .updateInterval = value
            }
        }
    }
    ContentSection {
        title : qsTr("Search")
        ConfigSwitch {
            text : qsTr("Use Levenshtein distance-based algorithm instead of fuzzy")
            checked : Config
                .options
                .search
                .sloppy
            onCheckedChanged : {
                Config
                    .options
                    .search
                    .sloppy = checked
            }
            StyledToolTip {
                content : qsTr("Could be better if you make a ton of typos,\nbut results can be weird and might not work with acronyms\n(e.g. \"GIMP\" might not give you the paint program)")
            }
        }
        ContentSubsection {
            title : qsTr("Prefixes")
            ConfigRow {
                uniform : true
                MaterialTextField {
                    Layout.fillWidth : true
                    placeholderText : qsTr("Action")
                    text : Config
                        .options
                        .search
                        .prefix
                        .action
                    wrapMode : TextEdit.Wrap
                    onTextChanged : {
                        Config
                            .options
                            .search
                            .prefix
                            .action = text
                    }
                }
                MaterialTextField {
                    Layout.fillWidth : true
                    placeholderText : qsTr("Clipboard")
                    text : Config
                        .options
                        .search
                        .prefix
                        .clipboard
                    wrapMode : TextEdit.Wrap
                    onTextChanged : {
                        Config
                            .options
                            .search
                            .prefix
                            .clipboard = text
                    }
                }
                MaterialTextField {
                    Layout.fillWidth : true
                    placeholderText : qsTr("Emojis")
                    text : Config
                        .options
                        .search
                        .prefix
                        .emojis
                    wrapMode : TextEdit.Wrap
                    onTextChanged : {
                        Config
                            .options
                            .search
                            .prefix
                            .emojis = text
                    }
                }
            }
        }
        ContentSubsection {
            title : qsTr("Web search")
            MaterialTextField {
                Layout.fillWidth : true
                placeholderText : qsTr("Base URL")
                text : Config
                    .options
                    .search
                    .engineBaseUrl
                wrapMode : TextEdit.Wrap
                onTextChanged : {
                    Config
                        .options
                        .search
                        .engineBaseUrl = text
                }
            }
        }
    }
    ContentSection {
        title : qsTr("Time")
        ContentSubsection {
            title : qsTr("Format")
            tooltip : ""
            ConfigSelectionArray {
                currentValue : Config
                    .options
                    .time
                    .format
                configOptionName : "time.format"
                onSelected : newValue => {
                    if (newValue === "hh:mm") {
                        Quickshell.execDetached([
                            "bash",
                            "-c",
                            `sed -i 's/\\TIME12\\b/TIME/' '${
                                FileUtils.trimFileProtocol(Directories.config)
                            }/hypr/hyprlock.conf'`
                        ])
                    } else {
                        Quickshell.execDetached([
                            "bash",
                            "-c",
                            `sed -i 's/\\TIME\\b/TIME12/' '${
                                FileUtils.trimFileProtocol(Directories.config)
                            }/hypr/hyprlock.conf'`
                        ])
                    }
                    Config
                        .options
                        .time
                        .format = newValue
                }
                options : [
                    {
                        displayName: qsTr("24h"),
                        value: "hh:mm"
                    }, {
                        displayName: qsTr("12h am/pm"),
                        value: "h:mm ap"
                    }, {
                        displayName: qsTr("12h AM/PM"),
                        value: "h:mm AP"
                    }
                ]
            }
        }
    }
}