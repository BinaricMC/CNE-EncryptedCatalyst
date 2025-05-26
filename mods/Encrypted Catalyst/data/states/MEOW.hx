import flixel.FlxObject;
import flixel.ui.FlxButton;

var adsList:Array<Dynamic> = [];
var curAdSelected:Int = 0;

var adSelectedTxt:FlxText;
var camFollow:FlxObject;

var bg:FlxSprite;
var btns:Array<FlxButton> = [];

/*
[
    [No Time For Funkin', https://www.youtube.com/watch?v=AhBYB4NfDlg],
    [Test 2 (PREMEDITATED JX), https://www.youtube.com/watch?v=KIsa7i5hJ58],
    [Test (NO URL)]
]
*/

function create() {
    bg = new FlxSprite(0, 0);
    bg.scrollFactor.set(0.9, 0.9);
    bg.screenCenter();
    add(bg);
    bg.antialiasing = true;

    adSelectedTxt = new FlxText(0, FlxG.height * 0.825, FlxG.width, "Testing testing 123", 24);
    adSelectedTxt.alignment = 'center';
    adSelectedTxt.scrollFactor.set(0.8, 0.8);
    add(adSelectedTxt);
    adSelectedTxt.antialiasing = true;

    adsList = CoolUtil.parseJson('data/modAds.json');
    trace(adsList);

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
    btn.updateHitbox();
}

function changeAd(e:Int){
    curAdSelected = FlxMath.wrap(curAdSelected + e, 0, adsList.length-1);

    adSelectedTxt.text = adsList[curAdSelected][0];
    adSelectedTxt.screenCenter(FlxAxes.X);

    loadImg();
}

function loadImg() {
    var img = adsList[curAdSelected][2];
    bg.loadGraphic(Paths.image('menus/advert/banner/' + img));

    bg.setGraphicSize(FlxG.width * 0.6, FlxG.height * 0.6);
    bg.updateHitbox();

    bg.screenCenter();
}

function selectAd(service:Int){
    var url = adsList[curAdSelected][1][service];

    if (url != null) CoolUtil.openURL(url);
    else trace('No URL in json array\'s index ' + service + ', do nothing');
}

function update(elapsed:Float){
    camFollow.setPosition((FlxG.width - (FlxG.mouse.x / 90)) / 2, ((FlxG.height - (FlxG.mouse.y / 90)) / 2) + 35);

    if (controls.LEFT_P) changeAd(-1);
    if (controls.RIGHT_P) changeAd(1);
    if (controls.ACCEPT) selectAd(0);

    if (controls.BACK) FlxG.switchState(new MainMenuState());
}