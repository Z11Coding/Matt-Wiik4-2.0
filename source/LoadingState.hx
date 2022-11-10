package;

import lime.app.Promise;
import lime.app.Future;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;
import flixel.math.FlxMath;

import openfl.utils.Assets;
import lime.utils.Assets as LimeAssets;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import flixel.addons.transition.FlxTransitionableState;
import flixel.util.FlxColor;

import flixel.ui.FlxBar;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

import haxe.io.Path;

using StringTools;

class LoadingsState extends MusicBeatSubstate
{
	public var instantAlpha:Bool = false;
	var loadingart:FlxSprite;
	public static var blackscreen:FlxSprite;
	public static var loadingBarBG:FlxSprite;
	public static var loadingBar:FlxBar;
	public static var funniescreen:Bool = false;
	var barProgression:Float = 0;
	var animloadingart:FlxSprite;
	public static var loadArt:String;
	var daArt:String = null;
	var bg:FlxTypedSpriteGroup<FlxSprite> = new FlxTypedSpriteGroup<FlxSprite>();
	var w = 775;
	var h = 550;	
	override function create()
	{
		FlxG.camera.zoom = 0;
		blackscreen = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
		blackscreen.updateHitbox();
		blackscreen.screenCenter();
		blackscreen.antialiasing = true;
		blackscreen.scrollFactor.set(0, 0);
		blackscreen.alpha = 0.1;
		blackscreen.setGraphicSize(Std.int(blackscreen.width * 10.5));
		blackscreen.color = FlxColor.BLACK;
		add(blackscreen);

		switch (loadArt)
		{
			case 'tutorial':
				daArt = '0';
			case 'week1':
				daArt = '1';
			case 'week2':
				daArt = '2';
			case 'week3':
				daArt = '3';
			case 'week4':
				daArt = '4';
			case 'week5':
				daArt = '5';
			case 'headlock':
				daArt = 'headlock';
			default:
				daArt = null;
		}

		if (daArt != null)
			loadingart = new FlxSprite(0, 0).loadGraphic(Paths.image('loading/' + daArt));
		else
			loadingart = new FlxSprite(0, 0).loadGraphic(Paths.image('loading/' + FlxG.random.int(0, 12) + 'a'));
		//loadingart.setGraphicSize(-1, FlxG.height);
		loadingart.updateHitbox();
		loadingart.alpha = 0.1;
		loadingart.scrollFactor.set(0, 0);
		loadingart.screenCenter();
		loadingart.antialiasing = true;
		add(loadingart);

		var loading = new FlxSprite().loadGraphic(Paths.image("loading/loading"));
        loading.scale.set(0.85, 0.85);
        loading.updateHitbox();
        loading.y = FlxG.height - (loading.height * 1.15);
        loading.screenCenter(X);
        loading.antialiasing = true;
        add(loading);
		trace('IT LOADING!');

		var blackBar = new FlxSprite(0, 573).loadGraphic(Paths.image('loading/extra/blackbar'));
		blackBar.antialiasing = true;
		add(blackBar);

		var tipPrefix:String = 'funFact';
		var tipMax:Int = 1;
		
		if (FlxG.random.bool(50)) {
			tipPrefix = 'proTip';
			tipMax = 2;
		}

		var tip:FlxSprite = new FlxSprite(0, 590).loadGraphic(Paths.image('loading/extra/' + tipPrefix + '/' + FlxG.random.int(1, tipMax)));
		tip.screenCenter(XY);
		tip.y += 299;
		add(tip);
		tip.antialiasing = true;


		var theText:FlxSprite = new FlxSprite(0, 549).loadGraphic(Paths.image('loading/extra/' + tipPrefix + '/text'));
		add(theText);
		theText.screenCenter(X);
		theText.antialiasing = true;

		var bar:FlxSprite = new FlxSprite(0, 597).loadGraphic(Paths.image('loading/extra/bar'));
		bar.screenCenter(X);
		add(bar);
		bar.antialiasing = true;
		loadingBarBG = new FlxSprite(0, 597).loadGraphic(Paths.image('loading/extra/bar'));
        loadingBarBG.screenCenter(X);
        loadingBarBG.setGraphicSize(Std.int(loadingBarBG.width * 1.2));
        add(loadingBarBG);

		//trace('bruj 5');
        loadingBar = new FlxBar(loadingBarBG.x + 4, loadingBarBG.y + 4, LEFT_TO_RIGHT, Std.int(loadingBarBG.width - 8), Std.int(loadingBarBG.height - 8), this,
            'barProgression', 0, 1);
        loadingBar.numDivisions = 100;
        loadingBar.createFilledBar(FlxColor.ORANGE, FlxColor.PURPLE);
        add(loadingBar);
		super.create();
	}

	var t:Float = 0;
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		loadingart.alpha += elapsed;
		blackscreen.alpha += elapsed;
		if (instantAlpha)
		{
			blackscreen.alpha = 1;
			loadingart.alpha = 1;
		}
		barProgression = LoadingState.barProgression;
	}

}
class LoadingState extends MusicBeatState
{
	inline static var MIN_TIME = 1.0;
	
	var target:FlxState;
	var stopMusic = false;
	var callbacks:MultiCallback;
	var targetShit:Float = 0;
	
	var logo:FlxSprite;
	var gfDance:FlxSprite;
	var danceLeft = false;
	public static var barProgression:Float = 0;
	//Thinking....
	
	function new(target:FlxState, stopMusic:Bool)
	{
		super();
		this.target = target;
		this.stopMusic = stopMusic;
	}


	
	override function create()
	{	
		initSongsManifest().onComplete
		(
			function (lib)
			{
				callbacks = new MultiCallback(onLoad);
				var introComplete = callbacks.add("introComplete");
				checkLoadSong(getSongPath());
				if (PlayState.SONG.needsVoices)
					checkLoadSong(getVocalPath());
				checkLibrary("shared");
				if (PlayState.storyWeek > 0)
					checkLibrary("week" + PlayState.storyWeek);
				else
					checkLibrary("images");
				
				var fadeTime = 1.5;
				FlxG.camera.fade(FlxG.camera.bgColor, fadeTime, true);
				new FlxTimer().start(fadeTime + MIN_TIME, function(_) introComplete());
			}
		);
		super.create();
	}
	
	function checkLoadSong(path:String)
	{
		if (!Assets.cache.hasSound(path))
		{
			var library = Assets.getLibrary("songs");
			final symbolPath = path.split(":").pop();
			// @:privateAccess
			// library.types.set(symbolPath, SOUND);
			// @:privateAccess
			// library.pathGroups.set(symbolPath, [library.__cacheBreak(symbolPath)]);
			var callback = callbacks.add("song:" + path);
			Assets.loadSound(path).onComplete(function (_) { callback(); });
		}
	}
	
	function checkLibrary(library:String)
	{
		trace(Assets.hasLibrary(library));
		if (Assets.getLibrary(library) == null)
		{
			@:privateAccess
			if (!LimeAssets.libraryPaths.exists(library))
				throw "Missing library: " + library;
			
			var callback = callbacks.add("library:" + library);
			Assets.loadLibrary(library).onComplete(function (_) { callback(); });
		}
	}
	
	override function beatHit()
	{
		super.beatHit();
		
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		#if debug
		if (FlxG.keys.justPressed.SPACE)
			trace('fired: ' + callbacks.getFired() + " unfired:" + callbacks.getUnfired());
		#end
		if(callbacks != null) {
			targetShit = FlxMath.remapToRange(callbacks.numRemaining / callbacks.length, 1, 0, 0, 1);
			barProgression = 0.5 * targetShit;
		}
	}
	
	function onLoad()
	{
		if (stopMusic && FlxG.sound.music != null)
			FlxG.sound.music.stop();
		
		FlxG.switchState(target);
	}
	
	static function getSongPath()
	{
		return Paths.inst(PlayState.SONG.song);
	}
	
	static function getVocalPath()
	{
		return Paths.voices(PlayState.SONG.song);
	}
	
	inline static public function loadAndSwitchState(target:FlxState, stopMusic = false, ?waitForLoad:Bool = false)
	{
		var waitTime = 0.0;
		if (waitForLoad)
		{
			FlxG.sound.music.fadeOut(1, 0);
			waitTime = 1.6;
		}

		FlxTransitionableState.skipNextTransIn = true;
		new FlxTimer().start(waitTime, function(tmr:FlxTimer) {
			MusicBeatState.switchState(getNextState(target, stopMusic));
			LoadingsState.loadArt = null;
		});
		
	}
	
	static function getNextState(target:FlxState, stopMusic = false):FlxState
	{
		Paths.setCurrentLevel("week" + PlayState.storyWeek);
		#if NO_PRELOAD_ALL
		var loaded = isSoundLoaded(getSongPath())
			&& (!PlayState.SONG.needsVoices || isSoundLoaded(getVocalPath()))
			&& isLibraryLoaded("images");
		
		if (!loaded)
			return new LoadingState(target, stopMusic);
		#end
		if (stopMusic && FlxG.sound.music != null)
			FlxG.sound.music.stop();
		
		return target;
	}
	
	#if NO_PRELOAD_ALL
	static function isSoundLoaded(path:String):Bool
	{
		return Assets.cache.hasSound(path);
	}
	
	static function isLibraryLoaded(library:String):Bool
	{
		return Assets.getLibrary(library) != null;
	}
	#end
	
	override function destroy()
	{
		super.destroy();
		
		callbacks = null;
	}
	
	static function initSongsManifest()
	{
		var id = "songs";
		var promise = new Promise<AssetLibrary>();

		var library = LimeAssets.getLibrary(id);

		if (library != null)
		{
			return Future.withValue(library);
		}

		var path = id;
		var rootPath = null;

		@:privateAccess
		var libraryPaths = LimeAssets.libraryPaths;
		if (libraryPaths.exists(id))
		{
			path = libraryPaths[id];
			rootPath = Path.directory(path);
		}
		else
		{
			if (StringTools.endsWith(path, ".bundle"))
			{
				rootPath = path;
				path += "/library.json";
			}
			else
			{
				rootPath = Path.directory(path);
			}
			@:privateAccess
			path = LimeAssets.__cacheBreak(path);
		}

		AssetManifest.loadFromFile(path, rootPath).onComplete(function(manifest)
		{
			if (manifest == null)
			{
				promise.error("Cannot parse asset manifest for library \"" + id + "\"");
				return;
			}

			var library = AssetLibrary.fromManifest(manifest);

			if (library == null)
			{
				promise.error("Cannot open library \"" + id + "\"");
			}
			else
			{
				@:privateAccess
				LimeAssets.libraries.set(id, library);
				library.onChange.add(LimeAssets.onChange.dispatch);
				promise.completeWith(Future.withValue(library));
			}
		}).onError(function(_)
		{
			promise.error("There is no asset library with an ID of \"" + id + "\"");
		});

		return promise.future;
	}
}

class MultiCallback
{
	public var callback:Void->Void;
	public var logId:String = null;
	public var length(default, null) = 0;
	public var numRemaining(default, null) = 0;
	
	var unfired = new Map<String, Void->Void>();
	var fired = new Array<String>();
	
	public function new (callback:Void->Void, logId:String = null)
	{
		this.callback = callback;
		this.logId = logId;
	}
	
	public function add(id = "untitled")
	{
		id = '$length:$id';
		length++;
		numRemaining++;
		var func:Void->Void = null;
		func = function ()
		{
			if (unfired.exists(id))
			{
				unfired.remove(id);
				fired.push(id);
				numRemaining--;
				
				if (logId != null)
					log('fired $id, $numRemaining remaining');
				
				if (numRemaining == 0)
				{
					if (logId != null)
						log('all callbacks fired');
					callback();
				}
			}
			else
				log('already fired $id');
		}
		unfired[id] = func;
		return func;
	}
	
	inline function log(msg):Void
	{
		if (logId != null)
			trace('$logId: $msg');
	}
	
	public function getFired() return fired.copy();
	public function getUnfired() return [for (id in unfired.keys()) id];
}