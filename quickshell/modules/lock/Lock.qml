import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import qs.modules.common
import qs.modules.common.functions

Item {
    // This stores all the information shared between the lock surfaces on each screen.

    GlobalShortcut {
        name: "locked"

        onPressed: {
            lock.locked = true;
        }
    }

    LockContext {
        id: lockContext

        onUnlocked: {
            // Unlock the screen before exiting, or the compositor will display a
            // fallback lock you can't interact with.
            lock.locked = false;
        }
    }

    WlSessionLock {
        id: lock

        // Lock the session immediately when quickshell starts.
        locked: false

        WlSessionLockSurface {
            color: ColorUtils.transparentize(Appearance.m3colors.m3layerBackground2, 1)
            LockSurface {
                anchors.fill: parent
                context: lockContext
            }
        }
    }
}
