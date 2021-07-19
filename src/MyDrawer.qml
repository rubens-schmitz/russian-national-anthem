import QtQuick 2.11
import QtQuick.Controls 2.4

Drawer {
    id: drawer
    width: drawerColumn.width
    height: parent.height
    background: Rectangle { color: theme.primaryColor }

    Flickable {
        anchors.fill: parent
        contentHeight: drawerColumn.height

        Column {
            id: drawerColumn
            spacing: 4

            MyButton { action: closeDrawerAction }

            MyButton {
                action: enablewordByWordAction
                visible: !media.wordByWord
            }

            MyButton {
                action: disableWordByWordAction
                visible: media.wordByWord
            }

            MyButton { action: openHelpPageAction }

            MyButton {
                action: quitAction
                icon.color: "transparent"
            }
        }
    }
}
