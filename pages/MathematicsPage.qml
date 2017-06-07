import QtQuick 2.6
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1

ScrollablePage {
    id: page

    Column {
        spacing: 40
        width: parent.width

        Label {
            width: parent.width
            wrapMode: Label.Wrap
            horizontalAlignment: Qt.AlignHCenter
            text: "Button presents a push-button that can be pushed or clicked by the user. "
                + "Buttons are normally used to perform an action, or to answer a question."
        }

        ColumnLayout {
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                text: "First"
                Layout.fillWidth: true
            }
            Button {
                id: button
                text: "Second"
                highlighted: true
                Layout.fillWidth: true
            }
            Button {
                text: "Third"
                enabled: false
                Layout.fillWidth: true
            }
        }
    }
}
