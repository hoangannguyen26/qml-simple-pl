import QtQuick 2.12
import QtQuick.Window 2.12
import QtMultimedia 5.12
import QtQuick.Dialogs 1.2

import "Components"

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Simple player")

    Item {
        anchors.fill: parent

        CCVideoControl {
            id: videoControl
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.8
            height: width * 9 / 16
        }

        CCButton {
            width: 200
            height: 60
            anchors.horizontalCenter: videoControl.horizontalCenter
            anchors.top: videoControl.bottom
            anchors.topMargin: 30
            text: qsTr("Select a video")
            onClicked: {
                fileDialog.open()
            }
        }


        FileDialog {
            id: fileDialog
            nameFilters: ["Video files (*.mp4 *.avi)"]
            folder: shortcuts.movies
            onAccepted: {
                videoControl.player.stop()
                videoControl.player.source = fileUrl
                videoControl.player.play()
            }
        }
    }
}
