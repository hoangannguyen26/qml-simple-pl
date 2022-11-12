import QtQuick 2.12

Rectangle {
    id: root
    property double value: 0.0
    property int notifyInterval: 1000 // 1 seconds
    property bool isPressed: mouseArea.containsPress
    property bool enabled: false
    signal release
    implicitWidth: 100
    implicitHeight: 20

    color: "transparent"
    border.width: 2
    border.color: "green"

    Rectangle {
        anchors.left: parent.left
        anchors.right: handler.horizontalCenter
        height: parent.height - 2 * parent.border.width
        anchors.verticalCenter: parent.verticalCenter
        color: "#383838"
    }

    MouseArea {
        enabled: root.enabled
        anchors.fill: parent
        onClicked: {
            root.value = mouse.x/ (root.width - handler.width)
            root.release()
        }
    }

    Rectangle {
        id: handler
        height: root.height
        width: height
        radius: 4
        color: "#2C7F9B"
        x: (root.width - width) * value

        Behavior on x {
            enabled: !mouseArea.containsPress
            NumberAnimation {
                duration: root.notifyInterval
            }
        }

        MouseArea {
            id: mouseArea
            enabled: root.enabled
            anchors.fill: parent
            drag.target: parent
            drag.axis: "XAxis"
            drag.minimumX: 0
            drag.maximumX: root.width - parent.width
            onReleased: {
                root.value = parent.x / (root.width - width)
                root.release()
            }
        }
    }
}
