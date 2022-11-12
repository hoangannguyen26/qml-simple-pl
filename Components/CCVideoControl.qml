import QtQuick 2.12
import QtMultimedia 5.12

Rectangle {
    color: "#000000"
    implicitWidth: 480
    implicitHeight: implicitWidth * 9 / 16
    property alias player: player
    clip: true

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        drag.target: videoOutput
        drag.axis: Drag.XAndYAxis
        drag.minimumX: videoOutput.width - videoOutput.width * zoomScale.xScale
        drag.maximumX: 0

        drag.minimumY: videoOutput.height - videoOutput.height * zoomScale.yScale
        drag.maximumY: 0
    }

    MediaPlayer {
        id: player
        onPositionChanged: {
            sidler.value = player.position / player.duration
        }
        notifyInterval: 100
    }

    VideoOutput {
        //        anchors.fill: parent
        width: parent.width
        height: parent.height
        id: videoOutput
        source: player
        transform: [
            Scale {
                id: zoomScale
            }
        ]
    }

    CCButton {
        visible: mouseArea.containsMouse
        id: btnZoomIn
        width: 60
        height: 60

        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 20
        anchors.topMargin: 20

        Image {
            anchors.fill: parent
            source: "qrc:///Res/ic-zoom-in.png"
        }
        onClicked: {
            zoomScale.xScale = zoomScale.xScale + 0.1
            zoomScale.yScale = zoomScale.yScale + 0.1
        }
    }

    CCButton {
        visible: mouseArea.containsMouse
        width: 60
        height: 60
        anchors.right: btnZoomIn.left
        anchors.rightMargin: 20
        anchors.verticalCenter: btnZoomIn.verticalCenter
        enabled: zoomScale.xScale > 1

        Image {
            anchors.fill: parent
            source: "qrc:///Res/ic-zoom-out.png"
        }

        onClicked: {

            zoomScale.xScale = zoomScale.xScale - 0.1
            zoomScale.yScale = zoomScale.yScale - 0.1
            if(videoOutput.x < mouseArea.drag.minimumX) {
                videoOutput.x = mouseArea.drag.minimumX
            }
            if(videoOutput.y < mouseArea.drag.minimumY) {
                videoOutput.y = mouseArea.drag.minimumY
            }

            if(videoOutput.x > mouseArea.drag.maximumX) {
                videoOutput.x = mouseArea.drag.maximumX
            }
            if(videoOutput.y > mouseArea.drag.maximumY) {
                videoOutput.y = mouseArea.drag.maximumY
            }
        }
    }

    CCButton {
        color: "transparent"
        border.width: 0
        width: 80
        height: 80
        visible: mouseArea.containsMouse || player.playbackState !== MediaPlayer.PlayingState
        anchors.centerIn: parent

        onClicked: {
            if(player.playbackState === MediaPlayer.PlayingState) {
                player.pause()
            } else {
                player.play()
            }
        }

        Image {
            id: iconImage
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            sourceSize: Qt.size(width, height)
            mipmap: true
            source: player.playbackState === MediaPlayer.PlayingState ? "qrc:///Res/ic-pause.png" : "qrc:///Res/ic-play.png"
        }
    }

    CCSlider {
        id: sidler
        enabled: player.seekable
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20

        notifyInterval: player.notifyInterval
        onRelease: {
            let seekPos = value * player.duration
            player.seek(seekPos)
            //            player.play()
        }
        onIsPressedChanged: {
            if(isPressed && player.status !== MediaPlayer.EndOfMedia) {
                player.pause()
            }
        }
    }

}
