// *******************************************************************************************
/// <summary>
/// 
/// </summary>
/// <created>ʆϒʅ,22.09.2019</created>
/// <changed>ʆϒʅ,23.09.2019</changed>
// *******************************************************************************************


import QtQuick 2.13

Item {
  id: container
  property alias paletteColor: rectangle.color
  signal clicked ( color paletteColor )

  width: 20; height: 20

  Rectangle {
    id: rectangle
    border.color: "white"
    anchors.fill: parent
  }

  MouseArea {
    anchors.fill: parent
    onClicked: container.clicked ( container.paletteColor )
  }
}
