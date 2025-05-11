function onStartCountdown(event) {
    event.cancel(true);

    startSong();
    startedCountdown = true;
}

function stepHit(curStep:Int) {
    switch(curStep) {
        case 2656:
            boyfriend.visible = false;
            gf.visible = true;

        case 5376:
          boyfriend.visible = true;  

    }
}

