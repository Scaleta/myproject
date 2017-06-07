import QtQuick 2.2

Column {
    id: delegate
    width: delegate.ListView.view.width
    spacing: 8

    // Returns a string representing how long ago an event occurred
    function timeSinceEvent(pubDate) {
        var result = pubDate;

        // We need to modify the pubDate read from the RSS feed
        // so the JavaScript Date object can interpret it
        var d = pubDate.replace(',','').split(' ');
        if (d.length != 6)
            return result;

        var date = new Date([d[0], d[2], d[1], d[3], d[4], 'GMT' + d[5]].join(' '));

        if (!isNaN(date.getDate())) {
            var age = new Date() - date;
            var minutes = Math.floor(Number(age) / 60000);
            if (minutes < 1440) {
                if (minutes < 2)
                    result = qsTr("Just now");
                else if (minutes < 60)
                    result = '' + minutes + ' ' + qsTr("minutes ago")
                else if (minutes < 120)
                    result = qsTr("1 hour ago");
                else
                    result = '' + Math.floor(minutes/60) + ' ' + qsTr("hours ago");
            }
            else {
                result = date.toDateString();
            }
        }
        return result;
    }

    Item { height: 4; width: delegate.width }

    Row {
        width: parent.width
        //spacing: 10
        spacing: 4

        Column {
            Item {
                width: 4
                height: titleText.font.pointSize / 4
            }

            Image {
                id: titleImage
                source: image
            }
        }

        Text {
            id: titleText

            text: title
            width: delegate.width - titleImage.width
            wrapMode: Text.WordWrap
            font.pointSize: 16
            font.bold: true
            font.family: fonts.dejavu.name
        }
    }

    Text {
        width: delegate.width
        font.pointSize: 12
        textFormat: Text.RichText
        font.italic: true
        font.family: fonts.dejavu.name
        text: timeSinceEvent(pubDate) + " (<a href=\"" + link + "\">Link</a>)"
        onLinkActivated: {
            Qt.openUrlExternally(link)
        }
    }

    Text {
        id: descriptionText

        text: description
        width: parent.width
        wrapMode: Text.WordWrap
        font.pointSize: 14
        font.family: fonts.dejavu.name
        textFormat: Text.StyledText
        horizontalAlignment: Qt.AlignLeft
    }
}
