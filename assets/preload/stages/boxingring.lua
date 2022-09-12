function onCreate()
	-- background shit
	makeAnimatedLuaSprite('bg', 'boxwall', 0, 0);
	addAnimationByIndices('bg', 'idle', 'wallboom instance 1', '1,2,3,4,5,6,7,8,9,10,11,12,13,14', 24)
	addAnimationByIndices('bg', 'idle2', 'wallboom instance 1', '15,16,17,18,19,20,21,22,23,24,25,26,27,28,29', 24)
	setScrollFactor('bg', 0.9, 0.9);
	--scaleObject('bg', 1.3, 1.3);

	makeAnimatedLuaSprite('ring', 'boxfloor', 0, 0);
	addAnimationByPrefix('ring', 'idle', 'bg instance 1', 24)
	setScrollFactor('ring', 0.9, 0.9);
	--scaleObject('ring', 1.3, 1.3);
	--scaleObject('woods', 1.1, 1.1);

	addLuaSprite('bg', false);
	addLuaSprite('ring', false);
	objectPlayAnimation('bg', 'idle')
	--addLuaSprite('woods', false);
	
	--For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end

function onBeatHit()
	if curBeat % 2 == 1 then
		objectPlayAnimation('bg', 'idle')
		objectPlayAnimation('ring', 'idle', true)
	else
		objectPlayAnimation('ring', 'idle', true)
		objectPlayAnimation('bg', 'idle2')
	end
end