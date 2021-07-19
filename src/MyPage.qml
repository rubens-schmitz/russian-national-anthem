import QtQuick 2.11
import QtQuick.Controls 2.4

Page {
    visible: false
    header: MyHeader { id: myHeader }

    default property alias children: myHeader.children
    property alias content: myView.listModel
    property alias view: myView
    property string name

    MySwipeView { id: myView }
}
