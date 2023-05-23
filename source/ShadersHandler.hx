package;

import openfl.display.Shader;
import openfl.filters.ShaderFilter;
import Shaders;

class ShadersHandler
{
	public static var chromaticAberration:ShaderFilter = new ShaderFilter(new ChromaticAberration());
	public static var error:ShaderFilter = new ShaderFilter(new Shaders.ErrorShader());

	public static function setChrome(chromeOffset:Float):Void
	{
		chromaticAberration.shader.data.rOffset.value = [chromeOffset];
		chromaticAberration.shader.data.gOffset.value = [0.0];
		chromaticAberration.shader.data.bOffset.value = [chromeOffset * -1];
	}

	public static function setglitchAmplitude(alpha:Float)
	{
		error.shader.data.glitchAmplitude.value = [alpha];
	}

	public static function setglitchNarrowness(alpha:Float)
	{
		error.shader.data.glitchNarrowness.value = [alpha];
	}

	public static function setglitchBlockiness(alpha:Float)
	{
		error.shader.data.glitchBlockiness.value = [alpha];
	}

	public static function setglitchMinimizer(alpha:Float)
	{
		error.shader.data.glitchMinimizer.value = [alpha];
	}

	public static function defaultGlitch()
	{
		error.shader.data.glitchAmplitude.value = [0.2];
		error.shader.data.glitchNarrowness.value = [4.0];
		error.shader.data.glitchBlockiness.value = [2.0];
		error.shader.data.glitchMinimizer.value = [5.0];
	}

	public static function resetGlitch()
	{
		error.shader.data.glitchAmplitude.value = [0.0];
		error.shader.data.glitchNarrowness.value = [0.0];
		error.shader.data.glitchBlockiness.value = [0.0];
		error.shader.data.glitchMinimizer.value = [0.0];
	}
}