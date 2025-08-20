pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell

Singleton {
    id: root
    property QtObject m3colors
    property QtObject animation
    property QtObject animationCurves
    property QtObject colors
    property QtObject rounding
    property QtObject font
    property QtObject sizes

    property real transparency: 0.6
    property real contentTransparency: 0.1
    property real workpaceTransparency: 0.8

    m3colors: QtObject {
        property bool darkmode: true
        property bool transparent: true

        // Core surface colors
        property color m3background: "{{colors.background.default.hex}}"
        property color m3onBackground: "{{colors.on_background.default.hex}}"
        property color m3surface: "{{colors.surface.default.hex}}"
        property color m3onSurface: "{{colors.on_surface.default.hex}}"
        property color m3surfaceVariant: "{{colors.surface_variant.default.hex}}"
        property color m3onSurfaceVariant: "{{colors.on_surface_variant.default.hex}}"

        // Surface container colors
        property color m3surfaceContainer: "{{colors.surface_container.default.hex}}"
        property color m3surfaceContainerLow: "{{colors.surface_container_low.default.hex}}"
        property color m3surfaceContainerLowest: "{{colors.surface_container_lowest.default.hex}}"
        property color m3surfaceContainerHigh: "{{colors.surface_container_high.default.hex}}"
        property color m3surfaceContainerHighest: "{{colors.surface_container_highest.default.hex}}"

        // Primary colors
        property color m3primary: "{{colors.primary.default.hex}}"
        property color m3onPrimary: "{{colors.on_primary.default.hex}}"
        property color m3primaryContainer: "{{colors.primary_container.default.hex}}"
        property color m3onPrimaryContainer: "{{colors.on_primary_container.default.hex}}"
        property color m3primaryFixed: "{{colors.primary_fixed.default.hex}}"
        property color m3primaryFixedDim: "{{colors.primary_fixed_dim.default.hex}}"
        property color m3onPrimaryFixed: "{{colors.on_primary_fixed.default.hex}}"
        property color m3onPrimaryFixedVariant: "{{colors.on_primary_fixed_variant.default.hex}}"

        // Secondary colors
        property color m3secondary: "{{colors.secondary.default.hex}}"
        property color m3onSecondary: "{{colors.on_secondary.default.hex}}"
        property color m3secondaryContainer: "{{colors.secondary_container.default.hex}}"
        property color m3onSecondaryContainer: "{{colors.on_secondary_container.default.hex}}"
        property color m3secondaryFixed: "{{colors.secondary_fixed.default.hex}}"
        property color m3secondaryFixedDim: "{{colors.secondary_fixed_dim.default.hex}}"
        property color m3onSecondaryFixed: "{{colors.on_secondary_fixed.default.hex}}"
        property color m3onSecondaryFixedVariant: "{{colors.on_secondary_fixed_variant.default.hex}}"

        // Tertiary colors
        property color m3tertiary: "{{colors.tertiary.default.hex}}"
        property color m3onTertiary: "{{colors.on_tertiary.default.hex}}"
        property color m3tertiaryContainer: "{{colors.tertiary_container.default.hex}}"
        property color m3onTertiaryContainer: "{{colors.on_tertiary_container.default.hex}}"
        property color m3tertiaryFixed: "{{colors.tertiary_fixed.default.hex}}"
        property color m3tertiaryFixedDim: "{{colors.tertiary_fixed_dim.default.hex}}"
        property color m3onTertiaryFixed: "{{colors.on_tertiary_fixed.default.hex}}"
        property color m3onTertiaryFixedVariant: "{{colors.on_tertiary_fixed_variant.default.hex}}"

        // Error colors
        property color m3error: "{{colors.error.default.hex}}"
        property color m3onError: "{{colors.on_error.default.hex}}"
        property color m3errorContainer: "{{colors.error_container.default.hex}}"
        property color m3onErrorContainer: "{{colors.on_error_container.default.hex}}"

        // Outline colors
        property color m3outline: "{{colors.outline.default.hex}}"
        property color m3outlineVariant: "{{colors.outline_variant.default.hex}}"

        // Special colors
        property color m3shadow: "{{colors.shadow.default.hex}}"
        property color m3scrim: "{{colors.scrim.default.hex}}"
        property color m3inverseSurface: "{{colors.inverse_surface.default.hex}}"
        property color m3onInverseSurface: "{{colors.inverse_on_surface.default.hex}}"
        property color m3inversePrimary: "{{colors.inverse_primary.default.hex}}"
        property color m3surfaceTint: "{{colors.surface_tint.default.hex}}"

        // Legacy mappings for backward compatibility
        property color m3primaryText: m3onBackground
        property color m3layerBackground1: m3surface
        property color m3layerBackground2: m3surfaceContainerLow
        property color m3layerBackground3: m3surfaceContainer
        property color m3surfaceText: m3onSurface
        property color m3secondaryText: m3onSurfaceVariant
        property color m3borderPrimary: m3primary
        property color m3shadowColor: m3shadow
        property color m3accentPrimary: m3primary
        property color m3accentSecondary: m3secondary
        property color m3selectionBackground: m3surfaceVariant
        property color m3accentPrimaryText: m3onPrimary
        property color m3selectionText: m3onSurfaceVariant
        property color m3borderSecondary: m3outlineVariant
        property color colTooltip: m3inverseSurface
        property color colOnTooltip: m3onInverseSurface
    }

    colors: QtObject {
        property color colSubtext: m3colors.m3borderPrimary
        property color colLayer0: ColorUtils.transparentize(m3colors.m3background, root.transparency)
        property color colLayer1: ColorUtils.transparentize(ColorUtils.mix(m3colors.m3layerBackground1, m3colors.m3background, 0.7), root.contentTransparency)
        property color colOnLayer1: m3colors.m3secondaryText
        property color colLayer2: ColorUtils.transparentize(ColorUtils.mix(m3colors.m3layerBackground2, m3colors.m3layerBackground3, 0.55), root.contentTransparency)
        property color colOnLayer2: m3colors.m3surfaceText
        property color colLayer1Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer1, colOnLayer1, 0.92), root.contentTransparency)
        property color colLayer1Active: ColorUtils.transparentize(ColorUtils.mix(colLayer1, colOnLayer1, 0.85), root.contentTransparency)
        property color colLayer2Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer2, colOnLayer2, 0.90), root.contentTransparency)
        property color colLayer2Active: ColorUtils.transparentize(ColorUtils.mix(colLayer2, colOnLayer2, 0.80), root.contentTransparency)
        property color colPrimary: m3colors.m3accentPrimary
        property color colPrimaryHover: ColorUtils.mix(colors.colPrimary, colLayer1Hover, 0.87)
        property color colPrimaryActive: ColorUtils.mix(colors.colPrimary, colLayer1Active, 0.7)
        property color colShadow: ColorUtils.transparentize(m3colors.m3shadowColor, 0.7)
    }

    rounding: QtObject {
        property int unsharpen: 0
        property int verysmall: 1
        property int small: 3
        property int normal: 5
        property int large: 10
        property int verylarge: 25
        property int veryverylarge: 50
        property int full: 99
        property int screenRounding: normal
    }

    font: QtObject {
        property QtObject family: QtObject {
            property string uiFont: "Rubik"
            property string iconFont: "SymbolsNerdFont"
            property string codeFont: "JetBrains Mono NF"
            property string uiBigFont: "Gabarito"
        }
        property QtObject pixelSize: QtObject {
            property int textSmall: 13
            property int textBase: 15
            property int textMedium: 16
            property int textLarge: 19
            property int iconLarge: 22
        }
    }

    animationCurves: QtObject {
        readonly property list<real> expressiveFastSpatial: [0.42, 1.67, 0.21, 0.90, 1, 1] // Default, 350ms
        readonly property list<real> expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1.00, 1, 1] // Default, 500ms
        readonly property list<real> expressiveSlowSpatial: [0.39, 1.29, 0.35, 0.98, 1, 1] // Default, 650ms
        readonly property list<real> expressiveEffects: [0.34, 0.80, 0.34, 1.00, 1, 1] // Default, 200ms
        readonly property list<real> emphasized: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
        readonly property list<real> emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1]
        readonly property list<real> emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1]
        readonly property list<real> standard: [0.2, 0, 0, 1, 1, 1]
        readonly property list<real> standardAccel: [0.3, 0, 1, 1, 1, 1]
        readonly property list<real> standardDecel: [0, 0, 0, 1, 1, 1]
    }

    animation: QtObject {
        property QtObject elementMove: QtObject {
            property int duration: 500
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: animationCurves.expressiveDefaultSpatial
            property int velocity: 650
            property Component numberAnimation: Component {
                NumberAnimation {
                    duration: root.animation.elementMove.duration
                    easing.type: root.animation.elementMove.type
                    easing.bezierCurve: root.animation.elementMove.bezierCurve
                }
            }
            property Component colorAnimation: Component {
                ColorAnimation {
                    duration: root.animation.elementMove.duration
                    easing.type: root.animation.elementMove.type
                    easing.bezierCurve: root.animation.elementMove.bezierCurve
                }
            }
        }
        property QtObject elementMoveEnter: QtObject {
            property int duration: 400
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: animationCurves.emphasizedDecel
            property int velocity: 650
            property Component numberAnimation: Component {
                NumberAnimation {
                    duration: root.animation.elementMoveEnter.duration
                    easing.type: root.animation.elementMoveEnter.type
                    easing.bezierCurve: root.animation.elementMoveEnter.bezierCurve
                }
            }
        }
        property QtObject elementMoveExit: QtObject {
            property int duration: 200
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: animationCurves.emphasizedAccel
            property int velocity: 650
            property Component numberAnimation: Component {
                NumberAnimation {
                    duration: root.animation.elementMoveExit.duration
                    easing.type: root.animation.elementMoveExit.type
                    easing.bezierCurve: root.animation.elementMoveExit.bezierCurve
                }
            }
        }
        property QtObject elementMoveFast: QtObject {
            property int duration: 200
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: animationCurves.expressiveEffects
            property int velocity: 850
            property Component colorAnimation: Component {
                ColorAnimation {
                    duration: root.animation.elementMoveFast.duration
                    easing.type: root.animation.elementMoveFast.type
                    easing.bezierCurve: root.animation.elementMoveFast.bezierCurve
                }
            }
            property Component numberAnimation: Component {
                NumberAnimation {
                    duration: root.animation.elementMoveFast.duration
                    easing.type: root.animation.elementMoveFast.type
                    easing.bezierCurve: root.animation.elementMoveFast.bezierCurve
                }
            }
        }

        property QtObject clickBounce: QtObject {
            property int duration: 200
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: animationCurves.expressiveFastSpatial
            property int velocity: 850
            property Component numberAnimation: Component {
                NumberAnimation {
                    duration: root.animation.clickBounce.duration
                    easing.type: root.animation.clickBounce.type
                    easing.bezierCurve: root.animation.clickBounce.bezierCurve
                }
            }
        }
        property QtObject scroll: QtObject {
            property int duration: 400
            property int type: Easing.BezierSpline
            property list<real> bezierCurve: animationCurves.standardDecel
        }
        property QtObject menuDecel: QtObject {
            property int duration: 350
            property int type: Easing.OutExpo
        }
    }

    sizes: QtObject {
        property real barWidth: 44
        property real sidebarWidth: 460
        property real dashboardWidth: 460
        property real sidebarWidthExtended: 750
        property real osdWidth: 200
        property real mediaControlsWidth: 478
        property real mediaControlsHeight: 150
        property real notificationPopupWidth: 410
        property real searchWidthCollapsed: 260
        property real searchWidth: 450
        property real hyprlandGapsOut: 5
        property real elevationMargin: 10
        property real fabShadowRadius: 5
        property real fabHoveredShadowRadius: 7
    }
}
