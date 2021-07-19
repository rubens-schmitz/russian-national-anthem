// TODO: bug: view.onSwipe problem
//       bug: no difference between user and propramatic swipe
//       feat: swipe content to go forward or backward

// TODO: bug: at the end of Home Page WordByWord
//       bug: program keeps functioning normaly,
//       bug: but the following message is issued
//       Media.qml:65: TypeError: Cannot call method 'toLowerCase' of undefined

// TODO: feat: musical features
//             notes above the words
//             metronome
//             add other versions (guitar+voice for example)

// TODO: bug: accessibility support is not ideal
//       bug: not done using Qt/Linux standard accessibility features

// TODO: feat: load another music

import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Window 2.11
import QtMultimedia 5.9
import Theme 1.0

ApplicationWindow {
    id: root
    visible: true
    title: qsTr("Государственный гимн Российской Федерации")
    minimumWidth: 220
    minimumHeight: 176
    onVisibleChanged: session.handle()

    Accessibility { id: accessibility }
    Content { id: content }
    Media { id: media }
    MyDrawer { id: drawer }
    Session { id: session }
    Theme { id: theme }

    StackView {
        id: stack
        initialItem: homePage
        anchors.fill: parent
        replaceEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
        }
        replaceExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
            }
        }
    }

    MyPage {
        id: homePage
        name: qsTr("Домой")
        content: content.home

        MyButton { action: openDrawerAction }

        MyButton {
            action: startAction
            visible: !media.playing
            enabled: !media.playing
        }

        MyButton {
            action: pauseAction
            visible: media.playing
            enabled: media.playing
        }

        MyButton { action: refreshAction }

        MyButton { action: backwardAction }

        MyButton { action: forwardAction }
    }

    MyPage {
        id: helpPage
        name: qsTr("Помогите")
        content: content.help

        function changeVisibility() {
            return (homePage.visible) ? helpPage.open() : helpPage.close()
        }

        function open() {
            drawer.close()
            media.reset()
            stack.replace(helpPage)
            media.page = helpPage
            media.wordByWord = true
            helpPage.focus = true
            if (accessibility.enabled)
                media.playWord(helpPage.name)
        }

        function close () {
            media.reset()
            stack.replace(homePage)
            media.page = homePage
            media.wordByWord = false
            homePage.focus = true
            if (accessibility.enabled)
                media.playWord(homePage.name)
        }

        MyButton { action: closeHelpPageAction }

        MyButton {
            action: startAction
            visible: !media.playing
            enabled: !media.playing
        }

        MyButton {
            action: pauseAction
            visible: media.playing
            enabled: media.playing
        }

        MyButton { action: backwardAction }

        MyButton { action: forwardAction }
    }

    Action {
        id: openDrawerAction
        text: qsTr("Меню")
        icon.name: "navi-menu"
        onTriggered: { media.pause(); drawer.open() }
    }

    Action {
        id: closeDrawerAction
        text: qsTr("Возврат")
        icon.name: "navi-return"
        onTriggered: drawer.close()
    }

    Action {
        id: openHelpPageAction
        text: qsTr("Помогите")
        icon.name: "dialog-question"
        onTriggered: helpPage.open()
    }

    Action {
        id: closeHelpPageAction
        text: qsTr("Возврат")
        icon.name: "navi-return"
        onTriggered: helpPage.close()
    }

    Action {
        id: quitAction
        text: qsTr("Выход")
        icon.name: "application-exit"
        onTriggered: session.quit()
    }

    Action {
        id: enablewordByWordAction
        text: qsTr("Слово за словом")
        icon.name: "checkbox-unchecked"
        onTriggered: media.changeSpeed()
    }

    Action {
        id: disableWordByWordAction
        text: qsTr("Слово за словом")
        icon.name: "checkbox-checked"
        onTriggered: media.changeSpeed()
    }

    Action {
        id: startAction
        text: qsTr("Начать")
        icon.name: "media-playback-start"
        onTriggered: accessibility.bypass(media.play)
    }

    Action {
        id: pauseAction
        text: qsTr("Пауза")
        icon.name: "media-playback-pause"
        onTriggered: accessibility.bypass(media.pause)
    }

    Action {
        id: refreshAction
        text: qsTr("Освежить")
        icon.name: "view-refresh"
        onTriggered: media.reset()
    }

    Action {
        id: backwardAction
        text: qsTr("Назад")
        icon.name: "media-skip-backward"
        onTriggered: media.previous()
    }

    Action {
        id: forwardAction
        text: qsTr("Вперед")
        icon.name: "media-skip-forward"
        onTriggered: media.next()
    }

    Shortcut {
        sequence: "F1"
        onActivated: helpPage.changeVisibility()
    }

    Shortcut {
        sequence: "F2"
        onActivated: accessibility.change()
    }

    Shortcut {
        sequence: StandardKey.Cancel
        onActivated: helpPage.close()
    }

    Shortcut {
        sequence: StandardKey.Refresh
        onActivated: media.reset()
    }

    Shortcut {
        sequence: "Left"
        onActivated: media.previous()
    }

    Shortcut {
        sequence: "Right"
        onActivated: media.next()
    }
}
