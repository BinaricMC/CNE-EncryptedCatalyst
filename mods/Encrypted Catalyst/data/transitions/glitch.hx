var shader:CustomShader = new CustomShader('Glitch');

function create(event){
    event.cancel();

    for (i in FlxG.cameras.list) applyGlitch(i);
    FlxTween.num((event.transOut ? 0 : 2), (event.transOut ? 2 : 0), 0.5, {ease: (event.transOut ? FlxEase.quadIn : FlxEase.quadOut), onUpdate: function(e) {
        shader.prob = e.value * 2;
        shader.time = e.value;
        shader.intensityChromatic = e.value / 2;
    }, onComplete: function() finishTrans(), type: FlxTween.ONESHOT});
}

function applyGlitch(camera:FlxCamera)
{
    camera.addShader(shader);
}

function finishTrans(){
    shader.time = 0;
    shader.prob = 0;
    shader.intensityChromatic = 0;
    finish();
}