package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.FlxBasic;
import flixel.FlxSprite;

class TransitionSubState extends FlxSubState
{
	public function new()
	{
		super();
	}

	private var controls(get, never):Controls;

	inline function get_controls():Controls
		return PlayerSettings.player1.controls;

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
