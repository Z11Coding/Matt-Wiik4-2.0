package;

typedef SwagSection =
{
	var sectionNotes:Array<Dynamic>;
	var lengthInSteps:Int;
	var typeOfSection:Int;
	var mustHitSection:Bool;
	var gfSection:Bool;
	var exSection:Bool;
	var bpm:Float;
	var changeBPM:Bool;
	var altAnim:Bool;
	var bothSection:Bool;
	var sectionBeats:Float;	
}

class Section
{
	public var sectionNotes:Array<Dynamic> = [];

	public var lengthInSteps:Int = 16;
	public var gfSection:Bool = false;
	public var exSection:Bool = false;
	public var typeOfSection:Int = 0;
	public var mustHitSection:Bool = true;
	public var bothSection:Bool = true;
	public var sectionBeats:Float = 4;

	/**
	 *	Copies the first section into the second section!
	 */
	public static var COPYCAT:Int = 0;

	public function new(lengthInSteps:Int = 16, sectionBeats:Float = 4)
	{
		this.sectionBeats = sectionBeats;
		this.lengthInSteps = lengthInSteps;
	}
}
