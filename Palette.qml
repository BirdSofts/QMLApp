// ===========================================================================
/// <summary>
/// Palette.qml
/// QMLApp
/// created by Mehrdad Soleimanimajd on 22.09.2019
/// </summary>
/// <created>ʆϒʅ, 22.09.2019</created>
/// <changed>ʆϒʅ, 27.06.2023</changed>
// ===========================================================================
import QtQuick 2.13

// palette container entity
Item {
    id: paletteEntity
    property alias paletteColor: rectangle.color
    signal clicked(color paletteColor)

    width: 20
    height: 20

    Rectangle {
        id: rectangle
        border.color: "white"
        anchors.fill: parent
    }

    // clickable area and its event
    MouseArea {
        anchors.fill: parent
        onClicked: paletteEntity.clicked(paletteEntity.paletteColor)
    }
}
