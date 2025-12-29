// Main.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 1920
    height: 1080
    title: "dash"

    // Background (blue)
    Rectangle { anchors.fill: parent; color: "#0D47A1" }

    // Optional custom fonts (add to .qrc; will fall back if not found)
    FontLoader { id: titleFont; source: "qrc:/fonts/Orbitron-Bold.ttf" }
    FontLoader { id: valueFont; source: "qrc:/fonts/Montserrat-SemiBold.ttf" }

    // Guard if 'parser' isn't exposed yet
    readonly property bool hasParser: typeof parser !== "undefined" && parser !== null

    ScrollView {
        anchors.fill: parent
        clip: true
        background: Rectangle { color: "transparent" }

        // ensure centering works even when content is smaller than viewport
        contentWidth:  Math.max(availableWidth,  grid.implicitWidth)
        contentHeight: Math.max(availableHeight, grid.implicitHeight)

        GridLayout {
            id: grid

            // Center the whole grid in the view
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            // Choose a max grid width (tweak to taste) and equalize columns
            width: Math.min(parent.width - 40, 1400)
            columns: 3
            columnSpacing: 20
            rowSpacing: 20

            // equal cell width
            property real cellW: (width - (columns - 1) * columnSpacing) / columns

            // fallback families
            property string titleFallback: (Qt.platform.os === "windows") ? "Segoe UI"
                                           : (Qt.platform.os === "osx") ? "Helvetica Neue"
                                           : "Noto Sans"
            property string valueFallback: titleFallback

            // --- Speed (km/h) ---
            Frame {
                Layout.preferredWidth: grid.cellW; Layout.maximumWidth: grid.cellW
                Layout.preferredHeight: 120; padding: 0
                background: Rectangle { color: "transparent"; border.width: 0 }
                ColumnLayout {
                    anchors.fill: parent; spacing: 6
                    Label {
                        text: "Speed"
                        font.family: (titleFont.status === FontLoader.Ready && titleFont.name !== "") ? titleFont.name : grid.titleFallback
                        font.bold: true; font.weight: Font.Black; font.pointSize: 16
                        color: "#FFEB3B"; Layout.margins: 6
                    }
                    Label {
                        text: hasParser ? (parser.speed + " km/h") : "—"
                        font.family: (valueFont.status === FontLoader.Ready && valueFont.name !== "") ? valueFont.name : grid.valueFallback
                        font.bold: true; font.weight: Font.DemiBold; font.pointSize: 28
                        color: "white"; Layout.margins: 6
                    }
                }
            }

            // --- Throttle ---
            Frame {
                Layout.preferredWidth: grid.cellW; Layout.maximumWidth: grid.cellW
                Layout.preferredHeight: 120; padding: 0
                background: Rectangle { color: "transparent"; border.width: 0 }
                ColumnLayout {
                    anchors.fill: parent; spacing: 6
                    Label { text: "Throttle"; font.family: (titleFont.status === FontLoader.Ready && titleFont.name !== "") ? titleFont.name : grid.titleFallback; font.bold: true; font.weight: Font.Black; font.pointSize: 16; color: "#FFEB3B"; Layout.margins: 6 }
                    Label { text: hasParser ? String(parser.thrtl) : "—"; font.family: (valueFont.status === FontLoader.Ready && valueFont.name !== "") ? valueFont.name : grid.valueFallback; font.bold: true; font.weight: Font.DemiBold; font.pointSize: 28; color: "white"; Layout.margins: 6 }
                }
            }

            // --- Brake ---
            Frame {
                Layout.preferredWidth: grid.cellW; Layout.maximumWidth: grid.cellW
                Layout.preferredHeight: 120; padding: 0
                background: Rectangle { color: "transparent"; border.width: 0 }
                ColumnLayout {
                    anchors.fill: parent; spacing: 6
                    Label { text: "Brake"; font.family: (titleFont.status === FontLoader.Ready && titleFont.name !== "") ? titleFont.name : grid.titleFallback; font.bold: true; font.weight: Font.Black; font.pointSize: 16; color: "#FFEB3B"; Layout.margins: 6 }
                    Label { text: hasParser ? String(parser.brake) : "—"; font.family: (valueFont.status === FontLoader.Ready && valueFont.name !== "") ? valueFont.name : grid.valueFallback; font.bold: true; font.weight: Font.DemiBold; font.pointSize: 28; color: "white"; Layout.margins: 6 }
                }
            }

            // --- Battery Temp (°C) ---
            Frame {
                Layout.preferredWidth: grid.cellW; Layout.maximumWidth: grid.cellW
                Layout.preferredHeight: 120; padding: 0
                background: Rectangle { color: "transparent"; border.width: 0 }
                ColumnLayout {
                    anchors.fill: parent; spacing: 6
                    Label { text: "Battery Temp"; font.family: (titleFont.status === FontLoader.Ready && titleFont.name !== "") ? titleFont.name : grid.titleFallback; font.bold: true; font.weight: Font.Black; font.pointSize: 16; color: "#FFEB3B"; Layout.margins: 6 }
                    Label { text: hasParser ? (parser.battTemp + " °C") : "—"; font.family: (valueFont.status === FontLoader.Ready && valueFont.name !== "") ? valueFont.name : grid.valueFallback; font.bold: true; font.weight: Font.DemiBold; font.pointSize: 28; color: "white"; Layout.margins: 6 }
                }
            }

            // --- Motor Temp (°C) ---
            Frame {
                Layout.preferredWidth: grid.cellW; Layout.maximumWidth: grid.cellW
                Layout.preferredHeight: 120; padding: 0
                background: Rectangle { color: "transparent"; border.width: 0 }
                ColumnLayout {
                    anchors.fill: parent; spacing: 6
                    Label { text: "Motor Temp"; font.family: (titleFont.status === FontLoader.Ready && titleFont.name !== "") ? titleFont.name : grid.titleFallback; font.bold: true; font.weight: Font.Black; font.pointSize: 16; color: "#FFEB3B"; Layout.margins: 6 }
                    Label { text: hasParser ? (parser.motorTemp + " °C") : "—"; font.family: (valueFont.status === FontLoader.Ready && valueFont.name !== "") ? valueFont.name : grid.valueFallback; font.bold: true; font.weight: Font.DemiBold; font.pointSize: 28; color: "white"; Layout.margins: 6 }
                }
            }

            // --- Voltage (V) ---
            Frame {
                Layout.preferredWidth: grid.cellW; Layout.maximumWidth: grid.cellW
                Layout.preferredHeight: 120; padding: 0
                background: Rectangle { color: "transparent"; border.width: 0 }
                ColumnLayout {
                    anchors.fill: parent; spacing: 6
                    Label { text: "Voltage"; font.family: (titleFont.status === FontLoader.Ready && titleFont.name !== "") ? titleFont.name : grid.titleFallback; font.bold: true; font.weight: Font.Black; font.pointSize: 16; color: "#FFEB3B"; Layout.margins: 6 }
                    Label { text: hasParser ? (parser.volt + " V") : "—"; font.family: (valueFont.status === FontLoader.Ready && valueFont.name !== "") ? valueFont.name : grid.valueFallback; font.bold: true; font.weight: Font.DemiBold; font.pointSize: 28; color: "white"; Layout.margins: 6 }
                }
            }

            // --- RPM ---
            Frame {
                Layout.preferredWidth: grid.cellW; Layout.maximumWidth: grid.cellW
                Layout.preferredHeight: 120; padding: 0
                background: Rectangle { color: "transparent"; border.width: 0 }
                ColumnLayout {
                    anchors.fill: parent; spacing: 6
                    Label { text: "RPM"; font.family: (titleFont.status === FontLoader.Ready && titleFont.name !== "") ? titleFont.name : grid.titleFallback; font.bold: true; font.weight: Font.Black; font.pointSize: 16; color: "#FFEB3B"; Layout.margins: 6 }
                    Label { text: hasParser ? String(parser.rpm) : "—"; font.family: (valueFont.status === FontLoader.Ready && valueFont.name !== "") ? valueFont.name : grid.valueFallback; font.bold: true; font.weight: Font.DemiBold; font.pointSize: 28; color: "white"; Layout.margins: 6 }
                }
            }

            // --- Battery (%) ---
            Frame {
                Layout.preferredWidth: grid.cellW; Layout.maximumWidth: grid.cellW
                Layout.preferredHeight: 120; padding: 0
                background: Rectangle { color: "transparent"; border.width: 0 }
                ColumnLayout {
                    anchors.fill: parent; spacing: 6
                    Label { text: "Battery (%)"; font.family: (titleFont.status === FontLoader.Ready && titleFont.name !== "") ? titleFont.name : grid.titleFallback; font.bold: true; font.weight: Font.Black; font.pointSize: 16; color: "#FFEB3B"; Layout.margins: 6 }
                    Label { text: hasParser ? String(parser.batt) + " %" : "—"; font.family: (valueFont.status === FontLoader.Ready && valueFont.name !== "") ? valueFont.name : grid.valueFallback; font.bold: true; font.weight: Font.DemiBold; font.pointSize: 28; color: "white"; Layout.margins: 6 }
                }
            }

            // --- Laps ---
            Frame {
                Layout.preferredWidth: grid.cellW; Layout.maximumWidth: grid.cellW
                Layout.preferredHeight: 120; padding: 0
                background: Rectangle { color: "transparent"; border.width: 0 }
                ColumnLayout {
                    anchors.fill: parent; spacing: 6
                    Label { text: "Laps"; font.family: (titleFont.status === FontLoader.Ready && titleFont.name !== "") ? titleFont.name : grid.titleFallback; font.bold: true; font.weight: Font.Black; font.pointSize: 16; color: "#FFEB3B"; Layout.margins: 6 }
                    Label { text: hasParser ? String(parser.laps) : "—"; font.family: (valueFont.status === FontLoader.Ready && valueFont.name !== "") ? valueFont.name : grid.valueFallback; font.bold: true; font.weight: Font.DemiBold; font.pointSize: 28; color: "white"; Layout.margins: 6 }
                }
            }

            // --- Battery Current (A) ---
            Frame {
                Layout.preferredWidth: grid.cellW; Layout.maximumWidth: grid.cellW
                Layout.preferredHeight: 120; padding: 0
                background: Rectangle { color: "transparent"; border.width: 0 }
                ColumnLayout {
                    anchors.fill: parent; spacing: 6
                    Label { text: "Battery Current"; font.family: (titleFont.status === FontLoader.Ready && titleFont.name !== "") ? titleFont.name : grid.titleFallback; font.bold: true; font.weight: Font.Black; font.pointSize: 16; color: "#FFEB3B"; Layout.margins: 6 }
                    Label { text: hasParser ? (parser.battCurr + " A") : "—"; font.family: (valueFont.status === FontLoader.Ready && valueFont.name !== "") ? valueFont.name : grid.valueFallback; font.bold: true; font.weight: Font.DemiBold; font.pointSize: 28; color: "white"; Layout.margins: 6 }
                }
            }

            // --- Distance ---
            Frame {
                Layout.preferredWidth: grid.cellW; Layout.maximumWidth: grid.cellW
                Layout.preferredHeight: 120; padding: 0
                background: Rectangle { color: "transparent"; border.width: 0 }
                ColumnLayout {
                    anchors.fill: parent; spacing: 6
                    Label { text: "Distance"; font.family: (titleFont.status === FontLoader.Ready && titleFont.name !== "") ? titleFont.name : grid.titleFallback; font.bold: true; font.weight: Font.Black; font.pointSize: 16; color: "#FFEB3B"; Layout.margins: 6 }
                    Label { text: hasParser ? String(parser.dist) : "—"; font.family: (valueFont.status === FontLoader.Ready && valueFont.name !== "") ? valueFont.name : grid.valueFallback; font.bold: true; font.weight: Font.DemiBold; font.pointSize: 28; color: "white"; Layout.margins: 6 }
                }
            }
        }
    }
}

