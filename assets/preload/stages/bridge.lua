function onCreate()
  makeLuaSprite('BG2','wiik/wiik4bg0006', -400 , -400);
  scaleObject('BG2', 1, 1);
  addLuaSprite('BG2',false);
  makeLuaSprite('BG5','wiik/wiik4bg0005', -500 , -200);
  scaleObject('BG5', 1, 1);
  addLuaSprite('BG5',false);
  makeLuaSprite('BG3','wiik/wiik4bg0004', -500 , -200);
  scaleObject('BG3', 1, 1);
  addLuaSprite('BG3',false);
  makeLuaSprite('BG','wiik/wiik4bg0003', -500 , -200);
  scaleObject('BG', 1, 1);
  addLuaSprite('BG',false);
  makeLuaSprite('BG4','wiik/wiik4bg0002', -500 , -200);
  scaleObject('BG4', 1, 1);
  addLuaSprite('BG4',false);
  makeLuaSprite('BG6','wiik/wiik4bg0001', -500 , -200);
  scaleObject('BG6', 1, 1);
  addLuaSprite('BG6',false);

  setLuaSpriteScrollFactor('BG2', 0, 0);
  setLuaSpriteScrollFactor('BG5', 0.3, 0.3);
  setLuaSpriteScrollFactor('BG3', 0.4, 0.4);
  setLuaSpriteScrollFactor('BG', 0.5, 0.5);
  setLuaSpriteScrollFactor('BG4', 0.8, 0.8);
  setLuaSpriteScrollFactor('BG6', 1, 1);
end