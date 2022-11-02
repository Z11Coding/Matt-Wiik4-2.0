package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxExtendedSprite;
import flixel.addons.plugin.FlxMouseControl;
import flixel.input.mouse.FlxMouse;
import flixel.addons.effects.FlxTrail;
import LoadingState.LoadingsState;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.5.2h'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	var tart:FlxSprite;
	var art1:FlxSprite;
	var art2:FlxSprite;
	var art3:FlxSprite;
	var art4:FlxSprite;
	var art5:FlxSprite;
	var artother:FlxSprite;
	var scoreText:FlxText;
	public static var weekName:String;
	
	var optionShit:Array<String> = [
		'tbutton',
		'1button',
		'2button',
		'3button',
		'4button',
		'5button',
		'freeplay',
		'options'
	];

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	var tbutton:FlxExtendedSprite;
	var button1:FlxExtendedSprite;
	var button2:FlxExtendedSprite;
	var button3:FlxExtendedSprite;
	var button4:FlxExtendedSprite;
	var button5:FlxExtendedSprite;
	var freeplay:FlxExtendedSprite;
	var options:FlxExtendedSprite;
	var wiiCursor:FlxSprite;
	var cursorSize:Float;
	var cursorOWidth:Float;

	override function create()
	{
		FlxG.plugins.add(new FlxMouseControl());
		FlxG.mouse.visible = false;
		FlxG.mouse.useSystemCursor = false;

		wiiCursor = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y).loadGraphic(Paths.image('wii_cursor'));
		wiiCursor.updateHitbox();
		//cursorOWidth = wiiCursor.width;
		//cursorSize = cursorOWidth;
		var evilTrail = new FlxTrail(wiiCursor, null, 20, 1, 1, 0.069); //nice

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		#if debug
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));
		#end

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menu'));
		bg.scrollFactor.set(0, 0);
		//bg.setGraphicSize(Std.int(bg.width * 0.99));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menu'));
		magenta.scrollFactor.set(0, 0);
		//magenta.setGraphicSize(Std.int(magenta.width * 0.99));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);
		
		// magenta.scrollFactor.set();

		tart = new FlxSprite(-39.5, -255).loadGraphic(Paths.image('mainmenu/tutorial'));
		tart.updateHitbox();
		tart.antialiasing = true;
		tart.alpha = 1;
		tart.setGraphicSize(Std.int(tart.width * 1.01));
		add(tart);

		art1 = new FlxSprite(-39.5, -255).loadGraphic(Paths.image('mainmenu/wiik1'));
		art1.updateHitbox();
		art1.antialiasing = true;
		art1.alpha = 0;
		art1.setGraphicSize(Std.int(art1.width * 1.01));
		add(art1);

		art2 = new FlxSprite(-39.5, -255).loadGraphic(Paths.image('mainmenu/wiik2'));
		art2.updateHitbox();
		art2.antialiasing = true;
		art2.alpha = 0;
		art2.setGraphicSize(Std.int(art2.width * 1.01));
		add(art2);

		art3 = new FlxSprite(-39.5, -255).loadGraphic(Paths.image('mainmenu/wiik3'));
		art3.updateHitbox();
		art3.antialiasing = true;
		art3.alpha = 0;
		art3.setGraphicSize(Std.int(art3.width * 1.01));
		add(art3);

		art4 = new FlxSprite(-39.5, -255).loadGraphic(Paths.image('mainmenu/wiik4'));
		art4.updateHitbox();
		art4.antialiasing = true;
		art4.alpha = 0;
		art4.setGraphicSize(Std.int(art4.width * 1.01));
		add(art4);

		art5 = new FlxSprite(-39.5, -255).loadGraphic(Paths.image('mainmenu/wiik5'));
		art5.updateHitbox();
		art5.antialiasing = true;
		art5.alpha = 0;
		art5.setGraphicSize(Std.int(art5.width * 1.01));
		add(art5);

		artother = new FlxSprite(-39.5, -255).loadGraphic(Paths.image('mainmenu/twothirdsofthesongsarejustboxing'));
		artother.updateHitbox();
		artother.antialiasing = true;
		artother.alpha = 1;
		artother.setGraphicSize(Std.int(artother.width * 1.01));
		add(artother);

		tbutton = new FlxExtendedSprite(-600, -300);
		tbutton.frames = Paths.getSparrowAtlas('mainmenu/tbutton');
		tbutton.animation.addByPrefix('idle', 'tbutton unselected', 24, false);
		tbutton.animation.addByPrefix('select', 'tbutton selected', 24, false);
		//tbutton.setGraphicSize(Std.int(tbutton.width / dasize));
		tbutton.updateHitbox();
		tbutton.enableMouseClicks(true, false, 255);
		add(tbutton);
		tbutton.animation.play('idle');
		tbutton.clickable = true;

		button1 = new FlxExtendedSprite(-600, -200);
		button1.frames = Paths.getSparrowAtlas('mainmenu/1button');
		button1.animation.addByPrefix('idle', '1button unselected', 24, false);
		button1.animation.addByPrefix('select', '1button selected', 24, false);
		//1button.setGraphicSize(Std.int(1button.width / dasize));
		button1.updateHitbox();
		add(button1);
		button1.animation.play('idle');

		button2 = new FlxExtendedSprite(-600, -100);
		button2.frames = Paths.getSparrowAtlas('mainmenu/2button');
		button2.animation.addByPrefix('idle', '2button unselected', 24, false);
		button2.animation.addByPrefix('select', '2button selected', 24, false);
		//2button.setGraphicSize(Std.int(2button.width / dasize));
		button2.updateHitbox();
		add(button2);
		button2.animation.play('idle');
		
		button3 = new FlxExtendedSprite(-600, 0);
		button3.frames = Paths.getSparrowAtlas('mainmenu/3button');
		button3.animation.addByPrefix('idle', '3button unselected', 24, false);
		button3.animation.addByPrefix('select', '3button selected', 24, false);
		//3button.setGraphicSize(Std.int(3button.width / dasize));
		button3.updateHitbox();
		add(button3);
		button3.animation.play('idle');

		button4 = new FlxExtendedSprite(-600, 100);
		button4.frames = Paths.getSparrowAtlas('mainmenu/4button');
		button4.animation.addByPrefix('idle', '4button unselected', 24, false);
		button4.animation.addByPrefix('select', '4button selected', 24, false);
		//4button.setGraphicSize(Std.int(4button.width / dasize));
		button4.updateHitbox();
		add(button4);
		button4.animation.play('idle');

		button5 = new FlxExtendedSprite(-600, 200);
		button5.frames = Paths.getSparrowAtlas('mainmenu/5button');
		button5.animation.addByPrefix('idle', '5button unselected', 24, false);
		button5.animation.addByPrefix('select', '5button selected', 24, false);
		//tbutton.setGraphicSize(Std.int(tbutton.width / dasize));
		button5.updateHitbox();
		add(button5);
		button5.animation.play('idle');

		freeplay = new FlxExtendedSprite(-50, 120);
		freeplay.frames = Paths.getSparrowAtlas('mainmenu/freeplay');
		freeplay.animation.addByPrefix('idle', 'freeplay unselected', 24, false);
		freeplay.animation.addByPrefix('select', 'freeplay selected', 24, false);
		//freeplay.setGraphicSize(Std.int(freeplay.width / dasize));
		freeplay.updateHitbox();
		add(freeplay);
		freeplay.animation.play('idle');

		options = new FlxExtendedSprite(300, 120);
		options.frames = Paths.getSparrowAtlas('mainmenu/options');
		options.animation.addByPrefix('idle', 'options unselected', 24, false);
		options.animation.addByPrefix('select', 'options selected', 24, false);
		//options.setGraphicSize(Std.int(options.width / dasize));
		options.updateHitbox();
		add(options);
		options.animation.play('idle');

		scoreText = new FlxText(-600, -330, 0, "SCORE: 49324858", 36);
		scoreText.setFormat("VCR OSD Mono", 32);
		add(scoreText);

		//menuItems = new FlxTypedGroup<FlxSprite>();
		//add(menuItems);

		var scale:Float = 1.5;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		/*for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 60;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140)  + offset);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " unselected", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " selected", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			//menuItem.screenCenter(X);
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, 0);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
			
		}*/



		FlxG.camera.follow(camFollowPos, null, 1);

		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
		add(evilTrail);
		add(wiiCursor);
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	override function closeSubState() {
		changeItem();
		persistentUpdate = true;
		super.closeSubState();
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		FlxG.watch.addQuick("Mouse X", FlxG.mouse.x);
		FlxG.watch.addQuick("Mouse Y", FlxG.mouse.y);
		FlxG.watch.addQuick("Wii Cursor X", wiiCursor.x);
		FlxG.watch.addQuick("Wii Cursor Y", wiiCursor.y);

		wiiCursor.x = FlxG.mouse.x;
		wiiCursor.y = FlxG.mouse.y;

		var cToW = cursorOWidth * 1.3;
		var ctrl = FlxG.keys.justPressed.CONTROL;

		cursorSize += (cToW - cursorSize) / 3;
		wiiCursor.setGraphicSize(Std.int(cursorSize));

		if (tbutton.mouseOver)
		{
			changeItem(0, true, 0);
		}
		if (button1.mouseOver)
		{
			changeItem(0, true, 1);
		}
		if (button2.mouseOver)
		{
			changeItem(0, true, 2);
		}
		if (button3.mouseOver)
		{
			changeItem(0, true, 3);
		}
		if (button4.mouseOver)
		{
			changeItem(0, true, 4);
		}
		if (button5.mouseOver)
		{
			changeItem(0, true, 5);
		}
		if (freeplay.mouseOver)
		{
			changeItem(0, true, 6);
		}
		if (options.mouseOver)
		{
			changeItem(0, true, 7);
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 30, 0, 1)));
		if(Math.abs(intendedScore - lerpScore) < 10) lerpScore = intendedScore;
		if (weekName != '')
		{
			scoreText.alpha = 1;
			scoreText.text = "WEEK SCORE:" + lerpScore;
		}
		else
			scoreText.alpha = 0;
		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1, false);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1, false);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if(ctrl)
			{
				persistentUpdate = false;
				openSubState(new GameplayChangersSubstate());
			}

			if (controls.ACCEPT 
				|| tbutton.isPressed 
				|| button1.isPressed 
				|| button2.isPressed 
				|| button3.isPressed 
				|| button4.isPressed 
				|| button5.isPressed 
				|| freeplay.isPressed 
				|| options.isPressed)
			{
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					if (optionShit[curSelected] == 'tbutton')
					{
						if(ClientPrefs.flashing) FlxFlicker.flicker(tbutton, 1.1, 0.15, false);
						//tbutton.alpha = 0;
						button1.alpha = 0;
						button2.alpha = 0;
						button3.alpha = 0;
						button4.alpha = 0;
						button5.alpha = 0;
						freeplay.alpha = 0;
						options.alpha = 0;
					}
					if (optionShit[curSelected] == '1button')
					{
						if(ClientPrefs.flashing) FlxFlicker.flicker(button1, 1.1, 0.15, false);
						tbutton.alpha = 0;
						//button1.alpha = 0;
						button2.alpha = 0;
						button3.alpha = 0;
						button4.alpha = 0;
						button5.alpha = 0;
						freeplay.alpha = 0;
						options.alpha = 0;
					}
					if (optionShit[curSelected] == '2button')
					{
						if(ClientPrefs.flashing) FlxFlicker.flicker(button2, 1.1, 0.15, false);
						tbutton.alpha = 0;
						button1.alpha = 0;
						//button2.alpha = 0;
						button3.alpha = 0;
						button4.alpha = 0;
						button5.alpha = 0;
						freeplay.alpha = 0;
						options.alpha = 0;
					}
					if (optionShit[curSelected] == '3button')
					{
						if(ClientPrefs.flashing) FlxFlicker.flicker(button3, 1.1, 0.15, false);
						tbutton.alpha = 0;
						button1.alpha = 0;
						button2.alpha = 0;
						//button3.alpha = 0;
						button4.alpha = 0;
						button5.alpha = 0;
						freeplay.alpha = 0;
						options.alpha = 0;
					}
					if (optionShit[curSelected] == '4button')
					{
						if(ClientPrefs.flashing) FlxFlicker.flicker(button4, 1.1, 0.15, false);
						tbutton.alpha = 0;
						button1.alpha = 0;
						button2.alpha = 0;
						button3.alpha = 0;
						//button4.alpha = 0;
						button5.alpha = 0;
						freeplay.alpha = 0;
						options.alpha = 0;
					}
					if (optionShit[curSelected] == '5button')
					{
						if(ClientPrefs.flashing) FlxFlicker.flicker(button5, 1.1, 0.15, false);
						tbutton.alpha = 0;
						button1.alpha = 0;
						button2.alpha = 0;
						button3.alpha = 0;
						button4.alpha = 0;
						//button5.alpha = 0;
						freeplay.alpha = 0;
						options.alpha = 0;
					}
					if (optionShit[curSelected] == 'freeplay')
					{
						if(ClientPrefs.flashing) FlxFlicker.flicker(freeplay, 1.1, 0.15, false);
						tbutton.alpha = 0;
						button1.alpha = 0;
						button2.alpha = 0;
						button3.alpha = 0;
						button4.alpha = 0;
						button5.alpha = 0;
						//freeplay.alpha = 0;
						options.alpha = 0;
					}
					if (optionShit[curSelected] == 'options')
					{
						if(ClientPrefs.flashing) FlxFlicker.flicker(options, 1.1, 0.15, false);
						tbutton.alpha = 0;
						button1.alpha = 0;
						button2.alpha = 0;
						button3.alpha = 0;
						button4.alpha = 0;
						button5.alpha = 0;
						freeplay.alpha = 0;
						//options.alpha = 0;
					}

					FlxFlicker.flicker(magenta, 1, 0.06, false, false, function(flick:FlxFlicker)
					{
						var daChoice:String = optionShit[curSelected];

						switch (daChoice)
						{
							case 'tbutton':
								PlayState.SONG = Song.loadFromJson('practice-round', 'practice-round');
								PlayState.isStoryMode = true;
								PlayState.trueStory = true;
								PlayState.storyDifficulty = 0;
								PlayState.storyPlaylist = ['practice-round', 'bold-training', 'resort', 'final-exam'];
								PlayState.campaignScore = 0;
								trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
								LoadingsState.loadArt = 'tutorial';
								openSubState(new LoadingsState());
								FlxTransitionableState.skipNextTransIn = true;
								var toSwitchToState = new PlayState();
								LoadingState.loadAndSwitchState(toSwitchToState, true,true);
							case '1button':
								PlayState.SONG = Song.loadFromJson('light-it-up', 'light-it-up');
								PlayState.isStoryMode = true;
								PlayState.trueStory = true;
								PlayState.storyDifficulty = 0;
								PlayState.storyPlaylist = ['light-it-up', 'ruckus', 'target-practice'];
								PlayState.campaignScore = 0;
								trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
								LoadingsState.loadArt = 'week1';
								openSubState(new LoadingsState());
								FlxTransitionableState.skipNextTransIn = true;
								var toSwitchToState = new PlayState();
								LoadingState.loadAndSwitchState(toSwitchToState, true,true);
							case '2button':
								PlayState.SONG = Song.loadFromJson('sporting', 'sporting');
								PlayState.isStoryMode = true;
								PlayState.trueStory = true;
								PlayState.storyDifficulty = 0;
								PlayState.storyPlaylist = ['sporting', 'boxing-match'];
								PlayState.campaignScore = 0;
								trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
								LoadingsState.loadArt = 'week2';
								openSubState(new LoadingsState());
								FlxTransitionableState.skipNextTransIn = true;
								var toSwitchToState = new PlayState();
								LoadingState.loadAndSwitchState(toSwitchToState, true,true);
							case '3button':
								PlayState.SONG = Song.loadFromJson('fisticuffs', 'fisticuffs');
								PlayState.isStoryMode = true;
								PlayState.trueStory = true;
								PlayState.storyDifficulty = 0;
								PlayState.storyPlaylist = ['fisticuffs', 'wind-up', 'deathmatch', 'king-hit'];
								PlayState.campaignScore = 0;
								trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
								LoadingsState.loadArt = 'week3';
								openSubState(new LoadingsState());
								FlxTransitionableState.skipNextTransIn = true;
								var toSwitchToState = new PlayState();
								LoadingState.loadAndSwitchState(toSwitchToState, true,true);
							case '4button':
								PlayState.SONG = Song.loadFromJson('opponent', 'opponent');
								PlayState.isStoryMode = true;
								PlayState.trueStory = true;
								PlayState.storyDifficulty = 0;
								PlayState.storyPlaylist = ['opponent', 'combat', 'conflict', 'endless-battle', 'forgiveness'];
								PlayState.campaignScore = 0;
								trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
								LoadingsState.loadArt = 'week4';
								openSubState(new LoadingsState());
								FlxTransitionableState.skipNextTransIn = true;
								var toSwitchToState = new PlayState();
								LoadingState.loadAndSwitchState(toSwitchToState, true,true);
							case '5button':
								PlayState.SONG = Song.loadFromJson('rivalry', 'rivalry');
								PlayState.isStoryMode = true;
								PlayState.trueStory = true;
								PlayState.storyDifficulty = 0;
								PlayState.storyPlaylist = ['rivalry', 'parry', 'starlight', 'swordsman'];
								PlayState.campaignScore = 0;
								trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
								LoadingsState.loadArt = 'week5';
								openSubState(new LoadingsState());
								FlxTransitionableState.skipNextTransIn = true;
								var toSwitchToState = new PlayState();
								LoadingState.loadAndSwitchState(toSwitchToState, true,true);
							case 'freeplay':
								openSubState(new LoadingsState());
								FlxTransitionableState.skipNextTransIn = true;
								var toSwitchToState = new FreeplayState();
								LoadingState.loadAndSwitchState(toSwitchToState, true,true);
							case 'options':
								LoadingState.loadAndSwitchState(new options.OptionsState());
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0, ?overrideit:Bool = true, ?huhuh:Int = 0)
	{
		curSelected += huh;

		if (!overrideit)
		{
			if (curSelected >= optionShit.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = optionShit.length - 1;
			FlxG.mouse.visible = false;
			FlxG.mouse.enabled = false;
		}

		if (overrideit)
		{
			curSelected = huhuh;
			FlxG.mouse.enabled = true;
		}

		if (optionShit[curSelected] == 'tbutton')
		{
			tbutton.animation.play('selected', true);
			tbutton.alpha = 1;
			tart.alpha = 1;
			weekName = 'tutorialMatt';
		}
		else
		{
			tbutton.animation.play('idle', true);
			tbutton.alpha = 0.5;
			tart.alpha = 0;
		}
		if (optionShit[curSelected] == '1button')
		{
			button1.animation.play('selected', true);
			button1.alpha = 1;
			art1.alpha = 1;
			weekName = 'Week1Matt';
		}
		else
		{
			button1.animation.play('idle', true);
			button1.alpha = 0.5;
			art1.alpha = 0;
		}
		if (optionShit[curSelected] == '2button')
		{
			button2.animation.play('selected', true);
			button2.alpha = 1;
			art2.alpha = 1;
			weekName = 'Week2Matt';
		}
		else
		{
			button2.animation.play('idle', true);
			button2.alpha = 0.5;
			art2.alpha = 0;
		}
		if (optionShit[curSelected] == '3button')
		{
			button3.animation.play('selected', true);
			button3.alpha = 1;
			art3.alpha = 1;
			weekName = 'Week3Matt';
		}
		else
		{
			button3.animation.play('idle', true);
			button3.alpha = 0.5;
			art3.alpha = 0;
		}
		if (optionShit[curSelected] == '4button')
		{
			button4.animation.play('selected', true);
			button4.alpha = 1;
			art4.alpha = 1;
			weekName = 'Week4Matt';
		}
		else
		{
			button4.animation.play('idle', true);
			button4.alpha = 0.5;
			art4.alpha = 0;
		}
		if (optionShit[curSelected] == '5button')
		{
			button5.animation.play('selected', true);
			button5.alpha = 1;
			art5.alpha = 1;
			weekName = 'Week5Matt';
		}
		else
		{
			button5.animation.play('idle', true);
			button5.alpha = 0.5;
			art5.alpha = 0;
		}
		if (optionShit[curSelected] == 'freeplay')
		{
			freeplay.animation.play('selected', true);
			freeplay.alpha = 1;
			artother.alpha = 1;
			weekName = '';
		}
		else
		{
			freeplay.animation.play('idle', true);
			freeplay.alpha = 0.5;
			artother.alpha = 0;
		}
		if (optionShit[curSelected] == 'options')
		{
			options.animation.play('selected', true);
			options.alpha = 1;
			weekName = '';
		}
		else
		{
			options.animation.play('idle', true);
			options.alpha = 0.5;
		}
		#if !switch
			intendedScore = Highscore.getWeekScore(weekName, 1);
		#end
	}
}
