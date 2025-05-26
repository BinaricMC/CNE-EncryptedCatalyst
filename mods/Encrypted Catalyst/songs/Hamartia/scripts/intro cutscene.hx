import hxvlc.flixel.FlxVideoSprite;

var video:FlxVideoSprite = new FlxVideoSprite(0, 0);

function postCreate(){
    video.load(Paths.video("uncleShucks"));

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
        camGame.visible = true;
    });
    add(video);
}

function onSongStart(){
    if (video.load(Paths.video("uncleShucks"))) new FlxTimer().start(0.001, (_) -> video.play());
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

function fuckoffVid(){
    video?.destroy();
}