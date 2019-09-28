// *******************************************************************************************
/// <summary>
/// 
/// </summary>
/// <created>ʆϒʅ,24.09.2019</created>
/// <changed>ʆϒʅ,28.09.2019</changed>
// *******************************************************************************************


import QtQuick 2.13
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQml.Models 2.3

// second swipe view (base container)
Item {
  width: parent.width
  height: parent.height

  // page base container
  Item {
    id: pageTwo
    width: parent.width
    height: parent.height
    anchors.fill: parent
    anchors.margins: 5

    // page's scroll view control
    ScrollView {
      id: scrollView
      anchors.fill: parent
      padding: 10

      // page's list view feed (page objects container)
      ObjectModel {
        id: items

        // setting 1: font size setting base container (pane control)
        Pane {
          anchors.horizontalCenter: parent.horizontalAlignment
          width: pageTwo.width - 20
          padding: 0

          // layout (container of font size controls)
          RowLayout {
            anchors.fill: parent
            // font size label
            Label {
              id: fontSize
              text: qsTr("Font size: 12")
              font.pixelSize: 14
              padding: 10
              Layout.fillWidth: true
              Layout.minimumWidth: 90
            }
            // font size slider
            Slider {
              id: sliderFont
              from: 10
              snapMode: Slider.SnapAlways
              stepSize: 1
              to: 30
              value: 12
              onMoved: { fontSize.text = qsTr("Font size: " + value) }
              anchors.left: fontSize.right
              anchors.horizontalCenter: parent.horizontalAlignment
              Layout.fillWidth: true
              Layout.minimumWidth: 150
            }
          }
        }

        // setting 2: font name setting base container (layout control)
        RowLayout {
          anchors.horizontalCenter: parent.horizontalAlignment
          width: pageTwo.width - 20
          // font name button
          Button {
            id: fontType
            background: parent.background
            anchors.fill: parent
            text: qsTr("Font: ")
            font.pixelSize: 14
            contentItem: Text { // adjustments to button text
              text: parent.text
              font: parent.font
              //            opacity: enabled ? 1.0 : 0.3
              opacity: parent.opacity
              //            color: parent.down ? "#17a81a" : "#21be2b"
              color: parent.color
              horizontalAlignment: Text.AlignLeft
              verticalAlignment: Text.AlignVCenter
              elide: Text.ElideRight // omit characters from right (dynamic resizing)
            }
            padding: 10
            onClicked: fontPopup.open()

            // font name popup (base container)
            Popup {
              id: fontPopup
              width: parent.width - 60
              height: parent.height - 60
              margins: 30
              topPadding: 40
              bottomPadding: 40
              dim: true
              parent: Overlay.overlay
              // font name popup list view
              ListView {
                id: fontList
                model: Qt.fontFamilies()
                width: parent.width
                height: parent.height
                delegate: ItemDelegate {
                  text: modelData
                  font.pixelSize: 14
                  width: parent.width
                  highlighted: ListView.isCurrentItem
                  onClicked: {
                    fontType.text = qsTr("Font: " + modelData)
                    //                  highlighted = ListView.isCurrentItem
                    //                    console.log("clicked:", modelData)
                    fontPopup.close()
                  }
                }
                // popup scroll functionallity
                ScrollIndicator.vertical: ScrollIndicator {}
              }
            }
          }
        }

        // setting 3:
        RowLayout {
          anchors.margins: 10
          anchors.horizontalCenter: parent.horizontalAlignment
          Text {
            text: "Item 1"
            font.pixelSize: 14
          }
        }

        // setting 4:
        RowLayout {
          anchors.margins: 10
          anchors.horizontalCenter: parent.horizontalAlignment
          Text {
            text: "Item 2"
            font.pixelSize: 14
          }
        }

      }

      // page's list view control
      ListView {
        id: view
        model: items
        width: parent.width
        height: parent.height
        anchors { fill: parent; bottomMargin: 30 }
        highlightRangeMode: ListView.StrictlyEnforceRange
        snapMode: ListView.SnapOneItem
        //        flickDeceleration: 2000
        //        cacheBuffer: 200
      }
    }
  }
}
