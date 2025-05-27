function update(){
    if (FlxG.keys.justPressed.C) {
        FlxG.sound.music.fadeOut(1, 0, t -> {
            FlxG.sound.playMusic(Paths.music("creditstheme"), 0.7);
            FlxG.switchState(new ModState("MEOW"));
        });
        camera.fade(FlxColor.BLACK, 0.95);
    }
}

function create() {
    FlxG.sound.playMusic(Paths.music("freakyMenu"), 0.7);
    camera.flash(FlxColor.BLACK, 0.95);
}