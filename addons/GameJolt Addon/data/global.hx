import funkin.backend.api.GameJolt;

static var trophies:Array<Dynamic> = [
	{name: "login", gameJoltID: 230578}

	{name: "flyswatter", gameJoltID: 230581},

	{name: "week1_nomiss", gameJoltID: 230579},
	{name: "week2_nomiss", gameJoltID: 230580}
];

public function new() {
	GameJolt.authenticate();

	// GameJolt setup
	GameJolt.scoreboardMap = [
		"hamartia" => 902014
	];
}

static var achievementsUnlocked:Map<String, Bool> = [];
public static function unlockAchievement(name:String) {
	for (i in 0... trophies.length) {
		if (trophies[i].name == name) {
			achievementsUnlocked.set(name, true);
			GameJolt.unlockTrophy(trophies[i].gameJoltID);
			trace("unlocked trophy: " + name + "\ntrophy: " + trophies[i]);
		}
	}

	FlxG.save.data.achievementsUnlocked = achievementsUnlocked;
	FlxG.save.flush();
}