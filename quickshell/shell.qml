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

import qs.services

ShellRoot {
    property bool enableBar: true
    property bool enableNotifications: true
    property bool osd: true
    property bool popup: true
    property bool power: true
    property bool wall: true
    property bool dock: true
    property bool over: true
    property bool edges: true
    property bool ai: true

    Component.onCompleted: {
        MaterialThemeLoader.reapplyTheme();
        PersistentStateManager.loadStates();
        Cliphist.refresh();
    }

    LazyLoader {
        active: enableNotifications
        component: NotificationSystem {}
    }

    LazyLoader {
        active: wall
        component: Wallpaper {}
    }
    LazyLoader {
        active: wall
        component: WallpaperApp {}
    }
    LazyLoader {
        active: enableBar
        component: Bar {}
    }
    LazyLoader {
        active: popup
        component: Popup {}
    }
    LazyLoader {
        active: power
        component: Session {}
    }
    LazyLoader {
        active: edges
        component: ScreenCorners {}
    }
    LazyLoader {
        active: edges
        component: Lock {}
    }
    LazyLoader {
        active: over
        component: Overview {}
    }
    LazyLoader {
        active: ai
        component: SidebarLeft {}
    }
    LazyLoader {
        active: ai
        component: SidebarRight {}
    }

    LazyLoader {
        active: osd
        component: OnScreenDisplayBrightness {}
    }
    LazyLoader {
        active: osd
        component: OnScreenDisplayVolume {}
    }
}
