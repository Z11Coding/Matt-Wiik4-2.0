function onCreate()
	-- to show you the power of stage building...
	makeLuaSprite('tr', 'backtroll', 0, 0);
	setScrollFactor('tr', 0.9, 0.9);
	
	-- *saw noises*
	
	makeLuaSprite('oll', 'floortroll', 0, 0);
	setScrollFactor('oll', 0.9, 0.9);
	
	addLuaSprite('tr', false);
	addLuaSprite('oll', false);
	
	close(true); --I SAWED THIS STAGE IN HALF!
end