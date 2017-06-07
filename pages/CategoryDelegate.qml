import QtQuick 2.2

Rectangle {
    id: delegate

    property bool selected: ListView.isCurrentItem
    property real itemSize
    width: itemSize
    height: itemSize/4

    Image {
        anchors.centerIn: parent
        //source: image
    }

    Text {
        id: titleText

        anchors {
            left: parent.left; leftMargin: 20
            right: parent.right; rightMargin: 20
            top: parent.top; topMargin: 10
        }

        font { pointSize: 18; bold: true }
        //font.family: fonts.dejavu.name
        text: name
        //color: selected ? "#ffffff" : "#ebebdd"
        scale: selected ? 1.15 : 1.0
        //scale: selected ? 0.9 : 0.5
        Behavior on color { ColorAnimation { duration: 150 } }
        Behavior on scale { PropertyAnimation { duration: 300 } }
    }

//    BusyIndicator {
//        scale: 0.8
//        visible: delegate.ListView.isCurrentItem && window.loading
//        anchors.centerIn: parent
//    }

    MouseArea {
        anchors.fill: delegate
        onClicked: {
            delegate.ListView.view.currentIndex = index
            if (window.currentFeed == feed)
                feedModel.reload()
            else
                window.currentFeed = feed
        }
    }
}
