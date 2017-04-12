var button = document.getElementById("buy");
button.addEventListener("click", function() {
            var messgeToPost = {'ButtonId':'clickMeButton'};
            window.webkit.messageHandlers.buttonClicked.postMessage(messgeToPost);
        },false);