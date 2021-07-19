import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

SwipeView {
    currentIndex: 0
    anchors.fill: parent
    interactive: false

    property var listModel

    Repeater {
        model: listModel.length

        Rectangle {
            color: (theme.isDark(theme.primaryColor))
                   ? Qt.lighter(theme.primaryColor, 1.3)
                   : Qt.darker(theme.primaryColor, 1.3)

            GridLayout {
                anchors.fill: parent

                Rectangle {
                    Layout.alignment: Qt.AlignCenter
                    Layout.fillWidth: true
                    Layout.minimumWidth: flow.childrenRect.width
                    Layout.minimumHeight: flow.childrenRect.height
                    Layout.maximumWidth: root.width
                    Layout.maximumHeight: root.height
                    color: theme.backgroundColor

                    Flow {
                        id: flow
                        anchors.fill: parent

                        Repeater {
                            model: listModel[modelData].words

                            Button {
                                text: modelData
                                palette.buttonText:
                                    (theme.isDark(theme.backgroundColor))
                                    ? "white"
                                    : "black"
                                font.pixelSize: (root.width > root.height)
                                                ? root.height / 10
                                                : root.width / 10
                                padding: (root.width > root.height)
                                         ? root.height / 32
                                         : root.width / 32
                                background: Rectangle {
                                    color: "transparent"
                                }
                                focusPolicy: Qt.NoFocus

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: media.playWord(modelData)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
