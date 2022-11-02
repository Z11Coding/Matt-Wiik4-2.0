function onCreate()
	-- to show you the power of stage building...
	makeLuaSprite('bg', 'backwhite', 0, 0);
	setScrollFactor('bg', 0.9, 0.9);
	
	-- *saw noises*
	
	makeLuaSprite('ground', 'floorblack', 0, 0);
	setScrollFactor('ground', 0.9, 0.9);
	
	addLuaSprite('bg', false);
	addLuaSprite('ground', false);
	
	close(true); --I SAWED THIS STAGE IN HALF!
end