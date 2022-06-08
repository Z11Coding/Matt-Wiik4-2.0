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

	var tbutton:FlxSprite;
	var button1:FlxSprite;
	var button2:FlxSprite;
	var button3:FlxSprite;
	var button4:FlxSprite;
	var button5:FlxSprite;
	var freeplay:FlxSprite;
	var options:FlxSprite;

	override function create()
	{
		WeekData.loadTheFirstEnabledMod();

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

		tart = new FlxSprite(-70, -287).loadGraphic(Paths.image('mainmenu/tutorial'));
		tart.updateHitbox();
		tart.antialiasing = true;
		tart.alpha = 1;
		add(tart);

		art1 = new FlxSprite(-70, -287).loadGraphic(Paths.image('mainmenu/wiik1'));
		art1.updateHitbox();
		art1.antialiasing = true;
		art1.alpha = 0;
		add(art1);

		art2 = new FlxSprite(-70, -287).loadGraphic(Paths.image('mainmenu/wiik2'));
		art2.updateHitbox();
		art2.antialiasing = true;
		art2.alpha = 0;
		add(art2);

		art3 = new FlxSprite(-70, -287).loadGraphic(Paths.image('mainmenu/wiik3'));
		art3.updateHitbox();
		art3.antialiasing = true;
		art3.alpha = 0;
		add(art3);

		art4 = new FlxSprite(-70, -287).loadGraphic(Paths.image('mainmenu/wiik4'));
		art4.updateHitbox();
		art4.antialiasing = true;
		art4.alpha = 0;
		add(art4);

		art5 = new FlxSprite(-70, -287).loadGraphic(Paths.image('mainmenu/wiik5'));
		art5.updateHitbox();
		art5.antialiasing = true;
		art5.alpha = 0;
		add(art5);

		tbutton = new FlxSprite(-600, -300);
		tbutton.frames = Paths.getSparrowAtlas('mainmenu/tbutton');
		tbutton.animation.addByPrefix('idle', 'tbutton unselected', 24, false);
		tbutton.animation.addByPrefix('select', 'tbutton selected', 24, false);
		//tbutton.setGraphicSize(Std.int(tbutton.width / dasize));
		tbutton.updateHitbox();
		add(tbutton);
		tbutton.animation.play('idle');

		button1 = new FlxSprite(-600, -200);
		button1.frames = Paths.getSparrowAtlas('mainmenu/1button');
		button1.animation.addByPrefix('idle', '1button unselected', 24, false);
		button1.animation.addByPrefix('select', '1button selected', 24, false);
		//1button.setGraphicSize(Std.int(1button.width / dasize));
		button1.updateHitbox();
		add(button1);
		button1.animation.play('idle');

		button2 = new FlxSprite(-600, -100);
		button2.frames = Paths.getSparrowAtlas('mainmenu/2button');
		button2.animation.addByPrefix('idle', '2button unselected', 24, false);
		button2.animation.addByPrefix('select', '2button selected', 24, false);
		//2button.setGraphicSize(Std.int(2button.width / dasize));
		button2.updateHitbox();
		add(button2);
		button2.animation.play('idle');
		
		button3 = new FlxSprite(-600, 0);
		button3.frames = Paths.getSparrowAtlas('mainmenu/3button');
		button3.animation.addByPrefix('idle', '3button unselected', 24, false);
		button3.animation.addByPrefix('select', '3button selected', 24, false);
		//3button.setGraphicSize(Std.int(3button.width / dasize));
		button3.updateHitbox();
		add(button3);
		button3.animation.play('idle');

		button4 = new FlxSprite(-600, 100);
		button4.frames = Paths.getSparrowAtlas('mainmenu/4button');
		button4.animation.addByPrefix('idle', '4button unselected', 24, false);
		button4.animation.addByPrefix('select', '4button selected', 24, false);
		//4button.setGraphicSize(Std.int(4button.width / dasize));
		button4.updateHitbox();
		add(button4);
		button4.animation.play('idle');

		button5 = new FlxSprite(-600, 200);
		button5.frames = Paths.getSparrowAtlas('mainmenu/5button');
		button5.animation.addByPrefix('idle', '5button unselected', 24, false);
		button5.animation.addByPrefix('select', '5button selected', 24, false);
		//tbutton.setGraphicSize(Std.int(tbutton.width / dasize));
		button5.updateHitbox();
		add(button5);
		button5.animation.play('idle');

		freeplay = new FlxSprite(-50, 120);
		freeplay.frames = Paths.getSparrowAtlas('mainmenu/freeplay');
		freeplay.animation.addByPrefix('idle', 'freeplay unselected', 24, false);
		freeplay.animation.addByPrefix('select', 'freeplay selected', 24, false);
		//freeplay.setGraphicSize(Std.int(freeplay.width / dasize));
		freeplay.updateHitbox();
		add(freeplay);
		freeplay.animation.play('idle');

		options = new FlxSprite(300, 120);
		options.frames = Paths.getSparrowAtlas('mainmenu/options');
		options.animation.addByPrefix('idle', 'options unselected', 24, false);
		options.animation.addByPrefix('select', 'options selected', 24, false);
		//options.setGraphicSize(Std.int(options.width / dasize));
		options.updateHitbox();
		add(options);
		options.animation.play('idle');

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
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
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
					}
					if (optionShit[curSelected] == '1button')
					{
						if(ClientPrefs.flashing) FlxFlicker.flicker(button1, 1.1, 0.15, false);
					}
					if (optionShit[curSelected] == '2button')
					{
						if(ClientPrefs.flashing) FlxFlicker.flicker(button2, 1.1, 0.15, false);
					}
					if (optionShit[curSelected] == '3button')
					{
						if(ClientPrefs.flashing) FlxFlicker.flicker(button3, 1.1, 0.15, false);
					}
					if (optionShit[curSelected] == '4button')
					{
						if(ClientPrefs.flashing) FlxFlicker.flicker(button4, 1.1, 0.15, false);
					}
					if (optionShit[curSelected] == '5button')
					{
						if(ClientPrefs.flashing) FlxFlicker.flicker(button5, 1.1, 0.15, false);
					}
					if (optionShit[curSelected] == 'freeplay')
					{
						if(ClientPrefs.flashing) FlxFlicker.flicker(freeplay, 1.1, 0.15, false);
					}
					if (optionShit[curSelected] == 'options')
					{
						if(ClientPrefs.flashing) FlxFlicker.flicker(options, 1.1, 0.15, false);
					}

					FlxFlicker.flicker(magenta, 1, 0.06, false, false, function(flick:FlxFlicker)
					{
						var daChoice:String = optionShit[curSelected];

						switch (daChoice)
						{
							case 'tbutton':
								PlayState.SONG = Song.loadFromJson('practice-round', 'practice-round');
								PlayState.isStoryMode = true;
								PlayState.storyDifficulty = 1;
								PlayState.storyPlaylist = ['practice-round', 'bold-training', 'resort', 'final-exam'];
								PlayState.campaignScore = 0;
								trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
								LoadingState.loadAndSwitchState(new PlayState(), true);
							case '1button':
								PlayState.SONG = Song.loadFromJson('light-it-up', 'light-it-up');
								PlayState.isStoryMode = true;
								PlayState.storyDifficulty = 1;
								PlayState.storyPlaylist = ['light-it-up', 'ruckus', 'target-practice'];
								PlayState.campaignScore = 0;
								trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
								LoadingState.loadAndSwitchState(new PlayState(), true);
							case '2button':
								PlayState.SONG = Song.loadFromJson('sporting', 'sporting');
								PlayState.isStoryMode = true;
								PlayState.storyDifficulty = 1;
								PlayState.storyPlaylist = ['sporting', 'boxing-match'];
								PlayState.campaignScore = 0;
								trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
								LoadingState.loadAndSwitchState(new PlayState(), true);
							case '3button':
								PlayState.SONG = Song.loadFromJson('fisticuffs', 'fisticuffs');
								PlayState.isStoryMode = true;
								PlayState.storyDifficulty = 1;
								PlayState.storyPlaylist = ['fisticuffs', 'wind-up', 'deathmatch', 'king-hit'];
								PlayState.campaignScore = 0;
								trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
								LoadingState.loadAndSwitchState(new PlayState(), true);
							case '4button':
								PlayState.SONG = Song.loadFromJson('war-of-honour', 'war-of-honour');
								PlayState.isStoryMode = true;
								PlayState.storyDifficulty = 1;
								PlayState.storyPlaylist = ['war-of-honour', 'opponent', 'combat', 'endless-battle', 'forgiveness'];
								PlayState.campaignScore = 0;
								trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
								LoadingState.loadAndSwitchState(new PlayState(), true);
							case '5button':
								PlayState.SONG = Song.loadFromJson('fencing', 'fencing');
								PlayState.isStoryMode = true;
								PlayState.storyDifficulty = 1;
								PlayState.storyPlaylist = ['fencing', 'parry', 'sword-up', 'strike'];
								PlayState.campaignScore = 0;
								trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
								LoadingState.loadAndSwitchState(new PlayState(), true);
							case 'freeplay':
								MusicBeatState.switchState(new FreeplayState());
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

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= optionShit.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = optionShit.length - 1;

		if (optionShit[curSelected] == 'tbutton')
		{
			tbutton.animation.play('selected', true);
			tbutton.alpha = 1;
			tart.alpha = 1;
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
		}
		else
		{
			freeplay.animation.play('idle', true);
			freeplay.alpha = 0.5;
		}
		if (optionShit[curSelected] == 'options')
		{
			options.animation.play('selected', true);
			options.alpha = 1;
		}
		else
		{
			options.animation.play('idle', true);
			options.alpha = 0.5;
		}
	}
}
