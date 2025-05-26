// icons don't have a method?

var defaultIconScale:Float = 1.0;
var defaultIconLerp:Float = 0.33;
var maxIconScale = 1.2;

function postCreate() doIconBop = false;

function beatHit(e:Int) if (curBeat >= 0 && curBeat % camZoomingInterval == 0 && camZooming) for (i in [iconP1, iconP2]) bump(i);

function bump(e:HealthIcon){
	e.scale.set(defaultIconScale * maxIconScale, defaultIconScale * maxIconScale);
}

function update() for (e in [iconP1, iconP2]) updateBump(e);

function updateBump(e:HealthIcon) e.scale.set(CoolUtil.fpsLerp(e.scale.x, defaultIconScale, defaultIconLerp), CoolUtil.fpsLerp(e.scale.y, defaultIconScale, defaultIconLerp));