$(function() {
    function display(bool) {
        if (bool) {
            $("#menu").fadeIn(300);
        } else {
            $("#menu").fadeOut(300);
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })

    $("#close").click((e) => {
        e.preventDefault()
        $.post("http://wlmenu/kapat", JSON.stringify({}));
        return;
    })

    $("#ekle").click((e) => {
        e.preventDefault()
        let hex = $("#hex").val()
        if (!hex) {
            $.post("http://wlmenu/ekle", JSON.stringify({
                text: "Bir sen akıllısın kanka"
            }))
            return;
        }
        if (hex.startsWith("steam:") === false) {
            hex = `steam:${hex}`
        }
        $.post("http://wlmenu/ekle", JSON.stringify({
            text:hex
        }))
        return;
    })

    $("#yenile").click((e) => {
        e.preventDefault();
        $.post("http://wlmenu/yenile", JSON.stringify({}))
        return;
    })






})