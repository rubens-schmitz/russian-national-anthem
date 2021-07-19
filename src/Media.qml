import QtQuick 2.11
import QtMultimedia 5.9

Item {
    property var soundsPath: "file:////usr/share/russiannationalanthem/sounds/"
    property var playing: false
    property var wordByWord: false
    property var wordByWordIndex: 0
    property var page: homePage

    function getCurrentSection () {
        for (var i = page.content.length - 1; i >= 0; --i)
            if (player.position >= page.content[i].position)
                return i
    }

    function changeSpeed () {
        drawer.close()
        pause()
        wordByWord = !wordByWord
        wordByWordIndex = 0
    }

    function play () {
        if (!wordByWord) {
            timer.running = true
            player.seek(page.content[page.view.currentIndex].position)
        }
        playing = true
        player.play()
    }

    function pause () {
        playing = false
        timer.running = false
        player.pause()
    }

    function reset () {
        pause()
        player.seek(0)
        page.view.currentIndex = 0
        wordByWordIndex = 0
    }

    function previous () {
        if (page.view.CurrentIndex === 0)
            return
        wordByWordIndex = 0;
        page.view.decrementCurrentIndex()
        if (!wordByWord)
            player.seek(page.content[page.view.currentIndex].position)
    }

    function next () {
        if (isAnthemLastSection())
            return
        wordByWordIndex = 0
        page.view.incrementCurrentIndex()
        if (!wordByWord)
            player.seek(page.content[page.view.currentIndex].position)
    }

    function parseWord (string) {
        return string.toLowerCase().replace(/[,!;.— ]/g, "")
    }

    function playWord (modelData) {
        word.source = soundsPath + parseWord(modelData) + ".mp3"
        pause()
        word.play()
    }

    function iswordByWordLastIndex () {
        let wordsLength = page.content[page.view.currentIndex].words.length
        return wordByWordIndex === wordsLength - 1
    }

    function isAnthemLastSection () {
        return page.view.currentIndex === page.content.length - 1
    }

    function statusHandler () {
        if (playing && player.status === Audio.Loaded)
            return play()
        if (player.status !== Audio.EndOfMedia)
            return
        if (wordByWord && !iswordByWordLastIndex())
            wordByWordIndex++
        else if (isAnthemLastSection())
            reset()
        else
            next()
    }

    function getSource () {
        if (wordByWord) {
            let w = page.content[page.view.currentIndex].words[wordByWordIndex]
            return soundsPath + parseWord(w) + ".mp3"
        } else
            return soundsPath + "anthem-choir.mp3"
    }

    MediaPlayer {
        id: player
        source: getSource()
        onStatusChanged: statusHandler()
    }

    Audio { id: word }

    Timer {
        id: timer
        interval: 10
        running: false
        repeat: true
        onTriggered: page.view.currentIndex = getCurrentSection()
    }
}
