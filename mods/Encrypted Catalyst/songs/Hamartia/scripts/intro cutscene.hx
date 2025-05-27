import hxvlc.flixel.FlxVideoSprite;

var video:FlxVideoSprite;

function create(){
    camGame.visible = debug;
}

var debug = true;
function onSongStart(){
    if (FlxG.sound.music.time < 1000) {
        video = new FlxVideoSprite(0, 0);

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

            camGame.flash(0xFF000000, 1);
        });
        add(video);

        video.load(Paths.video("uncleShucks"));
        video.play();
    }
}

function destroy(){
    video?.destroy();
}

function onGamePause(){
    video?.pause();
}

function update(elapsed:Float){
    if (!PlayState.instance.paused && video != null) {
        resync(video?.bitmap?.time, Conductor.songPosition, elapsed);
        video?.resume();
    }
}

function resync(time:Int, pos:Int, elapsed:Float) {
	var isOffsync = time != pos;
	__vocalOffsetViolation = Math.max(0, __vocalOffsetViolation + (isOffsync ? elapsed : -elapsed / 2));
	if (__vocalOffsetViolation > 25 && time > 999) {
		syncVideo();
		__vocalOffsetViolation = 0;
	}
}

function syncVideo() {
    video?.pause();
    video?.bitmap.time = Conductor.songPosition;
    video?.resume();
    trace("RESYNCED VIDEO!");
}

@:deprecated
function fuckoffVid(){
    // DO NOT USE!!!
}