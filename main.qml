// *******************************************************************************************
/// <summary>
/// 
/// </summary>
/// <created>ʆϒʅ,18.09.2019</created>
/// <changed>ʆϒʅ,30.09.2019</changed>
// *******************************************************************************************


import QtQuick 2.13
//import QtQuick.Window 2.13 // QML window component
import QtQuick.Controls 2.13

// QML window component
//Window {
//visible: true
//title: qsTr("Hello World")

Item {
  id: main
//  width: 320
//  height: 480
  width: 480
  height: 640

  Item {
    width: parent.width
    height: parent.height
    anchors.fill: parent
    anchors.rightMargin: 5
    anchors.bottomMargin: 5
    anchors.leftMargin: 5
    anchors.topMargin: 5

    SwipeView {
      id: view
      currentIndex: 0
      anchors.fill: parent

      //    pages to be loaded item by item
      //    Item {
      //      id: pageOne
      //      Loader { source: "pageOne.qml" }
      //      //property Component one: PageOne {}
      //    }
      //    Item {
      //      id: pageTwo
      //      Loader { source: "pageTwo.qml" }
      //    }
      //    Item {
      //      id: pageThree
      //      Loader { source: "pageThree.qml" }
      //    }

      // automatic pages' instantiatation and destruction
      Repeater {
        model: 3 // number of pages

        Loader {
          // loaded ones (note that using loader source property, destruction functionality is different)
          //active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
          //active: SwipeView.isCurrentItem // just current is loaded

          source: "page" + index + ".qml"

          //          sourceComponent: Text {
          //            text: index
          //            Component.onCompleted: console.log("crated:", "page" + index + ".qml")
          //            Component.onDestruction: console.log("destructed:", "page" + index + ".qml")
          //          }
        }
      }
    }

    // swip view need: a good practice, which gives the user some clues about where was what. :)
    PageIndicator {
      id: indicator
      count: view.count
      currentIndex: view.currentIndex
      anchors.bottom: view.bottom
      anchors.horizontalCenter: parent.horizontalCenter
    }
  }
}
