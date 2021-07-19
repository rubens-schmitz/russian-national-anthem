import QtQuick 2.11

Item {
    property bool enabled

    function change () {
        enabled = !enabled
        if (enabled)
            media.playWord("государственныйгимнроссийскойфедерации")
    }

    function bypass (fn) {
        let tmp = enabled
        enabled = false
        fn()
        enabled = tmp
    }
}
