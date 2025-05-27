import flixel.FlxObject;
import flixel.ui.FlxButton;
import flixel.text.FlxTextBorderStyle;

var adsList:Array<Dynamic> = [];
var curAdSelected:Int = 0;

var adImages:FlxGroup;

var adSelectedTxt:FlxText;
var camFollow:FlxObject;

var btns:Array<FlxButton> = [];

//typing 
var fullText:String = "";
var typedText:String = "";
var textTimer:Float = 0;
var charIndex:Int = 0;
var typeSpeed:Float = 0.03;

function create() {
    camera.flash(FlxColor.BLACK, 1);

    var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/menuDesat'));
    add(bg);
    bg.scrollFactor.set(0, 0);

    adImages = new FlxGroup();
    add(adImages);

    adSelectedTxt = new FlxText(0, FlxG.height * 0.825, FlxG.width, "Testing testing 123", 24);
    adSelectedTxt.scrollFactor.set(0, 0);
    adSelectedTxt.setFormat(Paths.font('arial-rounded-mt-bold.ttf'), 30, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    adSelectedTxt.antialiasing = true;
    add(adSelectedTxt);

    adsList = CoolUtil.parseJson('data/modAds.json');

    for (i in 0...adsList.length) loadImg(adsList[i][2], i);

    changeAd(0);

    camFollow = new FlxObject(0, 0, 1, 1);
    add(camFollow);

    FlxG.camera.follow(camFollow, 0.2);
    FlxG.mouse.visible = true;

    makeButtons(function() {
        selectAd(0);
    }, "youtube", [25, 625]);

    makeButtons(function() {
        selectAd(1);
    }, "twitter", [125, 625]);

    makeButtons(function() {
        selectAd(2);
    }, "gamejolt", [1075, 625]);

    makeButtons(function() {
        selectAd(3);
    }, "gamebanana", [1175, 625]);
}

function makeButtons(func:Void->Void, serv:String, pos:Array<Float>) {
    var btn = new FlxButton(pos[0], pos[1], "haiiii :3 " + serv, func);
    loadBtn(btn, serv);
    btn.label.visible = false;
    add(btn);
    btns.push(btn);
}

function loadBtn(btn:FlxButton, serv:String) {
    btn.loadGraphic(Paths.image('menus/advert/' + serv));
    btn.setGraphicSize(75, 75);
    btn.alpha = 0.4;
    btn.updateHitbox();
}

function changeAd(e:Int){
    curAdSelected = FlxMath.wrap(curAdSelected + e, 0, adsList.length-1);

    fullText = adsList[curAdSelected][0];
    typedText = "";
    charIndex = 0;
    textTimer = 0;

    adSelectedTxt.text = "";
    adSelectedTxt.screenCenter(FlxAxes.X);
}

function loadImg(img:String, index:Int) {
    var bg = new FlxSprite(0, 0);
    bg.loadGraphic(Paths.image('menus/advert/banner/' + img));

    bg.antialiasing = true;

    bg.scrollFactor.set(1, 1);
    bg.setGraphicSize(FlxG.width * 0.6, FlxG.height * 0.6);

    //Cool, I made a switch case lol
    switch(img){
        case 'roguetransmission':
            bg.setGraphicSize(FlxG.width * 0.9, FlxG.height * 0.5);

        case '2010':
            bg.setGraphicSize(FlxG.width * 0.7, FlxG.height * 0.5);

        case 'ntff':
            bg.setGraphicSize(FlxG.width * 0.8, FlxG.height * 0.35);
    }
    
    bg.updateHitbox();
    bg.screenCenter(FlxAxes.XY);
    bg.x += 1600 * index;

    adImages.add(bg);
}

function selectAd(service:Int){
    var url = adsList[curAdSelected][1][service];

    if (url != null && url != "") CoolUtil.openURL(url);
    else trace('No URL in json array\'s index ' + service + ', do nothing');
}

// PLEASE FIX THIS CODE ITS VERY BROKEN
var intensity = 4;
function adaMethod() {
    var lots = 4 - 3.935;

    // I fucking love BIDMAS, or PIMDAS, or however tf you Americans say it
    var camPos = [
        ((FlxG.mouse.x * intensity) / FlxG.width) - ((FlxG.width / intensity) * (lots)),
        ((FlxG.mouse.y * intensity) / FlxG.height) + 400
    ];
    // Let's lerp again, because FlxCamera's lerp doesn't do shit
    camFollow.setPosition(
        (adImages.members[curAdSelected].getMidpoint().x + camPos[0]),
        camPos[1]
    );
}

function update(elapsed:Float) {
    adaMethod();

    // Controls stuff
    if (controls.LEFT_P) changeAd(-1);
    if (controls.RIGHT_P) changeAd(1);

    if (controls.BACK) {
        FlxG.sound.music.fadeOut(1, 0, t -> {
            FlxG.sound.playMusic(Paths.music("freakyMenu"), 0.7);
            FlxG.switchState(new MainMenuState());
        });

        FlxTween(camera, {zoom: 1.5}, 1, {ease: FlxEase.sineOut, type: FlxTween.ONESHOT});
        camera.fade(FlxColor.BLACK, 0.95);

    }

    // Button fade stuff
    for (btn in btns) {
        var targetAlpha = FlxG.mouse.overlaps(btn) ? 1.0 : 0.4;
        btn.alpha = CoolUtil.fpsLerp(btn.alpha, targetAlpha, 0.2);
    }

    // FlxTypeText exists you know
    if (charIndex == 0) typeSpeed = 0.03;
    if (charIndex < fullText.length) {
        textTimer += elapsed;

        if (textTimer >= typeSpeed) {
            textTimer = 0;

            typedText += fullText.charAt(charIndex);
            if (StringTools.contains(typedText, '\n')) {
                // NEW LINE!
                typeSpeed = 0.02;
            }

            charIndex++;
            adSelectedTxt.text = typedText;
            adSelectedTxt.screenCenter(FlxAxes.X);
        }
    }
}