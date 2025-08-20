import qs.modules.common
import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton
pragma ComponentBehavior: Bound

/**
 * Weather service.
 */
Singleton {
    id: root
    property string loc
    property string temperature
    property string condition
    property string raw
    property string weatherCode

        Timer {
        id: weatherTimer
        interval: 3600000 // 1 hour
        running: true
        repeat: true
        onTriggered: {
            getIp.running = true
        }
    }

    Process {
        id: getIp
        running: true
        command: ["curl", "ipinfo.io"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.loc = JSON.parse(text)["loc"]
                getWeather.running = true
            }
        }
    }

    Process {
        id: getWeather
        command: ["curl", `https://wttr.in/${root.loc}?format=j1`]
        stdout: StdioCollector {
            onStreamFinished: {
                const json = JSON.parse(text).current_condition[0];
                root.raw = text;
                root.condition = json.weatherDesc[0].value;
                root.temperature = json.temp_C + "°C";
                root.weatherCode = json.weatherCode;
            }
        }
    }

}