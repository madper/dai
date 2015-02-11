import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0
import "../components/JSONListModel"

Item {
    anchors.fill: parent
    id: mainScreen

    ListModel {
        id: sampleListModel

        ListElement {
            imagePath: "http://pic3.zhimg.com/f638c124aba6d6b1403060168396ac12.jpg"
            title: "First picture"
        }
        ListElement {
            imagePath: "http://pic3.zhimg.com/f638c124aba6d6b1403060168396ac12.jpg"
            title: "First picture"
        }
        ListElement {
            imagePath: "http://pic3.zhimg.com/f638c124aba6d6b1403060168396ac12.jpg"
            title: "First picture"
        }
    }
    JSONListModel{
        id:jsonModel
        source: "http://news-at.zhihu.com/api/4/news/latest"
        query: "$.stroies[*]"
    }


    Component {
        id: listDelegate
        BorderImage {
            source: "http://pic2.zhimg.com/d4691da85d8f7c4a845bcac5ec49f479.jpg"
            border { top:4; left:4; right:100; bottom: 4 }
            anchors.right: parent.right
            // width: mainScreen.width
            width: ListView.view.width

            property int fontSize: 25

            Rectangle {
                id: imageId
                x: 6; y: 4; width: parent.height - 10; height:width; color: "white"; smooth: true
                anchors.verticalCenter: parent.verticalCenter

                BorderImage {
                    source: model.images[0]; x: 0; y: 0
                    height:parent.height
                    width:parent.width
                    anchors.verticalCenter: parent.verticalCenter
                }

            }

            Text {
                x: imageId.width + 20
                y: 15
                width: ListView.view.width*2/3
                text: model.title; color: "white"
                font { pixelSize: fontSize; bold: true }
                elide: Text.ElideRight; style: Text.Raised; styleColor: "black"
            }
        }
    }

    UbuntuListView {
        id: listView
        width: mainScreen.width
        height: mainScreen.height

        model: jsonModel.model

        delegate: listDelegate
//delegate: sampleListModel
    }
    Scrollbar {
        flickableItem: listView
    }
}
