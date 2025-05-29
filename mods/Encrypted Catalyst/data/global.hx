import funkin.backend.MusicBeatTransition;

var redirectStates:Map<FlxState, String> = [
    MainMenuState => "MainMenuState"
];

MusicBeatTransition.script = 'data/transitions/glitch';

function preStateSwitch() {
    for (redirectState in redirectStates.keys())
        if (Std.isOfType(FlxG.game._requestedState, redirectState))
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}

function update(elapsed)
    if (FlxG.keys.justPressed.F5)
        FlxG.resetState();