var memes:Array<String> = CoolUtil.coolTextFile('assets/data/randomshitlol.txt');
var ads:Array<String> = CoolUtil.coolTextFile('assets/data/modAds.txt');

var adsList:Array<String, String> = [];

var curAdSelected:Int = 0;

var adSelectedTxt:FlxText = new FlxText();

function create(){
    adSelectedTxt.size = 50;
    adSelectedTxt.alignment = 'center';
    adSelectedTxt.screenCenter();
    adSelectedTxt.scrollFactor.set(0, 0);
    add(adSelectedTxt);

    for (i in 0...ads.length)
    {
        split = ads[i].split('/:/');

        adsList.push([split[0], (split[1] != null ? split[1] : memes[FlxG.random.int(0, memes.length - 1)])]);
    }

    trace(adsList);

    changeAd(0);
}

function changeAd(e:Int){
    curAdSelected = FlxMath.wrap(curAdSelected + e, 0, adsList.length-1);

    adSelectedTxt.text = adsList[curAdSelected][0];
    adSelectedTxt.screenCenter(FlxAxes.X);
}

function selectAd(){
    CoolUtil.openURL(adsList[curAdSelected][1]);
}

function update(){
    if (controls.LEFT_P) changeAd(-1);
    if (controls.RIGHT_P) changeAd(1);
    if (controls.ACCEPT) selectAd();
}