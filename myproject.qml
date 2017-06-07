import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Universal 2.1
import Qt.labs.settings 1.0

ApplicationWindow {
    id: window
    width: 360
    height: 520
    visible: true
    title: "My Project"

    Settings {
        id: settings
        property string style: "Default"
    }

    Shortcut {
        sequence: "Esc"
        enabled: stackView.depth > 1
        onActivated: {
            stackView.pop()
            listView.currentIndex = -1
        }
    }

    header: ToolBar {
        Material.foreground: "white"

        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: stackView.depth > 1 ? "images/back.png" : "images/drawer.png"
                }
                onClicked: {
                    if (stackView.depth > 1) {
                        stackView.pop()
                        listView.currentIndex = -1
                    } else {
                        drawer.open()
                    }
                }
            }

            Label {
                id: titleLabel
                text: listView.currentItem ? listView.currentItem.text : "RSS agregator"
                font.pixelSize: 20
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            ToolButton {
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/menu.png"
                }
                onClicked: optionsMenu.open()

                Menu {
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    MenuItem {
                        text: "Settings"
                        onTriggered: settingsDialog.open()
                    }
                    MenuItem {
                        text: "About"
                        onTriggered: aboutDialog.open()
                    }
                }
            }
        }
    }

    Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height
        interactive: stackView.depth === 1

        ListView {
            id: listView

            focus: true
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate {
                width: parent.width
                text: model.title
                highlighted: ListView.isCurrentItem
                onClicked: {
                    listView.currentIndex = index
                    stackView.push(model.source)
                    drawer.close()
                }
            }

            model: ListModel {
                ListElement { title: "All"; source: "qrc:/pages/AllPage.qml" }
                ListElement { title: "Mathematics"; source: "qrc:/pages/MathematicsPage.qml" }
                ListElement { title: "Physics"; source: "qrc:/pages/PhysicsPage.qml" }
                ListElement { title: "Chemistry"; source: "qrc:/pages/ChemistryPage.qml" }
                ListElement { title: "Biology"; source: "qrc:/pages/BiologyPage.qml" }
                ListElement { title: "Astronomy"; source: "qrc:/pages/AstronomyPage.qml" }
                //ListElement { title: "Geography"; source: "qrc:/pages/GeographyPage.qml" }
                //ListElement { title: "Geology"; source: "qrc:/pages/GeologyPage.qml" }
                //ListElement { title: "IT"; source: "qrc:/pages/ITPage.qml" }

            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: Pane {
            id: pane

            Image {
                id: logo
                width: pane.availableWidth / 2
                height: pane.availableHeight / 2
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -50
                fillMode: Image.PreserveAspectFit
                source: "images/qt-logo.png"
            }

            Label {
                text: "Description about My Project"
                anchors.margins: 20
                anchors.top: logo.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: arrow.top
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                wrapMode: Label.Wrap
            }

            Image {
                id: arrow
                source: "images/arrow.png"
                anchors.left: parent.left
                anchors.bottom: parent.bottom
            }
        }
    }

    Dialog {
        id: settingsDialog
        x: Math.round((window.width - width) / 2)
        y: Math.round(window.height / 6)
        width: Math.round(Math.min(window.width, window.height) / 3 * 2)
        modal: true
        focus: true
        title: "Settings"

        standardButtons: Dialog.Ok | Dialog.Cancel
        onAccepted: {
            settings.style = styleBox.displayText
            settingsDialog.close()
        }
        onRejected: {
            styleBox.currentIndex = styleBox.styleIndex
            settingsDialog.close()
        }

        contentItem: ColumnLayout {
            id: settingsColumn
            spacing: 20

            RowLayout {
                spacing: 10

                Label {
                    text: "Style:"
                }

                ComboBox {
                    id: styleBox
                    property int styleIndex: -1
                    model: availableStyles
                    Component.onCompleted: {
                        styleIndex = find(settings.style, Qt.MatchFixedString)
                        if (styleIndex !== -1)
                            currentIndex = styleIndex
                    }
                    Layout.fillWidth: true
                }
            }

            Label {
                text: "Restart required"
                color: "#e41e25"
                opacity: styleBox.currentIndex !== styleBox.styleIndex ? 1.0 : 0.0
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }

    Dialog {
        id: aboutDialog
        modal: true
        focus: true
        title: "About"
        x: (window.width - width) / 2
        y: window.height / 6
        width: Math.min(window.width, window.height) / 3 * 2
        contentHeight: aboutColumn.height

        Column {
            id: aboutColumn
            spacing: 20

            Label {
                width: aboutDialog.availableWidth
                text: "About about about."
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }

            Label {
                width: aboutDialog.availableWidth
                text: "Bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla"
                    + "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla "
                    + "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla."
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
        }
    }
}
