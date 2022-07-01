package;

import flixel.FlxState;

class EditState extends FlxState
{
	override public function create()
	{
		super.create();

		if(FlxG.sound.music == null) {
			FlxG.sound.playMusic(Paths.music('menuMusic'), 0);

			FlxG.sound.music.fadeIn(4, 0, 0.7);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
