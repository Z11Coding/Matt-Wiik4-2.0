function onCreate()

  makeLuaSprite('arena','arena-bg',-550,-300)
  setScrollFactor('arena', 0.99, 0.99)
  addLuaSprite('arena',false)


  makeAnimatedLuaSprite('characters','arena-characters',-550, 50)
  addAnimationByPrefix('characters', 'idle', 'bg-characters', 24, false)
  setScrollFactor('characters', 0.9, 0.9)
  addLuaSprite('characters',false)

  makeLuaSprite('railing','railing',-550, 230)
  setScrollFactor('railing', 0.99, 0.99)
  addLuaSprite('railing',false)

  --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end

function onBeatHit()
	if curBeat % 1 == 0 then
		objectPlayAnimation('characters', 'idle', true)
  end
end