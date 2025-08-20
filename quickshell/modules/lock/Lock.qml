import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick

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
            color: "transparent"
            LockSurface {
                anchors.fill: parent
                context: lockContext
            }
        }
    }
}
