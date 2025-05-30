import funkin.menus.ModSwitchMenu;
import flixel.effects.FlxFlicker;

var txts:FlxGroup;

var curSelected:Int = 0;

var canSelect:Bool = true;

var menus = [
    "StoryMode",
    "FreeplayState",
    "Credits",
    "MEOW",
    "Options"
];
function update(){
    if (canSelect){
        if (controls.SWITCHMOD && FlxG.state.subState == null) openSubState(new ModSwitchMenu());
        if (controls.DOWN_P) changeSelect(1);
        if (controls.UP_P) changeSelect(-1);
        if (controls.ACCEPT) select();
    }
}

function create() {
    // Only plays the menu music if nothing else is playing
    if (!FlxG.sound.music.playing) FlxG.sound.playMusic(Paths.music("freakyMenu"), 0.7);
    camera.flash(FlxColor.BLACK, 0.95);

    txts = new FlxGroup();
    add(txts);

    var toAdd = ["STORY MODE", "FREEPLAY", "CREDITS & EXTRAS", "ADVERTISEMENTES", "OPTIONS"];
    for (i in 0...toAdd.length) createText(toAdd[i], [50, (130 + (i * 100))]);

    changeSelect(0);
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

function changeSelect(e:Int){
    txts.members[curSelected].color = FlxColor.WHITE;

    CoolUtil.playMenuSFX();
    curSelected = FlxMath.wrap(curSelected + e, 0, txts.length-1);

    txts.members[curSelected].color = FlxColor.GREEN;
}

function select(){
    CoolUtil.playMenuSFX(1);
    FlxFlicker.flicker(txts.members[curSelected], 1, 0.04, true, false);

    if (menus[curSelected] == 'MEOW') FlxG.sound.music.fadeOut(0.95, 0, t -> FlxG.sound.playMusic(Paths.music("creditstheme"), 0.7));

    new FlxTimer().start(1, function() FlxG.switchState(new ModState(menus[curSelected])));
}