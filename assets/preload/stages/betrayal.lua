function onCreate()
	-- background shit
	makeLuaSprite('betrayalsky', 'betrayalsky', -600, -300);
	setScrollFactor('betrayalsky', 0.9, 0.9);
	
	makeLuaSprite('betrayalground', 'betrayalground', -600, -300);
	setScrollFactor('betrayalground', 1, 1);

	makeLuaSprite('betrayallava', 'betrayallava', -600, -300);
	setScrollFactor('betrayallava', 1, 1);

	addLuaSprite('betrayalsky', false);
	addLuaSprite('betrayalground', false);
	addLuaSprite('betrayallava', false);

	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end