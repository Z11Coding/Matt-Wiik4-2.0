function onCreate()

  makeLuaSprite('wiik7/1','wiik7/1',-550,-300)
  addLuaSprite('wiik7/1',false)

  makeLuaSprite('2','wiik7/2',-550,-300)
  addLuaSprite('2',false)

  makeLuaSprite('wiik7/3','wiik7/3',-550,-300)
  addLuaSprite('wiik7/3',false)

  makeLuaSprite('wiik7/4','wiik7/4',-550,-300)
  addLuaSprite('wiik7/4',false)

  makeLuaSprite('wiik7/5','wiik7/5',-550,-300)
  addLuaSprite('wiik7/5',false)
end

function onUpdate()
  if getProperty('2.y') == -300 and getRandomInt(0, 1) == 0 then
    doTweenY('2', '2', 500, 20, 'CircInOut')
  else if getProperty('2.y') == -300 and getRandomInt(0, 1) == 1 then
    doTweenY('2', '2', -500, 20, 'CircInOut')
  else if getProperty('2.y') == 500 or getProperty('2.y') == -500 then
    doTweenY('2', '2', -300, 20, 'CircInOut')
  end
  end
  end
end