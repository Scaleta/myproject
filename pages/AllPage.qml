import QtQuick 2.6
import QtQuick.Controls 2.1
import QtQuick.XmlListModel 2.0
import QtQuick.Window 2.1
//import QtQuick.Controls 1.1
import QtQuick.Extras 1.4


//ScrollablePage {
//    id: page

//    Column {
//        spacing: 40
//        width: parent.width

//        Text {
//            text: "RSS Feed"
//            anchors.centerIn: parent
//            font.pointSize: 12
//        }

        Rectangle {
            id: window
            width: parent.width


        property string currentFeed: rssFeeds.get(0).feed
        property bool loading: feedModel.status === XmlListModel.Loading


        onLoadingChanged: {
            if (feedModel.status == XmlListModel.Ready)
                list.positionViewAtBeginning()
        }


        RssFeeds { id: rssFeeds }

        property var feeds: [
//            { name: "Planet KDE", feed: "http://planetkde.org/rss20.xml", icon: "awesome/rss" },
            //{ name: "Planet Qt", feed: "http://planet.qt.io/rss20.xml", icon: "awesome/rss" },
            //{ name: "Livescience", feed: "http://www.livescience.com/home/feed/site.xml", icon: "awesome/rss"},
            //{ name: "NASA", feed: "http://www.nasa.gov/rss/dyn/solar_system.rss", icon: "awesome/rss"}
        ]

        property var selectedFeed: feeds[0]


        XmlListModel {
            id: feedModel
            source: selectedFeed.feed
            //source: "http://" + window.currentFeed
            //query: "/rss/channel/item[child::media:content]"
            query: "/rss/channel/item"


            XmlRole { name: "title"; query: "title/string()"}
            // Remove any links from the description
            XmlRole { name: "description"; query: "description/string()"}
            XmlRole { name: "image"}
            XmlRole { name: "link"; query: "link/string()" }
            XmlRole { name: "pubDate"; query: "pubDate/string()" }
        }


        ListView {
            id: categories
            //property int itemWidth: 190
            property int itemWidth: 300
//            width: isPortrait ? parent.width : itemWidth
//            height: isPortrait ? itemWidth : parent.height
//            orientation: isPortrait ? ListView.Horizontal : ListView.Vertical
//            anchors.top: parent.top
            model: rssFeeds
            delegate: CategoryDelegate { itemSize: categories.itemWidth }
            //spacing: 3
            spacing: 5
        }

        ListView {
            id: list

            model: feedModel
            footer: footerText
            delegate: NewsDelegate {}
        }


        Component {
            id: footerText

            Rectangle {
                width: parent.width
                height: 10
                color: "lightgray"

                Text {
                    text: "RSS Feed"
                    anchors.centerIn: parent
                    font.pointSize: 12
                }
            }
        }


//-----------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------
    }
//   }
//}
