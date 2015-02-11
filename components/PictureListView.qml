import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0
import "../components/JSONListModel"

Item {
    anchors.fill: parent
    id: mainScreen

    ListModel {
        id: listModel
    }
//    JSONListModel{
//        id:jsonModel
//        source: "http://news-at.zhihu.com/api/4/news/latest"
//        query: "$.stories[*]"
//    }

    property string source: "http://news-at.zhihu.com/api/4/news/latest"
    Component.onCompleted: {
        var xhr = new XMLHttpRequest;
        xhr.open("GET", source);
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                var list = JSON.parse(xhr.responseText);
                listModel.clear();
                for (var i in list)
                    if (i == "stories") {
                        for (var j in list[i]) {
                        listModel.append({ "title": list[i][j]["title"], "images": list[i][j]["images"][0] });
                        }
                    }
            }
        }
        xhr.send();
    }
    Component {
        id: listDelegate
        BorderImage {
            source: "http://img2.duitang.com/uploads/item/201204/09/20120409202928_QMPVf.thumb.600_0.jpeg"
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
//                    source: url(model.images.get(0)); x: 0; y: 0
                    source: model.images

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

        model: listModel

        delegate: listDelegate
//delegate: sampleListModel
    }
    Scrollbar {
        flickableItem: listView
    }
}
