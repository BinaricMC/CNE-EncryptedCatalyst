var redirectStates:Map<FlxState, String> = [
    TitleState => "Intro",
];

function update(elapsed)
    if (FlxG.keys.justPressed.F5)
        FlxG.resetState();