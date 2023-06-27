﻿// ===========================================================================
/// <summary>
/// page1.qml
/// QMLApp
/// created by Mehrdad Soleimanimajd on 24.09.2019
/// </summary>
/// <created>ʆϒʅ, 24.09.2019</created>
/// <changed>ʆϒʅ, 27.06.2023</changed>
// ===========================================================================
import QtQuick 2.13
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.6
import QtQml.Models 2.3
import QtQuick.Dialogs

// second swipe view (base container)
Item {
    width: parent.width
    height: parent.height

    property int pFontSize: 12
    property string pFontName: "Arial"
    property string pFilePath: "file:///C:/Users/Mehrdad/Desktop/desktop.ini"
    property string pColour: "Blue"

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

            onActiveFocusChanged: configuration.set(pFontSize, pFontName,
                                                    pFilePath, pColour)

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
                            id: fontSizeLabel
                            text: qsTr("Font size: " + sliderFont.value)
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
                            value: configuration.getFontSize()
                            onMoved: {
                                fontSizeLabel.text = qsTr("Font size: " + value)
                                pFontSize = value
                                configuration.set(pFontSize, pFontName,
                                                  pFilePath, pColour)
                            }
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
                        background: Rectangle {}
                        Layout.fillWidth: true
                        text: qsTr("Font: " + configuration.getFontName())
                        font.pixelSize: 14
                        contentItem: Text {
                            // adjustments to button text
                            text: parent.text
                            font: parent.font
                            //            opacity: enabled ? 1.0 : 0.3
                            opacity: parent.opacity
                            //            color: parent.down ? "#17a81a" : "#21be2b"
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
                            //              topPadding: 40
                            bottomPadding: 40
                            dim: true
                            parent: Overlay.overlay

                            BusyIndicator {
                                id: indicator
                                anchors.right: parent.right
                                anchors.rightMargin: 2
                                anchors.top: parent.top
                                anchors.topMargin: 2
                                scale: 2
                                running: false
                            }

                            // font name popup list view
                            ListView {
                                id: fontList
                                model: Qt.fontFamilies()
                                y: 60
                                width: parent.width
                                height: parent.height
                                delegate: ItemDelegate {
                                    text: modelData
                                    font.pixelSize: 14
                                    highlighted: ListView.isCurrentItem
                                    onClicked: {
                                        fontType.text = qsTr(
                                                    "Font: " + modelData)
                                        pFontName = modelData
                                        //                  highlighted = ListView.isCurrentItem
                                        //                    console.log("clicked:", modelData)
                                        fontPopup.close()
                                    }
                                }
                                // popup scroll functionallity
                                ScrollIndicator.vertical: ScrollIndicator {}
                            }
                            onOpened: indicator.running = true
                            onClosed: indicator.running = false
                        }
                    }
                }

                // setting 3: file path setting base container (layout control)
                RowLayout {
                    anchors.horizontalCenter: parent.horizontalAlignment
                    width: pageTwo.width - 20
                    // file path button
                    Button {
                        id: path
                        background: Rectangle {}
                        Layout.fillWidth: true
                        text: qsTr("Path: " + configuration.getFilePath())
                        font.pixelSize: 14
                        contentItem: Text {
                            // adjustments to button text
                            text: parent.text
                            font: parent.font
                            //            opacity: enabled ? 1.0 : 0.3
                            opacity: parent.opacity
                            //            color: parent.down ? "#17a81a" : "#21be2b"
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight // omit characters from right (dynamic resizing)
                        }
                        padding: 10
                        onClicked: pathDialog.open()

                        // file path dialog (base container)
                        FileDialog {
                            id: pathDialog
                            title: "Please choose a file"
                            //              folder: shortcuts.desktop
                            onAccepted: {
                                path.text = qsTr(
                                            "Path: " + pathDialog.selectedFile)
                                pFilePath = pathDialog.selectedFile
                                //                Qt.quit() // exit the application
                            }
                        }
                    }
                }

                // setting 4: colour setting
                // colour label container (layout control)
                RowLayout {
                    anchors.horizontalCenter: parent.horizontalAlignment
                    width: pageTwo.width - 20
                    // font size label
                    Label {
                        id: colourLable
                        text: qsTr("Current Colour: " + configuration.getColour(
                                       ))
                        font.pixelSize: 14
                        padding: 10
                        Layout.fillWidth: true
                    }
                }
                // colour base container (layout control)
                RowLayout {
                    anchors.horizontalCenter: parent.horizontalAlignment
                    width: pageTwo.width - 20
                    // colour path view base container
                    Rectangle {
                        id: pathBase
                        Layout.fillWidth: true
                        Layout.preferredWidth: 300
                        Layout.minimumHeight: 200
                        Layout.maximumHeight: 300
                        Component {
                            id: component
                            Column {
                                id: wrapper
                                opacity: PathView.isCurrentItem ? 1 : 0.4
                                Rectangle {
                                    id: colourIcon
                                    anchors.horizontalCenter: nameText.horizontalCenter
                                    width: 32
                                    height: 32
                                    color: colour
                                }
                                Text {
                                    id: nameText
                                    text: name
                                    font.pixelSize: 14
                                }
                            }
                        }
                        PathView {
                            id: pathView
                            model: ColourModel {}
                            anchors.fill: parent
                            delegate: component
                            snapMode: PathView.SnapPosition
                            // dynamic path based on the screen size
                            path: Path {
                                startX: pathBase.width / 2
                                startY: 150
                                PathQuad {
                                    x: 200
                                    y: 50
                                    controlX: pathBase.width + (pathBase.width / 2)
                                    controlY: 50
                                }
                                PathQuad {
                                    x: pathBase.width / 2
                                    y: 150
                                    controlX: -150
                                    controlY: 50
                                }
                            }
                            onCurrentIndexChanged: {
                                colourLable.text = qsTr(
                                            "Current Colour: " + currentItem.children[1].text)
                                pColour = currentItem.children[1].text
                            }
                        }
                    }
                }

                // setting 5:
                RowLayout {
                    anchors.margins: 10
                    anchors.horizontalCenter: parent.horizontalAlignment
                    Text {
                        text: "Item 1"
                        font.pixelSize: 14
                    }
                }

                // setting 6:
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
                anchors {
                    fill: parent
                    bottomMargin: 30
                }
                highlightRangeMode: ListView.StrictlyEnforceRange
                snapMode: ListView.SnapOneItem
                //        flickDeceleration: 2000
                //        cacheBuffer: 200
            }
        }
    }
}
