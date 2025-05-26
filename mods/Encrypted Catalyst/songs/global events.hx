import funkin.backend.scripting.events.CancellableEvent;

var cancelCountdown:CancellableEvent = new CancellableEvent();

public function snapCam(?x, ?y){
    x ??= dad.getCameraPosition().x;
    y ??= dad.getCameraPosition().y;

    camFollow.setPosition(x, y);
    camGame.snapToTarget();
}

function onStartCountdown(event) {
    scripts.call("onSkipCountdown", [cancelCountdown]);

    if (cancelCountdown.cancelled) return;

    event.cancel(true);

    startSong();
    startedCountdown = true;
}