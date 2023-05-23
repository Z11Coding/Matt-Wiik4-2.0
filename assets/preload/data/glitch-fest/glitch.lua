local shaderName = "glitch"
function onCreate()
    if shadersEnabled then
        shaderCoordFix() -- initialize a fix for textureCoord when resizing game window

        makeLuaSprite("glitch")
        makeGraphic("shaderImage", screenWidth, screenHeight)

    setSpriteShader("shaderImage", "glitch")


        runHaxeCode([[
            var shaderName = "]] .. shaderName .. [[";
            
            game.initLuaShader(shaderName);
            
            var shader0 = game.createRuntimeShader(shaderName);
            game.camGame.setFilters([new ShaderFilter(shader0)]);
            game.getLuaObject("glitch").shader = shader0; // setting it into temporary sprite so luas can set its shader uniforms/properties
            game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("glitch").shader)]);
            return;
        ]])
    end
end

function onUpdate(elapsed)
    if shadersEnabled then
        setShaderFloat("glitch", "iTime", os.clock())
    end
 end

 function onStepHit()
    if shadersEnabled then
        if curStep == 1 then
            shaderCoordFix()
            runHaxeCode([[
            game.camGame.setFilters();
            game.camHUD.setFilters();
            ]])
        end
        if curStep == 399 then
            shaderCoordFix()
            runHaxeCode([[
                var shaderName = "]] .. shaderName .. [[";
            
            game.initLuaShader(shaderName);
            
            var shader0 = game.createRuntimeShader(shaderName);
            game.camGame.setFilters([new ShaderFilter(shader0)]);
            game.getLuaObject("effect weird").shader = shader0; // setting it into temporary sprite so luas can set its shader uniforms/properties
            game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("effect weird").shader)]);
        ]])
        end
        if curStep == 404 then
            shaderCoordFix()
            runHaxeCode([[
            game.camGame.setFilters();
            game.camHUD.setFilters();
            ]])
        end
        if curStep == 431 then
            shaderCoordFix()
            runHaxeCode([[
                var shaderName = "]] .. shaderName .. [[";
            
            game.initLuaShader(shaderName);
            
            var shader0 = game.createRuntimeShader(shaderName);
            game.camGame.setFilters([new ShaderFilter(shader0)]);
            game.getLuaObject("effect weird").shader = shader0; // setting it into temporary sprite so luas can set its shader uniforms/properties
            game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("effect weird").shader)]);
        ]])
        end
        if curStep == 436 then
            runHaxeCode([[
                game.camGame.setFilters();
                game.camHUD.setFilters();
            ]])
            shaderCoordFix()
        end
        if curStep == 744 then
            shaderCoordFix()
            runHaxeCode([[
                var shaderName = "]] .. shaderName .. [[";
            
            game.initLuaShader(shaderName);
            
            var shader0 = game.createRuntimeShader(shaderName);
            game.camGame.setFilters([new ShaderFilter(shader0)]);
            game.getLuaObject("effect weird").shader = shader0; // setting it into temporary sprite so luas can set its shader uniforms/properties
            game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("effect weird").shader)]);
        ]])
        end
        if curStep == 768 then
            runHaxeCode([[
                game.camGame.setFilters();
                game.camHUD.setFilters();
            ]])
            shaderCoordFix()
        end
        if curStep == 1784 then
            shaderCoordFix()
            runHaxeCode([[
                var shaderName = "]] .. shaderName .. [[";
            
            game.initLuaShader(shaderName);
            
            var shader0 = game.createRuntimeShader(shaderName);
            game.camGame.setFilters([new ShaderFilter(shader0)]);
            game.getLuaObject("effect weird").shader = shader0; // setting it into temporary sprite so luas can set its shader uniforms/properties
            game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("effect weird").shader)]);
        ]])
        end
        if curStep == 1807 then
            runHaxeCode([[
                game.camGame.setFilters();
                game.camHUD.setFilters();
            ]])
            shaderCoordFix()
        end
        if curStep == 2056 then
            shaderCoordFix()
            runHaxeCode([[
                var shaderName = "]] .. shaderName .. [[";
            
            game.initLuaShader(shaderName);
            
            var shader0 = game.createRuntimeShader(shaderName);
            game.camGame.setFilters([new ShaderFilter(shader0)]);
            game.getLuaObject("effect weird").shader = shader0; // setting it into temporary sprite so luas can set its shader uniforms/properties
            game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("effect weird").shader)]);
        ]])
        end
    end
end

function shaderCoordFix()
    runHaxeCode([[
        resetCamCache = function(?spr) {
            if (spr == null || spr.filters == null) return;
            spr.__cacheBitmap = null;
            spr.__cacheBitmapData = null;
        }
        
        fixShaderCoordFix = function(?_) {
            resetCamCache(game.camGame.flashSprite);
            resetCamCache(game.camHUD.flashSprite);
            resetCamCache(game.camOther.flashSprite);
        }
    
        FlxG.signals.gameResized.add(fixShaderCoordFix);
        fixShaderCoordFix();
        return;
    ]])
    
    local temp = onDestroy
    function onDestroy()
        runHaxeCode([[
            FlxG.signals.gameResized.remove(fixShaderCoordFix);
            return;
        ]])
        if (temp) then temp() end
    end
end