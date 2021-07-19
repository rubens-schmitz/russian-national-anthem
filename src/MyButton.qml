import QtQuick 2.11
import QtQuick.Controls 2.4

Button {
    icon.width: theme.iconSize
    icon.height: theme.iconSize
    icon.color: theme.foregroundColor
    palette.buttonText: theme.foregroundColor
    font.bold: true
    background: Rectangle {
        id: rect
        color: "transparent"
        border.color: theme.foregroundColor
        border.width: 0
    }
    onFocusChanged: handleFocus()

    function handleFocus () {
        if (!focus)
            return rect.border.width = 0
        rect.border.width = 2
        if (accessibility.enabled)
            media.playWord(action.text)
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: parent.action.onTriggered()
    }
}
