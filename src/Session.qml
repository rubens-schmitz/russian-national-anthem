import Session 1.0

Session {
    function handle () {
        return (root.visible == true) ? session.restore() : session.save()
    }

    function restore () {
        let v = value("width")
        root.width = (width === "") ? 320 : v
        v = value("height")
        root.height = (height === "") ? 480 : v
        v = value("x")
        root.x = (x === "") ? 0 : v
        v = value("y")
        root.y = (y === "") ? 0 : v
        v = value("accessibility")
        accessibility.enabled = (v === "" || v === "false") ? false : true
        if (accessibility.enabled)
            media.playWord("государственныйгимнроссийскойфедерации")
    }

    function save () {
        setValue("width", root.width)
        setValue("height", root.height)
        setValue("x", root.x)
        setValue("y", root.y)
        setValue("accessibility", accessibility.enabled)
    }

    function quit () {
        save()
        Qt.quit()
    }
}
