import QtQuick 2.12

Rectangle {
    id: root
    signal clicked
    color: mouseArea.containsPress ? "#882C7F9B" : "#2C7F9B"
    border.width: 2
    radius: 4
    implicitWidth: 150
    implicitHeight: 50
    property alias text: label.text

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            root.clicked()
        }
    }

    CCText {
        id: label
        text: qsTr("")
        anchors.centerIn: parent
        font.pointSize: 20
    }
}
