var cammove = 15;
var angleMoveSpeed = 0.06;
var angleVar = 0.45; 
var cameraSpeed = 1;

function postUpdate() {
    switch(strumLines.members[curCameraTarget].characters[0].getAnimName()) {
        case "singLEFT": 
            camFollow.x -= cammove;
            camGame.angle = (lerp(camGame.angle, -angleVar, angleMoveSpeed));
        case "singDOWN": 
            camFollow.y += cammove;
            camGame.angle = (lerp(camGame.angle, 0, angleMoveSpeed));
        case "singUP": 
            camFollow.y -= cammove;
            camGame.angle = (lerp(camGame.angle, 0, angleMoveSpeed));
        case "singRIGHT": 
            camFollow.x += cammove;
            camGame.angle = (lerp(camGame.angle, angleVar, angleMoveSpeed));
        case "idle", "hey":
            camGame.angle = (lerp(camGame.angle, 0, angleMoveSpeed));
    }

    if (curCameraTarget == 0) {
        defaultCamZoom = 0.6;
    }
    else if (curCameraTarget == 1) {
        defaultCamZoom = 0.75;
    }
    else if (curCameraTarget == 2) {
        defaultCamZoom = 0.82;
    }


}

function postCreate() {
    FlxG.camera.followLerp *= 2;

}
     