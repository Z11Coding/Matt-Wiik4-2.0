package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxExtendedSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.addons.plugin.FlxMouseControl;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import openfl.utils.AssetType;
import openfl.utils.Assets;
#if sys
import sys.io.File;
import sys.FileSystem;
#end
using StringTools;

class StrumNote extends FlxExtendedSprite
{
	private var colorSwap:ColorSwap;
	public var resetAnim:Float = 0;
	public var noteData:Int = 0;
	public var openNoteData:Int = 0;
	public var direction:Float = 90;//plan on doing scroll directions soon -bb
	public var downScroll:Bool = false;//plan on doing scroll directions soon -bb

	public var player:Int;
	public static var players:Int;
	public var doAntialiasing:Bool = ClientPrefs.globalAntialiasing;
	public var sustainReduce:Bool = true;

	private var skinThing:Array<String> = ['static', 'pressed'];

	public var noteSkin:String = 'normal';
	
	public var texture(default, set):String = null;
	private function set_texture(value:String):String {
		if(texture != value) {
			texture = value;
			reloadNote();
		}
		return value;
	}

	public function new(x:Float, y:Float, leData:Int, player:Int, ?opendata:Int = 0, char:String = 'bf', ?inEditor:Bool = false) {
		FlxG.plugins.add(new FlxMouseControl());

		colorSwap = new ColorSwap();
		shader = colorSwap.shader;
		noteData = leData;
		openNoteData = opendata;
		this.player = player;
		this.noteData = leData;
		super(x, y);

		players = player;

		var stat:String =Note.keysShit.get(PlayState.mania).get('strumAnims')[leData];
		var pres:String = Note.keysShit.get(PlayState.mania).get('letters')[leData];
		skinThing[0] = stat;
		skinThing[1] = pres;
		var skin:String;
		skin = 'noteskins/normal';

		doAntialiasing = ClientPrefs.globalAntialiasing;
		
		//if(PlayState.SONG.arrowSkin != null && PlayState.SONG.arrowSkin.length > 1) skin = PlayState.SONG.arrowSkin;
		if (Note.ammo[PlayState.mania] < 9)
		{
			switch(char)
			{
				case 'bf' | 'bf-alt' | 'bf-alt-god' | 'bfCool' | 'bfCooler' | 'bf-dark' | 'bf-dark' | 'bf-ebola' | 'bf-god' | 'bflol' | 'bfmii' | 'bf-qt' | 'bf-reanimated' | 'bf-speaker':
					skin = 'noteskins/bf';
				case '':
					skin = 'noteskins/normal';
				case null:
					skin = 'noteskins/normal';
				default:
					skin = 'noteskins/normal';
			}
		}
		else
		{
			skin = 'noteskins/normal';
		}
		if (inEditor)
		{
			skin = 'noteskins/normal'; 
		}
		texture = skin; //Load texture and anims

		scrollFactor.set();
	}

	public function reloadNote()
	{
		var lastAnim:String = null;
		if(animation.curAnim != null) lastAnim = animation.curAnim.name;

		if(PlayState.isPixelStage)
			{
				loadGraphic(Paths.image('pixelUI/' + texture));
				width = width / 18;
				height = height / 5;
				antialiasing = false;
				loadGraphic(Paths.image('pixelUI/' + texture), true, Math.floor(width), Math.floor(height));
				var daFrames:Array<Int> = Note.keysShit.get(PlayState.mania).get('pixelAnimIndex');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom * Note.pixelScales[PlayState.mania]));
				updateHitbox();
				antialiasing = false;
				animation.add('static', [daFrames[noteData]]);
				animation.add('pressed', [daFrames[noteData] + 18, daFrames[noteData] + 36], 12, false);
				animation.add('confirm', [daFrames[noteData] + 54, daFrames[noteData] + 72], 24, false);
				//i used calculator
			}
		else
			{
				frames = Paths.getSparrowAtlas(texture);

				antialiasing = ClientPrefs.globalAntialiasing;

				setGraphicSize(Std.int(width * Note.scales[PlayState.mania]));
		
				animation.addByPrefix('static', 'arrow' + skinThing[0]);
				animation.addByPrefix('pressed', skinThing[1] + ' press', 24, false);
				animation.addByPrefix('confirm', skinThing[1] + ' confirm', 24, false);
			}

		updateHitbox();

		if(lastAnim != null)
		{
			playAnim(lastAnim, true);
		}
	}

	public function postAddedToGroup() {
		playAnim('static');
		switch (PlayState.mania)
		{
			case 0 | 1 | 2: x += width * noteData;
			case 3: x += (Note.swagWidth * noteData);
			default: x += ((width - Note.lessX[PlayState.mania]) * noteData);
		}

		x += Note.xtra[PlayState.mania];
	
		x += 50;
		x += ((FlxG.width / 2) * player);
		ID = noteData;
		x -= Note.posRest[PlayState.mania];
	}

	override function update(elapsed:Float) {
		if(resetAnim > 0) {
			resetAnim -= elapsed;
			if(resetAnim <= 0) {
				playAnim('static');
				resetAnim = 0;
			}
		}
		if(animation.curAnim != null){ //my bad i was upset
			if(animation.curAnim.name == 'confirm' && !PlayState.isPixelStage) {
				centerOrigin();
			}
		}

		super.update(elapsed);
	}

	public function playAnim(anim:String, ?force:Bool = false) {
		animation.play(anim, force);
		centerOffsets();
		centerOrigin();
		if(animation.curAnim == null || animation.curAnim.name == 'static') {
			colorSwap.hue = 0;
			colorSwap.saturation = 0;
			colorSwap.brightness = 0;
		} else {
			if (noteData > -1 && noteData < ClientPrefs.arrowHSV.length)
			{
				/*colorSwap.hue = ClientPrefs.arrowHSV[Std.int(Note.keysShit.get(PlayState.mania).get('pixelAnimIndex')[noteData] % Note.ammo[PlayState.mania])][0] / 360;
				colorSwap.saturation = ClientPrefs.arrowHSV[Std.int(Note.keysShit.get(PlayState.mania).get('pixelAnimIndex')[noteData] % Note.ammo[PlayState.mania])][1] / 100;
				colorSwap.brightness = ClientPrefs.arrowHSV[Std.int(Note.keysShit.get(PlayState.mania).get('pixelAnimIndex')[noteData] % Note.ammo[PlayState.mania])][2] / 100;*/
			}

			if(animation.curAnim.name == 'confirm' && !PlayState.isPixelStage) {
				centerOrigin();
			}
		}
	}
}
