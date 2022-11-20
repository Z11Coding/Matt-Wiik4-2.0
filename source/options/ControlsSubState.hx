package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class ControlsSubState extends MusicBeatSubstate {
	private static var curSelected:Int = 1;
	private static var curAlt:Bool = false;

	private static var defaultKey:String = 'Reset to Default Keys';
	private var bindLength:Int = 0;

	var optionShit:Array<Dynamic> = [
		['1 KEY'],
		['Center', 'note_one1'],
		[''],
		['2 KEYS'],
		['Left',  'note_two1'],
		['Right', 'note_two2'],
		[''],
		['3 KEYS'],
		['Left',   'note_three1'],
		['Center', 'note_three2'],
		['Right',  'note_three3'],
		[''],
		['4 KEYS'],
		['Left',  'note_left'],
		['Down',  'note_down'],
		['Up', 	  'note_up'],
		['Right', 'note_right'],
		[''],
		['5 KEYS'],
		['Left', 	'note_five1'],
		['Down', 	'note_five2'],
		['Center',  'note_five3'],
		['Up', 	  	'note_five4'],
		['Right', 	'note_five5'],
		[''],
		['6 KEYS'],
		['Left 1', 	'note_six1'],
		['Up', 		'note_six2'],
		['Right 1', 'note_six3'],
		['Left 2', 	'note_six4'],
		['Down', 	'note_six5'],
		['Right 2', 'note_six6'],
		[''],
		['7 KEYS'],
		['Left 1',  'note_seven1'],
		['Up', 		'note_seven2'],
		['Right 1', 'note_seven3'],
		['Center',  'note_seven4'],
		['Left 2',  'note_seven5'],
		['Down', 	'note_seven6'],
		['Right 2', 'note_seven7'],
		[''],
		['8 KEYS'],
		['Left 1',  'note_eight1'],
		['Down 1',  'note_eight2'],
		['Up 1', 	'note_eight3'],
		['Right 1', 'note_eight4'],
		['Left 2',  'note_eight5'],
		['Down 2',  'note_eight6'],
		['Up 2', 	'note_eight7'],
		['Right 2', 'note_eight8'],
		[''],
		['9 KEYS'],
		['Left 1',  'note_nine1'],
		['Down 1',  'note_nine2'],
		['Up 1',    'note_nine3'],
		['Right 1', 'note_nine4'],
		['Center',  'note_nine5'],
		['Left 2',  'note_nine6'],
		['Down 2',  'note_nine7'],
		['Up 2',    'note_nine8'],
		['Right 2', 'note_nine9'],
		[''],
		['Try to figure out these ones.'],
		[''],
		['10 KEYS'],
		['Left 1',  'note_ten1'],
		['Down 1',  'note_ten2'],
		['Up 1', 	'note_ten3'],
		['Right 1', 'note_ten4'],
		['Center 1','note_ten5'],
		['Center 2','note_ten6'],
		['Left 2',  'note_ten7'],
		['Down 2',  'note_ten8'],
		['Up 2', 	'note_ten9'],
		['Right 2', 'note_ten10'],
		['11 KEYS'],
		['Left 1',  'note_elev1'],
		['Down 1',  'note_elev2'],
		['Up 1',    'note_elev3'],
		['Right 1', 'note_elev4'],
		['Down 3',  'note_elev5'],
		['Center',  'note_elev6'],
		['Up 3', 	'note_elev7'],
		['Left 2',  'note_elev8'],
		['Down 2',  'note_elev9'],
		['Up 2', 	'note_elev10'],
		['Right 2', 'note_elev11'],
		[''],
		['UI'],
		['Left', 'ui_left'],
		['Down', 'ui_down'],
		['Up', 	 'ui_up'],
		['Right','ui_right'],
		[''],
		['Reset',  'reset'],
		['Accept', 'accept'],
		['Back',   'back'],
		['Pause',  'pause'],
		[''],
		['VOLUME'],
		['Mute', 'volume_mute'],
		['Up', 	 'volume_up'],
		['Down', 'volume_down'],
		[''],
		['DEBUG'],
		['Key 1', 'debug_1'],
		['Key 2', 'debug_2'],
		[''],
		['Have Fun Figureing This Out Lol'],
		[''],
		['12 KEYS'],
		['Left 1', 	'note_twel1'],
		['Down 1', 	'note_twel2'],
		['Up 1', 	'note_twel3'],
		['Right 1', 'note_twel4'],
		['Left 2', 	'note_twel5'],
		['Down 2', 	'note_twel6'],
		['Up 2', 	'note_twel7'],
		['Right 2', 'note_twel8'],
		['Left 3', 	'note_twel9'],
		['Down 3', 	'note_twel10'],
		['Up 3', 	'note_twel11'],
		['Right 3', 'note_twel12'],
		[''],
		['14 KEYS'],
		['Left 1', 	'note_fort1'],
		['Down 1', 	'note_fort2'],
		['Up 1', 	'note_fort3'],
		['Right 1', 'note_fort4'],
		['Center 1','note_fort5'],
		['Left 2',  'note_fort6'],
		['Down 2',  'note_fort7'],
		['Up 2', 	'note_fort8'],
		['Right 2', 'note_fort9'],
		['Center 2','note_fort10'],
		['Left 3', 	'note_fort11'],
		['Down 3', 	'note_fort12'],
		['Up 3', 	'note_fort13'],
		['Right 3', 	'note_fort14'],
		[''],
		['18 KEYS'],
		['Left 1', 	'note_ate1'],
		['Down 1', 	'note_ate2'],
		['Up 1',   	'note_ate3'],
		['Right 1',	'note_ate4'],
		['Left 2', 	'note_ate5'],
		['Down 2', 	'note_ate6'],
		['Up 2',   	'note_ate7'],
		['Right 2',	'note_ate8'],
		['Space 1',	'note_ate9'],
		['Space 2',	'note_ate10'],
		['Left 3', 	'note_ate11'],
		['Down 3', 	'note_ate12'],
		['Up 3', 	'note_ate13'],
		['Right 3', 'note_ate14'],
		['Left 4', 	'note_ate15'],
		['Down 4', 	'note_ate16'],
		['Up 4', 	'note_ate17'],
		['Right 4', 'note_ate18'],
	];

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var grpInputs:Array<AttachedText> = [];
	private var grpInputsAlt:Array<AttachedText> = [];
	var rebindingKey:Bool = false;
	var nextAccept:Int = 5;

	var pages:Array<Dynamic> = [];
	var curPage:Int = 0;

	public function new() {
		super();

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.color = 0xFFea71fd;
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		var currentPage:String = "";
		var generatedPage:Dynamic = [];
		for (i in 0...optionShit.length) {
			if (optionShit[i][0] != "" && optionShit[i].length < 2 && currentPage == "") { //It's the first page title
				generatedPage.push(optionShit[i]);
				currentPage = optionShit[i][0];
			} else if (optionShit[i][0] != "" && optionShit[i].length < 2 && currentPage != "") { // It's a new page title.
				generatedPage.push(['']);
				generatedPage.push([defaultKey]);
				pages.push(generatedPage);

				generatedPage = [];

				generatedPage.push(optionShit[i]);
				currentPage = optionShit[i][0];
			} else if (optionShit[i].length > 1) { // It's an input
				generatedPage.push(optionShit[i]);
			} else if (optionShit[i][0] == "" && optionShit[i].length < 2) { // It's blank!
				generatedPage.push(optionShit[i]);
			}
		}

		optionShit = pages[curPage];
		reloadTexts();
		changeSelection();
	}

	function reloadTexts() {
		for (i in 0...grpOptions.members.length) {
			var obj = grpOptions.members[0];
			obj.kill();
			grpOptions.remove(obj, true);
			obj.destroy();
		}

		for (text in grpInputs) {
			text.kill();
			remove(text);
		}
		grpInputs = [];

		for (text in grpInputsAlt) {
			text.kill();
			remove(text);
		}
		grpInputsAlt = [];

		//trace(grpInputs.length, '\n' + grpInputsAlt.length);

		for (i in 0...optionShit.length) {
			var isCentered:Bool = false;
			var isDefaultKey:Bool = (optionShit[i][0] == defaultKey);
			if(unselectableCheck(i, true)) {
				isCentered = true;
			}

			var isFirst:Bool = i == 0;
			var text:String = optionShit[i][0];
			if (isFirst) text = '< ' + text + ' >';

			var optionText:Alphabet = new Alphabet(200, 300, text, (!isCentered || isDefaultKey));
			optionText.isMenuItem = true;
			if(isCentered) {
				optionText.screenCenter(X);
				optionText.y -= 55;
				optionText.startPosition.y -= 55;
			}
			optionText.changeX = false;
			optionText.distancePerItem.y = 60;
			optionText.targetY = i - curSelected;
			optionText.snapToPosition();
			optionText.ID = 0;
			if (isFirst) optionText.ID = 1;
			grpOptions.add(optionText);

			if(!isCentered) {
				addBindTexts(optionText, i);
				bindLength++;
				if(curSelected < 0) curSelected = i;
			}
		}
	}

	var leaving:Bool = false;
	var bindingTime:Float = 0;
	var holdTime:Float = 0;
	override function update(elapsed:Float) {
		if(!rebindingKey) {
			var shiftMult:Int = FlxG.keys.pressed.SHIFT ? 3 : 1;

			if(controls.UI_DOWN || controls.UI_UP)
			{
				var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
				holdTime += elapsed;
				var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

				if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
				{
					changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
				}
			}
			if (controls.UI_UP_P) {
				changeSelection(-shiftMult);
				holdTime = 0;
			}
			if (controls.UI_DOWN_P) {
				changeSelection(shiftMult);
				holdTime = 0;
			}
			if (controls.UI_LEFT_P || controls.UI_RIGHT_P) {
				if (grpOptions.members[curSelected].ID == 1) {
					changePage(controls.UI_LEFT_P ? -1 : 1);
				} else changeAlt();
			}

			if (controls.BACK) {
				ClientPrefs.reloadControls();
				close();
				FlxG.sound.play(Paths.sound('cancelMenu'));
			}

			if(controls.ACCEPT && nextAccept <= 0) {
				if(optionShit[curSelected][0] == defaultKey) {
					ClientPrefs.keyBinds = ClientPrefs.defaultKeys.copy();
					reloadKeys();
					reloadTexts();
					changeSelection();
					FlxG.sound.play(Paths.sound('confirmMenu'));
				} else if(!unselectableCheck(curSelected)) {
					bindingTime = 0;
					rebindingKey = true;
					if (curAlt) {
						grpInputsAlt[getInputTextNum()].alpha = 0;
					} else {
						grpInputs[getInputTextNum()].alpha = 0;
					}
					FlxG.sound.play(Paths.sound('scrollMenu'));
				}
			}
		} else {
			var keyPressed:Int = FlxG.keys.firstJustPressed();
			if (keyPressed > -1) {
				var keysArray:Array<FlxKey> = ClientPrefs.keyBinds.get(optionShit[curSelected][1]);
				keysArray[curAlt ? 1 : 0] = keyPressed;

				var opposite:Int = (curAlt ? 0 : 1);
				if(keysArray[opposite] == keysArray[1 - opposite]) {
					keysArray[opposite] = NONE;
				}
				ClientPrefs.keyBinds.set(optionShit[curSelected][1], keysArray);

				reloadKeys();
				FlxG.sound.play(Paths.sound('confirmMenu'));
				rebindingKey = false;
			}

			bindingTime += elapsed;
			if(bindingTime > 5) {
				if (curAlt) {
					if (grpInputsAlt[curSelected] != null)
						grpInputsAlt[curSelected].alpha = 1;
				} else {
					if (grpInputs[curSelected] != null)
						grpInputs[curSelected].alpha = 1;
				}
				reloadTexts();
				FlxG.sound.play(Paths.sound('scrollMenu'));
				rebindingKey = false;
				bindingTime = 0;
			}
		}

		if(nextAccept > 0) {
			nextAccept -= 1;
		}
		super.update(elapsed);
	}

	function getInputTextNum() {
		var num:Int = 0;
		for (i in 0...curSelected) {
			if(optionShit[i].length > 1) {
				num++;
			}
		}
		return num;
	}

	function changePage(change:Int = 0) {
		curPage += change;

		if (curPage < 0)
			curPage = pages.length - 1;
		if (curPage >= pages.length)
			curPage = 0;

		optionShit = pages[curPage];

		reloadTexts();
		changeSelection();
	}
	
	function changeSelection(change:Int = 0) {
		curSelected += change;

		if (curSelected < 0)
			curSelected = optionShit.length - 1;
		if (curSelected >= optionShit.length)
			curSelected = 0;

		if ((unselectableCheck(curSelected) && grpOptions.members[curSelected].ID != 1) && change != 0) {
			changeSelection(change);
			return;
		}

		//trace(grpOptions.members[curSelected].ID);

		var bullShit:Int = 0;

		for (i in 0...grpInputs.length) {
			grpInputs[i].alpha = 0.6;
		}
		for (i in 0...grpInputsAlt.length) {
			grpInputsAlt[i].alpha = 0.6;
		}

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1) || item.ID == 1) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
					if (item.ID != 1) {
						if(curAlt) {
							for (i in 0...grpInputsAlt.length) {
								if(grpInputsAlt[i].sprTracker == item) {
									grpInputsAlt[i].alpha = 1;
									break;
								}
							}
						} else {
							for (i in 0...grpInputs.length) {
								if(grpInputs[i].sprTracker == item) {
									grpInputs[i].alpha = 1;
									break;
								}
							}
						}
					}
				}
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	function changeAlt() {
		curAlt = !curAlt;
		for (i in 0...grpInputs.length) {
			if(grpInputs[i].sprTracker == grpOptions.members[curSelected]) {
				grpInputs[i].alpha = 0.6;
				if(!curAlt) {
					grpInputs[i].alpha = 1;
				}
				break;
			}
		}
		for (i in 0...grpInputsAlt.length) {
			if(grpInputsAlt[i].sprTracker == grpOptions.members[curSelected]) {
				grpInputsAlt[i].alpha = 0.6;
				if(curAlt) {
					grpInputsAlt[i].alpha = 1;
				}
				break;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	private function unselectableCheck(num:Int, ?checkDefaultKey:Bool = false):Bool {
		if(optionShit[num][0] == defaultKey) {
			return checkDefaultKey;
		}
		return optionShit[num].length < 2 && optionShit[num][0] != defaultKey;
	}

	private function addBindTexts(optionText:Alphabet, num:Int) {
		var keys:Array<Dynamic> = ClientPrefs.keyBinds.get(optionShit[num][1]);
		var text1 = new AttachedText(InputFormatter.getKeyName(keys[0]), 400, -55);
		text1.setPosition(optionText.x + 400, optionText.y - 55);
		text1.sprTracker = optionText;
		grpInputs.push(text1);
		add(text1);

		var text2 = new AttachedText(InputFormatter.getKeyName(keys[1]), 650, -55);
		text2.setPosition(optionText.x + 650, optionText.y - 55);
		text2.sprTracker = optionText;
		grpInputsAlt.push(text2);
		add(text2);
	}

	function reloadKeys() {
		while(grpInputs.length > 0) {
			var item:AttachedText = grpInputs[0];
			item.kill();
			grpInputs.remove(item);
			item.destroy();
		}
		while(grpInputsAlt.length > 0) {
			var item:AttachedText = grpInputsAlt[0];
			item.kill();
			grpInputsAlt.remove(item);
			item.destroy();
		}

		trace('Reloaded keys: ' + ClientPrefs.keyBinds);

		for (i in 0...grpOptions.length) {
			if(!unselectableCheck(i, true)) {
				addBindTexts(grpOptions.members[i], i);
			}
		}


		var bullShit:Int = 0;
		for (i in 0...grpInputs.length) {
			grpInputs[i].alpha = 0.6;
		}
		for (i in 0...grpInputsAlt.length) {
			grpInputsAlt[i].alpha = 0.6;
		}

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
					if(curAlt) {
						for (i in 0...grpInputsAlt.length) {
							if(grpInputsAlt[i].sprTracker == item) {
								grpInputsAlt[i].alpha = 1;
							}
						}
					} else {
						for (i in 0...grpInputs.length) {
							if(grpInputs[i].sprTracker == item) {
								grpInputs[i].alpha = 1;
							}
						}
					}
				}
			}
		}
	}
}