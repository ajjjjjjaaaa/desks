 // @ pragma UseQApplication // @ pragma Env QS_NO_RELOAD_POPUP=1 // @ pragma Env QT_QUICK_CONTROLS_STYLE=Basic // @ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000 // @ pragma Env QT_SCALE_FACTOR=1
import QtQuick
import Quickshell
import "./modules/widgets"
import "./modules/notifications"
import "./modules/bar"
import "./modules/osd"
import "./modules/rldpopup"
import "./modules/session"
import "./modules/ScreenCorners"
import "./modules/wallpaperUtils"
import "./modules/lock"
import "./modules/common"
import "./modules/overview"
import "./modules/sidebarLeft"
import "./modules/sidebarRight"
import "./modules/notch"
import "./modules/dock"
import qs.services
ShellRoot {
    property bool enableBar : true
    property bool enableNotifications : true
    property bool osd : true
    property bool popup : true
    property bool power : true
    property bool wall : true
    property bool dock : false
    property bool over : true
    property bool edges : true
    property bool ai : false
    property bool notifs : true
    property bool notch : true
    Component.onCompleted : {
        MaterialThemeLoader
            .reapplyTheme()
            PersistentStateManager
            .loadStates()
            Cliphist
            .refresh()
    }
    LazyLoader {
        active : enableNotifications
        component : NotificationSystem {}
    }
    LazyLoader {
        active : wall
        component : Wallpaper {}
    }
    LazyLoader {
        active : enableBar
        component : Bar {}
    }
    LazyLoader {
        active : popup
        component : Popup {}
    }
    LazyLoader {
        active : power
        component : Session {}
    }
    LazyLoader {
        active : edges
        component : ScreenCorners {}
    }
    LazyLoader {
        active : edges
        component : Lock {}
    }
    LazyLoader {
        active : over
        component : Overview {}
    }
    LazyLoader {
        active : notifs
        component : SidebarRight {}
    }
    LazyLoader {
        active : osd
        component : OnScreenDisplayBrightness {}
    }
    LazyLoader {
        active : osd
        component : OnScreenDisplayVolume {}
    }
    LazyLoader {
        active : notch
        component : Notch {}
    }
    LazyLoader {
        active : dock
        component : Dock {}
    }
}