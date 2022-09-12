function onCreate()

  makeAnimatedLuaSprite('lava','volcanoanimated',-550,-300)
  addAnimationByPrefix('lava', 'idle', 'BUBBLE ', 24, true)
  setScrollFactor('lava', 0.6, 0.6)
  addLuaSprite('lava',false)

  makeLuaSprite('ground', 'volcanov3', -550, -300)
  addLuaSprite('ground',false)

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end