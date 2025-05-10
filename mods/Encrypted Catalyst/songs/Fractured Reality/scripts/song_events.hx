function postCreate() {
    snapCam();
}

function onStartCountdown(event) {
    event.cancel(true);

    startSong();
    startedCountdown = true;
}

