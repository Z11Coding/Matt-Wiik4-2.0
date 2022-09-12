function onCreate()
	-- background shit
	makeLuaSprite('bg', 'boxingnight2', 0, 0);
	setScrollFactor('bg', 0.9, 0.9);
	--scaleObject('bg', 1.3, 1.3);

	makeLuaSprite('ring', 'boxingnight3', 0, 0);
	setScrollFactor('ring', 0.9, 0.9);
	--scaleObject('ring', 1.3, 1.3);
	--scaleObject('woods', 1.1, 1.1);

	addLuaSprite('bg', false);
	addLuaSprite('ring', false);
	--addLuaSprite('woods', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end