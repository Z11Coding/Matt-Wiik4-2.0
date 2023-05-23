function onCreate()

  makeLuaSprite('sky','310_sin_titulo_20220522141305',-550,-300)
  setScrollFactor('sky', 0.99, 0.99)
  addLuaSprite('sky',false)

  makeLuaSprite('fence','310_sin_titulo_20220522141309',-550,-300)
  setScrollFactor('fence', 0.99, 0.99)
  addLuaSprite('fence',false)

  makeLuaSprite('bush a','310_sin_titulo_20220522141313',-550,-300)
  setScrollFactor('bush a', 0.99, 0.99)
  addLuaSprite('bush a',false)

  makeLuaSprite('bush b','310_sin_titulo_20220522141313',-550, 200)
  setScrollFactor('bush b', 0.5, 0.5)
  if songName == 'glitch-fest' then

  else
    addLuaSprite('bush b',true)
  end


	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end