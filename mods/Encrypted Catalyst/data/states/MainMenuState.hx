import funkin.menus.ModSwitchMenu;

var txts:FlxGroup;

function update(){
    if (FlxG.keys.justPressed.C) {
        FlxG.sound.music.fadeOut(1, 0, t -> {
            FlxG.sound.playMusic(Paths.music("creditstheme"), 0.7);
            FlxG.switchState(new ModState("MEOW"));
        });
        camera.fade(FlxColor.BLACK, 0.95);
    }

    if (controls.SWITCHMOD && FlxG.state.subState == null) openSubState(new ModSwitchMenu());
}

function create() {
    // Only plays the menu music if nothing else is playing
    if (!FlxG.sound.music.playing) FlxG.sound.playMusic(Paths.music("freakyMenu"), 0.7);
    camera.flash(FlxColor.BLACK, 0.95);

    txts = new FlxGroup();
    add(txts);

    var toAdd = ["STORY MODE", "FREEPLAY", "CREDITS & EXTRAS", "ADVERTISEMENTES", "OPTIONS"];
    for (i in 0...toAdd.length) createText(toAdd[i], [50, (130 + (i * 100))]);
}

function createText(string:String, pos:Array<Float>){
    text = new FlxText();
    text.text = string;
    text.size = 40;
    text.scrollFactor.set(0, 0);
    text.x = pos[0];
    text.y = pos[1];
    text.antialiasing = Options.antialiasing;

    add(text);
    txts.add(text);
}