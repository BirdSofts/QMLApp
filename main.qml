// *******************************************************************************************
/// <summary>
/// 
/// </summary>
/// <created>ʆϒʅ,18.09.2019</created>
/// <changed>ʆϒʅ,23.09.2019</changed>
// *******************************************************************************************


import QtQuick 2.13
//import QtQuick.Window 2.13

//Window {
  //visible: true
  //title: qsTr("Hello World")

Item {
  id: page
  width: 320
  height: 480
  //Qt.resolvedUrl("launcher.qml")

  Text {
    id: entity
    anchors.left: parent.left
    anchors.leftMargin: 120
    text: "Entity"
    wrapMode: Text.WrapAtWordBoundrayOrAnywhere
    color: "blue"
    font.pixelSize: 12
  }

  Rectangle {
    width: 100
    height: 100

    gradient: Gradient {
      GradientStop { position: 0.0; color: "yellow" }
      GradientStop { position: 0.5; color: "blue" }
      GradientStop { position: 1.0; color: "green" }
    }

    Text {
      anchors.centerIn: parent
      text: "Hello, QML!"
      font.family: "Consolas"
      font.pointSize: 12
      opacity: 0.5
    }
  }

  // id attribute: to reference to other objects (identifier begins with lowercase or underscore and contains normal characters)
  Text { text: entity.text }

  Rectangle {
    id: test
    width: 320; height: 200
    color: "gray"
    anchors.bottom: page.bottom;
  
    Text {
      id: testText
      text: "Test"
      y: 10
      anchors.horizontalCenter: test.horizontalCenter
      font.pointSize: 20; font.bold: true
    }

    MouseArea { id: mouseArea; anchors.fill: parent }

    states: State {
      name: "turn"; when: mouseArea.pressed == true
      PropertyChanges {target: testText; y: 0; rotation: 360; color: "white"}
    }

    transitions: Transition {
      from: ""; to: "turn"; reversible: true

      ParallelAnimation {
        NumberAnimation {
          properties: "y, rotation";
          duration: 1000;
          easing.type: Easing.InOutElastic
        }
        ColorAnimation { duration: 1000 }
      }
    }

    Grid {
      id: palettePicker
      x: 5; anchors.bottom: test.bottom; anchors.bottomMargin: 5
      rows: 3; columns: 2; spacing: 5

      Palette { paletteColor: "red"; onClicked: testText.color = paletteColor }
      Palette { paletteColor: "green"; onClicked: testText.color = paletteColor }
      Palette { paletteColor: "blue"; onClicked: testText.color = paletteColor }
      Palette { paletteColor: "yellow"; onClicked: testText.color = paletteColor }
      Palette { paletteColor: "skyblue"; onClicked: testText.color = paletteColor }
      Palette { paletteColor: "black"; onClicked: testText.color = paletteColor }
    }
  }



}
