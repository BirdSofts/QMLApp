// ===========================================================================
/// <summary>
/// page0.qml
/// QMLApp
/// created by Mehrdad Soleimanimajd on 24.09.2019
/// </summary>
/// <created>ʆϒʅ, 24.09.2019</created>
/// <changed>ʆϒʅ, 27.06.2023</changed>
// ===========================================================================
import QtQuick 2.13
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

// first swipe view (base container)
Item {
    id: pageOne
    width: parent.width
    height: parent.height

    // page base container
    Item {
        width: parent.width
        height: parent.height
        anchors.fill: parent
        anchors.rightMargin: 5
        anchors.bottomMargin: 5
        anchors.leftMargin: 5
        anchors.topMargin: 5

        Label {
            id: entity
            anchors.left: parent.left
            anchors.leftMargin: 120
            text: "Entity"
            //    wrapMode: Text.WrapAtWordBoundrayOrAnywhere
            color: "blue"
            font.pixelSize: 15
        }

        Rectangle {
            width: 100
            height: 100

            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "yellow"
                }
                GradientStop {
                    position: 0.5
                    color: "blue"
                }
                GradientStop {
                    position: 1.0
                    color: "green"
                }
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
        Text {
            text: entity.text
        }

        Rectangle {
            id: test
            width: parent.width
            height: 200
            color: "gray"
            anchors.bottom: parent.bottom

            Text {
                id: testText
                text: "Test"
                y: 10
                anchors.horizontalCenter: test.horizontalCenter
                font.pointSize: 20
                font.bold: true
            }

            // clickable area
            MouseArea {
                id: mouseArea
                anchors.fill: parent
            }

            // state change (event holder) and its needed definations
            states: State {
                name: "turn"
                when: mouseArea.pressed === true
                PropertyChanges {
                    target: testText
                    y: 0
                    rotation: 360
                    color: "white"
                }
            }

            // the actual effect and its corresponding properties
            transitions: Transition {
                from: ""
                to: "turn"
                reversible: true

                ParallelAnimation {
                    NumberAnimation {
                        properties: "y, rotation"
                        duration: 1000
                        easing.type: Easing.InOutElastic
                    }

                    ColorAnimation {
                        duration: 1000
                    }
                }
            }

            // color palettes grid container
            Grid {
                id: paletteContainer
                x: 5
                anchors.bottom: test.bottom
                anchors.bottomMargin: 5
                rows: 3
                columns: 2
                spacing: 5

                Palette {
                    paletteColor: "red"
                    onClicked: testText.color = paletteColor
                }
                Palette {
                    paletteColor: "green"
                    onClicked: testText.color = paletteColor
                }
                Palette {
                    paletteColor: "blue"
                    onClicked: testText.color = paletteColor
                }
                Palette {
                    paletteColor: "yellow"
                    onClicked: testText.color = paletteColor
                }
                Palette {
                    paletteColor: "skyblue"
                    onClicked: testText.color = paletteColor
                }
                Palette {
                    paletteColor: "black"
                    onClicked: testText.color = paletteColor
                }
            }
        }
    }
}
