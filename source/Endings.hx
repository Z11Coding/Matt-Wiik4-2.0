package;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.FlxG;
import LoadingState.LoadingsState;
import flixel.addons.transition.FlxTransitionableState;
using StringTools;

class Endings extends MusicBeatState
{
    var whichEnding:String;
    var endImage:FlxSprite;
    var endTextA:FlxText;
    var endTextB:FlxText;
    public function new(whichEnding:String)
    {
        super();
        this.whichEnding = whichEnding;
    }
    override function create()
    {
        
        super.create();
        switch (whichEnding)
        {
            case 'endt':
                endImage = new FlxSprite().loadGraphic(Paths.image('endings/endingt'));
            case 'end1':
                endImage = new FlxSprite().loadGraphic(Paths.image('endings/ending1'));
            case 'end2':
                endImage = new FlxSprite().loadGraphic(Paths.image('endings/ending2'));
            case 'end3':
                endImage = new FlxSprite().loadGraphic(Paths.image('endings/ending3'));
            case 'end4':
                endImage = new FlxSprite().loadGraphic(Paths.image('endings/ending4'));
            case 'end5':
                endImage = new FlxSprite().loadGraphic(Paths.image('endings/ending5'));
            case 'urbad':
                endImage = new FlxSprite().loadGraphic(Paths.image('endings/endingWorst'));
            case 'urkindbad':
                endImage = new FlxSprite().loadGraphic(Paths.image('endings/endingNeutral'));
            default:
                endImage = new FlxSprite().loadGraphic(Paths.image('endings/sex'));
        }
        endImage.screenCenter();
        endImage.scrollFactor.set();
		endImage.updateHitbox();
        add(endImage);
        new FlxTimer().start(10, function(tmr:FlxTimer) {
            openSubState(new LoadingsState());
            FlxTransitionableState.skipNextTransIn = true;
            var toSwitchToState = new MainMenuState();
            LoadingState.loadAndSwitchState(toSwitchToState, true,true);
        });
    }

    override function update(elapsed:Float)
    {
        if (FlxG.keys.justPressed.ENTER)
        {
            openSubState(new LoadingsState());
            FlxTransitionableState.skipNextTransIn = true;
            var toSwitchToState = new MainMenuState();
            LoadingState.loadAndSwitchState(toSwitchToState, true,true);
        }
    }
}