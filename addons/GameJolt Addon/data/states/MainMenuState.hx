import funkin.editors.UIDebugState;
import funkin.editors.ui.UIState;

function onSelectItem(event) {
	switch(event.name) {
		case 'login':
			FlxG.switchState(new UIState(true, "LoginState"));
	}
}