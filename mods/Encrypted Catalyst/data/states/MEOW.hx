import flixel.FlxObject;

var adsList:Array<Dynamic> = [];
var curAdSelected:Int = 0;

var adSelectedTxt:FlxText;
var camFollow:FlxObject;

var bg:FlxSprite;

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

    var dark:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width * 1.1, FlxG.height * 1.1, FlxColor.BLACK);
    add(dark);
    dark.screenCenter();
    dark.alpha = 0.6;

    var bg2 = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/titlescreen/newgrounds_logo'));
    bg2.scrollFactor.set(0.4, 0.4);
    add(bg2);

    adSelectedTxt = new FlxText(0, 0, FlxG.width, "Testing testing 123", 32);
    adSelectedTxt.size = 50;
    adSelectedTxt.alignment = 'center';
    adSelectedTxt.screenCenter();
    adSelectedTxt.scrollFactor.set(0, 0);
    add(adSelectedTxt);

    adsList = CoolUtil.parseJson('data/modAds.json');
    trace(adsList);

    changeAd(0);

    camFollow = new FlxObject(0, 0, 1, 1);
    add(camFollow);

    FlxG.camera.follow(camFollow, 0.005);
    FlxG.mouse.visible = true;
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

function selectAd(){
    var url = adsList[curAdSelected][1];

    if (url != null) CoolUtil.openURL(url);
    else trace('No URL in json, do nothing');
}

function update(elapsed:Float){
    camFollow.setPosition((FlxG.width - (FlxG.mouse.x / 90)) / 2, (FlxG.height - (FlxG.mouse.y / 90)) / 2);

    if (controls.LEFT_P) changeAd(-1);
    if (controls.RIGHT_P) changeAd(1);
    if (controls.ACCEPT) selectAd();
}