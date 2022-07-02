package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.input.keyboard.FlxKey;

class EditState extends FlxState
{
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	public static var curSelected:Int = 0;

	var optionShit:Array<String> = ['spells', 
		'spell-sets', 
		'weapons', 
		'armor',
		'items',
		'shops',
		'jobs',
		'characters',
		'commands',
		'messages',
		'events',
		'maps',
		'monsters',
		'formations'];

	function menuShit()
		{
			optionShit = ['spells', 
				'spell-sets', 
				'weapons', 
				'armor',
				'items',
				'shops',
				'jobs',
				'characters',
				'commands',
				'messages',
				'events',
				'maps',
				'monsters',
				'formations'];
		}

		function changeItem(huh:Int = 0)
			{
				curSelected += huh;
			
					if (curSelected >= menuItems.length)
						curSelected = 0;
					if (curSelected < 0)
						curSelected = menuItems.length - 1;
			
					menuItems.forEach(function(spr:FlxSprite)
					{
						spr.animation.play('idle');
						spr.updateHitbox();
			
						if (spr.ID == curSelected)
						{
							spr.animation.play('selected');
							var add:Float = 0;
							if(menuItems.length > 4) {
								add = menuItems.length * 8;
							}
							spr.centerOffsets();
						}
					});
				}

	override public function create()
	{
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];

		persistentUpdate = persistentDraw = true;

		menuShit();

		if(FlxG.sound.music == null) {
			FlxG.sound.playMusic(Paths.music('menuMusic'), 0);

			FlxG.sound.music.fadeIn(4, 0, 0.7);
		}

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		bg.scrollFactor.set(0, 0);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.color = 0xFF242424;
		add(bg);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;

		for (i in 0...optionShit.length)
			{
				var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
				var menuItem:FlxSprite = new FlxSprite(0, (i * 140)  + offset);
				menuItem.scale.x = scale;
				menuItem.scale.y = scale;
				menuItem.frames = Paths.getSparrowAtlas('buttons/menu_' + optionShit[i]);
				menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
				menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
				menuItem.animation.play('idle');
				menuItem.ID = i;
			switch (optionShit[i])
				{case 'spells':
					menuItem.x = 0;
					menuItem.y = 0;
				case 'spell-sets':
					menuItem.x = 800;
					menuItem.y = 0;
				case 'weapons':
					menuItem.x = 0;
					menuItem.y = 200;
				case 'armor':
					menuItem.x = 800;
					menuItem.y = 200;
				case 'items':
					menuItem.x = 0;
					menuItem.y = 400;
				case 'shops':
					menuItem.x = 800;
					menuItem.y = 400;
				case 'jobs':
					menuItem.x = 0;
					menuItem.y = 600;
				case 'characters':
					menuItem.x = 800;
					menuItem.y = 600;
				case 'commands':
					menuItem.x = 0;
					menuItem.y = 800;
				case 'messages':
					menuItem.x = 800;
					menuItem.y = 800;
				case 'events':
					menuItem.x = 0;
					menuItem.y = 1000;
				case 'maps':
					menuItem.x = 800;
					menuItem.y = 1000;
				case 'monsters':
					menuItem.x = 0;
					menuItem.y = 1200;
				case 'formations':
					menuItem.x = 800;
					menuItem.y = 1200;
				}
				menuItems.add(menuItem);
				var scr:Float = (optionShit.length - 4) * 0.135;
				if(optionShit.length < 6) scr = 0;
				menuItem.scrollFactor.set(0, scr);
				menuItem.antialiasing = ClientPrefs.globalAntialiasing;
				//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
				menuItem.updateHitbox();
			}

		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "ONRPG Edit v0.0.1", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override public function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
			{
				FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			}
		
			if (!selectedSomethin)
				{
					if (controls.UI_LEFT_P)
					{
						FlxG.sound.play(Paths.sound('cursorScroll'));
						changeItem(-1);
					}
		
					if (controls.UI_RIGHT_P)
					{
						FlxG.sound.play(Paths.sound('cursorScroll'));
						changeItem(1);
					}
		
					if (controls.UI_UP_P)
					{
						FlxG.sound.play(Paths.sound('cursorScroll'));
						changeItem(2);
					}
		
					if (controls.UI_DOWN_P)
					{
						FlxG.sound.play(Paths.sound('cursorScroll'));
						changeItem(-2);
					}
		
					if (controls.ACCEPT)
					{
						if (optionShit[curSelected] == 'donate')
						{
							CoolUtil.browserLoad('https://sex-mode');
						}
						else
						{
							selectedSomethin = true;
							FlxG.sound.play(Paths.sound('cursorScroll'));
		
							//if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);
		
							menuItems.forEach(function(spr:FlxSprite)
							{
								if (curSelected != spr.ID)
								{
									FlxTween.tween(spr, {alpha: 0}, 0.4, {
										ease: FlxEase.quadOut,
										onComplete: function(twn:FlxTween)
										{
											spr.kill();
										}
									});
								}
								else
								{
									FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
									{
										var daChoice:String = optionShit[curSelected];
		
										switch (daChoice)
										{
											case 'story_mode':
												TransitionState.switchState(new StoryMenuState());
											case 'freeplay':
												TransitionState.switchState(new FreeplayState());
											case 'credits':
												TransitionState.switchState(new CreditsState());
											case 'options':
												LoadingState.loadAndSwitchState(new options.OptionsState());
											case 'patch':
												TransitionState.switchState(new PatchState());
											case 'true':
												TransitionState.switchState(new FreeplayState());
											case 'optionstrue':
												LoadingState.loadAndSwitchState(new options.OptionsState());
										}
									});
								}
							});
						}
					}
				}
		
		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
			{
				
			});
	}
}
