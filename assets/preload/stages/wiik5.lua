function onCreate()

  makeLuaSprite('outside','outside',-550,-300)
  addLuaSprite('outside',false)
 

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end