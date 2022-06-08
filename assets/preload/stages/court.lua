function onCreate()

  makeLuaSprite('sky','skynotthefangirl',-550,-300)
  setScrollFactor('sky', 0.99, 0.99)
  addLuaSprite('sky',false)

  makeLuaSprite('basket a','basketballsinyourmouth',-550,-300)
  setScrollFactor('basket a', 0.9, 0.9)
  addLuaSprite('basket a',false)

  makeLuaSprite('fence','fences_and_floor',-550,-300)
  setScrollFactor('fence', 0.99, 0.99)
  addLuaSprite('fence',false)

  makeLuaSprite('bush a','bush',-550,-300)
  setScrollFactor('bush a', 0.99, 0.99)
  addLuaSprite('bush a',false)

  makeLuaSprite('bush b','bush',-550, 200)
  setScrollFactor('bush b', 0.5, 0.5)
  addLuaSprite('bush b',true)


	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end