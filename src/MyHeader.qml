import QtQuick 2.11
import QtQuick.Controls 2.4

Rectangle {
    width: root.width
    height: headerRow.height
    color: theme.primaryColor

    default property alias children: headerRow.children;

    Flickable {
        anchors.fill: parent
        contentWidth: headerRow.width

        Row { id: headerRow }
    }
}
