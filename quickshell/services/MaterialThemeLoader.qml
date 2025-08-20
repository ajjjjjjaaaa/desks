pragma Singleton
pragma ComponentBehavior: Bound

import qs.modules.common
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string filePath: Directories.generatedMaterialThemePath

    function reapplyTheme() {
        themeFileView.reload();
        console.log("woerks");
    }

    function applyColors(fileContent) {
        const json = JSON.parse(fileContent);
        for (const key in json) {
            if (json.hasOwnProperty(key)) {
                // Direct assignment since keys already match QML property names
                Appearance.m3colors[key] = json[key];
            }
        }
    }

    Timer {
        id: delayedFileRead
        interval: Config.options.hacks.arbitraryRaceConditionDelay ?? 100
        repeat: false
        running: false
        onTriggered: {
            root.applyColors(themeFileView.text());
        }
    }

    FileView {
        id: themeFileView
        path: Qt.resolvedUrl(root.filePath)
        watchChanges: true
        onFileChanged: {
            this.reload();
            delayedFileRead.start();
        }
        onLoadedChanged: {
            const fileContent = themeFileView.text();
            root.applyColors(fileContent);
        }
    }
}
