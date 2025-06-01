import funkin.menus.ModSwitchMenu;
import flixel.effects.FlxFlicker;
import funkin.editors.EditorPicker;

import openfl.ui.Mouse;

// states
import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;

// text functions
var txts:FlxGroup;
var lowerText:FlxTypeText;
var typeSpeed:Float = 0.05;
var tabText:FlxText;

// menu functions
var curSelected:Int = 0;
var canSelect:Bool = true;
var menus = ["StoryMode", "FreeplayState", "Credits", "AdsState", "Options"];
var states = [new StoryMenuState(), new FreeplayState(), new CreditsMain(), new ModState('AdsState'), new OptionsMenu()];

function create() {
    //background shit
    aura = new FunkinSprite(300, -500).loadGraphic(Paths.image('menus/mainmenu/aura'));
    aura.scale.set(0.8, 0.8);
    add(aura);

    background = new FunkinSprite(-720, -400).loadGraphic(Paths.image('menus/mainmenu/background'));
    background.scale.set(0.5, 0.5);
    add(background);

    outlines = new FunkinSprite(-710, -407).loadGraphic(Paths.image('menus/mainmenu/outlines'));
    outlines.scale.set(0.5, 0.5);
    add(outlines);

    //text
    new FlxTimer().start(2, function(tmr:FlxTimer)
        {
            lowerText = new FlxTypeText(5, FlxG.height - 10, 0, '"AN FNF MOD BASED ON THE TALES OF DODGE GREENLY IN THE ARTISTIC STYLE AND VISION OF O0OPS."');
            lowerText.y -= lowerText.height;
            lowerText.size = 20;
            lowerText.scrollFactor.set();
            lowerText.font = Paths.font("black-ground.ttf");
            lowerText.start(typeSpeed);
            lowerText.antialiasing = Options.antialiasing;
            lowerText.color = FlxColor.GRAY;
	        add(lowerText);
        });
    
    tabText = new FlxText(1020, FlxG.height - 9, 0, 'Press TAB to Open Mods Menu');
    tabText.y -= tabText.height;
    tabText.font = Paths.font("black-ground.ttf");
    tabText.size = 20;
    tabText.scrollFactor.set();
    add(tabText);

    // Only plays the menu music if nothing else is playing
    if (!FlxG.sound.music.playing) FlxG.sound.playMusic(Paths.music("freakyMenu"), 0.7);
    camera.flash(FlxColor.BLACK, 0.95);

    txts = new FlxGroup();
    add(txts);

    var toAdd = ["STORY MODE", "FREEPLAY", "CREDITS & EXTRAS", "ADVERTISEMENTS", "OPTIONS"];
    for (i in 0...toAdd.length) createText(toAdd[i], [50, (130 + (i * 100))]);

    changeSelect(0);
}

function postCreate()
    FlxG.mouse.visible = true;

function update(){
    if (canSelect && FlxG.state.subState == null) {
        if (controls.SWITCHMOD && FlxG.state.subState == null) 
            openSubState(new ModSwitchMenu());

        if (controls.DOWN_P) 
            changeSelect(1);

        if (controls.UP_P) 
            changeSelect(-1);

        if (controls.ACCEPT) 
            select();
    }

    if (FlxG.keys.justPressed.SEVEN) {
        openSubState(new EditorPicker());

        persistentUpdate = false;
        persistentDraw = true;
    }
}


function createText(string:String, pos:Array<Float>){
    text = new FlxText();
    text.text = string;
    text.size = 52;
    text.scrollFactor.set(0, 0);
    text.x = pos[0];
    text.y = pos[1];
    text.font = Paths.font("black-ground.ttf");
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

    new FlxTimer().start(1, function() FlxG.switchState(states[curSelected]));
}