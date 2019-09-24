// *******************************************************************************************
/// <summary>
/// 
/// </summary>
/// <created>ʆϒʅ,24.09.2019</created>
/// <changed>ʆϒʅ,25.09.2019</changed>
// *******************************************************************************************


import QtQuick 2.13
import QtQuick.Controls 2.13

Item {
  id: pageTwo
  width: parent.width
  height: parent.height

  // scroll-able list view
  ScrollView {
    anchors.fill: parent

    ListView {
      id: listView
      width: parent.width
      model: 30
      delegate: ItemDelegate {
        text: "Number " + (index + 1)
        width: parent.width
      }
    }
  }


}
