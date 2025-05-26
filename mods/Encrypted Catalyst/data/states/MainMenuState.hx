function update(){
    if (FlxG.keys.justPressed.C) {
        FlxG.sound.music.fadeOut(1, 0, t -> {
            FlxG.switchState(new ModState("MEOW"));

        });
    }
}

function create() {
    FlxG.sound.playMusic(Paths.music("freakyMenu"), 0.7);
    
}