var shader:CustomShader = new CustomShader('Glitch');

function create(event){
    event.cancel();

    for (i in FlxG.cameras.list) applyGlitch(i);
    FlxTween.num(
        (event.transOut ? 0 : 2),
        (event.transOut ? 2 : 0),
        0.5,
        {
            ease: (event.transOut ? FlxEase.quadIn : FlxEase.quadOut),
            onComplete: function() finish()
        },
        function (num:Float) {
            shader.prob = num * 2;
            shader.time = num;
            shader.intensityChromatic = num / 2;
        }
        );
}

function applyGlitch(camera:FlxCamera)
{
    camera.addShader(shader);
}