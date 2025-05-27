import flixel.FlxObject;
import flixel.ui.FlxButton;

var adsList:Array<Dynamic> = [];
var adImages:Array<FlxSprite> = [];
var curAdSelected:Int = 0;

var adSelectedTxt:FlxText;
var camFollow:FlxObject;

var btns:Array<FlxButton> = [];

/*
[
    [No Time For Funkin', https://www.youtube.com/watch?v=AhBYB4NfDlg],
    [Test 2 (PREMEDITATED JX), https://www.youtube.com/watch?v=KIsa7i5hJ58],
    [Test (NO URL)]
]
*/

function create() {
    camera.flash(FlxColor.BLACK, 1);
    FlxG.sound.playMusic(Paths.music("creditstheme"), 0.5); // PLACEHOLDER LMAO

    adSelectedTxt = new FlxText(0, FlxG.height * 0.825, FlxG.width, "Testing testing 123", 24);
    adSelectedTxt.alignment = 'center';
    adSelectedTxt.scrollFactor.set(0, 0);
    add(adSelectedTxt);
    adSelectedTxt.antialiasing = true;

    adsList = CoolUtil.parseJson('data/modAds.json');

    for (i in 0...adsList.length) loadImg(adsList[i][2], i*1200);

    changeAd(0);

    camFollow = new FlxObject(0, 0, 1, 1);
    add(camFollow);

    FlxG.camera.follow(camFollow, 0.005);
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

    adSelectedTxt.text = adsList[curAdSelected][0];
    adSelectedTxt.screenCenter(FlxAxes.X);
}

function loadImg(img:Dynamic, x:Float) {
    var bg = new FlxSprite(0, 0);

    bg.loadGraphic(Paths.image('menus/advert/banner/' + img));

    bg.setGraphicSize(FlxG.width * 0.6, FlxG.height * 0.6);

    //Cool, I made a switch case lol

    switch(img){
        case 'roguetransmission':
            bg.setGraphicSize(FlxG.width * 1);

        case '2010':
            bg.setGraphicSize(FlxG.width * 0.7, FlxG.height * 0.5);

        case 'ntff':
            bg.setGraphicSize(FlxG.width * 0.8, FlxG.height * 0.35);

    }

    bg.screenCenter();

    bg.x += x;

    add(bg);

    adImages.push(bg);
}

function selectAd(service:Int){
    var url = adsList[curAdSelected][1][service];

    if (url != null) CoolUtil.openURL(url);
    else trace('No URL in json array\'s index ' + service + ', do nothing');
}

var lerpSpeed = 0.1;

function update(elapsed:Float){
    camFollow.setPosition(CoolUtil.fpsLerp(camFollow.x, adImages[curAdSelected].getGraphicMidpoint().x, lerpSpeed), ((FlxG.height + (FlxG.mouse.y / 90)) / 2) + 35);

    if (controls.LEFT_P) changeAd(-1);
    if (controls.RIGHT_P) changeAd(1);

    if (controls.BACK) {
        FlxG.sound.music.fadeOut(1, 0, t -> {
            FlxG.switchState(new MainMenuState());
        });

        FlxTween(camera, {zoom: 1.5}, 1, {ease: FlxEase.sineOut, type: FlxTween.ONESHOT});
        camera.fade(FlxColor.BLACK, 0.95);
    }
    for (btn in btns) {
        if (FlxG.mouse.overlaps(btn)) {
            btn.alpha = 1.0;
        } else {
            btn.alpha = 0.4;
        }
    }
}