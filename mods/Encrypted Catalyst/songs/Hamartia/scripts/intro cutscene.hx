import hxvlc.flixel.FlxVideoSprite;

var video:FlxVideoSprite = new FlxVideoSprite(0, 0);

function postCreate(){
    camGame.visible = false;

    video.antialiasing = Options.antialiasing;
    video.bitmap.onPlaying.add(function():Void
    {
        if (video.bitmap != null && video.bitmap.bitmapData != null)
        {
            final scale:Float = Math.min(FlxG.width / video.bitmap.bitmapData.width, FlxG.height / video.bitmap.bitmapData.height);

            video.setGraphicSize(video.bitmap.bitmapData.width * scale, video.bitmap.bitmapData.height * scale);
            video.cameras = [camHUD];
            video.updateHitbox();
            video.screenCenter();
        }
    });

    video.bitmap.onEndReached.add(function() {
        video?.destroy();
        camGame.visible = true;
    });
    add(video);
}

function onSongStart(){
    video.load(Paths.video("uncleShucks"));
    video.play();
}

function destroy(){
    video?.destroy();
}

function onGamePause(){
    video?.pause();
}

function update(){
    if (!PlayState.instance.paused) video?.resume();
}

@:deprecated
function fuckoffVid(){
    // DO NOT USE!!!
}