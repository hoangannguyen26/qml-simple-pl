import QtQuick 2.0
import QtQuick.Dialogs 1.2

Item {
    id: root
    height: 30
    width: 250
    property string fileUrl
    FileDialog {
        id: fileDialog
        nameFilters: ["Video files (*.mp4 *.avi)"]
        folder: shortcuts.movies
        onAccepted: {
//            player.stop()
//            player.source = fileUrl
//            player.play()
            root.fileUrl = fileUrl
        }
    }

    Rectangle {
        anchors.left: parent.left
        height: parent.height
        anchors.right: button.left
        color: "#FFFFFF"

        CCText {
            color: "#000000"
            text: root.fileUrl
            anchors.centerIn: parent
            font.pixelSize: 16
            width: parent.width - 20
            elide: Text.ElideMiddle
        }
    }

    CCButton {
        id: button
        anchors.right: parent.right
        height: parent.height
        width: 50
        text: qsTr("Brower")
        onClicked: {
            fileDialog.open()
        }
    }
}
