local gfSpeed
local camBeat1 = false
local camZoom
local defaultCamZoom
local defBeat1
function onCreate()
    gfSpeed = getProperty('gfSpeed')
    defaultCamZoom = getProperty('defaultCamZoom')
    camZoom = defaultCamZoom
end

function onStepHit()
    if curStep == 1 then
        camBeat1 = true;
    end
    if curStep == 251 then
        camBeat1 = false;
        camZoom = 40;
    end
    if curStep == 256 then
        defBeat1 = true;
        camZoom = defaultCamZoom;
    end
    if curStep == 512 then
        defBeat1 = false;
        camBeat1 = true;
        camZoom = defaultCamZoom;
    end
    if curStep == 636 then
        camBeat1 = false;
        camZoom = 40;
    end
    if curStep == 640 then
        defBeat1 = true;
        camZoom = defaultCamZoom;
    end
    if curStep == 1024 then
        defBeat1 = false;
        camBeat1 = true;
        camZoom = defaultCamZoom;
    end
    if curStep == 1276 then
        camBeat1 = false;
        camZoom = 40;
    end
    if curStep == 1280 then
        defBeat1 = true;
        camZoom = defaultCamZoom;
    end
    if curStep == 1536 then
        defBeat1 = false;
        camBeat1 = true;
        camZoom = defaultCamZoom;
    end
    if curStep == 1792 then
        defBeat1 = true;
        camZoom = defaultCamZoom;
    end
    if curStep == 2048 then
        defBeat1 = false;
        camBeat1 = true;
        camZoom = defaultCamZoom;
    end

    if defBeat1 then
        if curStep % 64 == 0 then
            camBeat1 = true;
            camZoom = defaultCamZoom;
            triggerEvent("Add Camera Zoom", 0.1, 0.1)
            setProperty('camHUD.angle', 5)
            doTweenAngle('camAngleHUD', 'camHUD', 0, 0.5, "sineInOut")
            setProperty('camGame.angle', 5)
            doTweenAngle('camAngle', 'camGame', 0, 0.5, "sineInOut")
        end
        if curStep % 64 == 32 then
            camBeat1 = false;
        end
        if curStep % 64 == 35 then
            triggerEvent("Add Camera Zoom", 0.1, 0.1)
            setProperty('camHUD.angle', 5)
            doTweenAngle('camAngleHUD', 'camHUD', 0, 0.5, "sineInOut")
            setProperty('camGame.angle', 5)
            doTweenAngle('camAngle', 'camGame', 0, 0.5, "sineInOut")
        end
        if curStep % 64 == 37 then
            triggerEvent("Add Camera Zoom", -0.1, -0.1)
            setProperty('camHUD.angle', -5)
            doTweenAngle('camAngleHUD', 'camHUD', 0, 0.5, "sineInOut")
        end
        if curStep % 64 == 42 then
            triggerEvent("Add Camera Zoom", 0.1, 0.1)
            setProperty('camHUD.angle', 5)
            doTweenAngle('camAngleHUD', 'camHUD', 0, 0.5, "sineInOut")
            setProperty('camGame.angle', 5)
            doTweenAngle('camAngle', 'camGame', 0, 0.5, "sineInOut")
        end
        if curStep % 64 == 44 then
            triggerEvent("Add Camera Zoom", -0.1, -0.1)
            setProperty('camHUD.angle', -5)
            doTweenAngle('camAngleHUD', 'camHUD', 0, 0.5, "sineInOut")
            setProperty('camGame.angle', 5)
            doTweenAngle('camAngle', 'camGame', 0, 0.5, "sineInOut")
        end
        if curStep % 64 == 51 then
            triggerEvent("Add Camera Zoom", 0.1, 0.1)
            setProperty('camHUD.angle', 5)
            doTweenAngle('camAngleHUD', 'camHUD', 0, 0.5, "sineInOut")
            setProperty('camGame.angle', 5)
            doTweenAngle('camAngle', 'camGame', 0, 0.5, "sineInOut")
        end
        if curStep % 64 == 53 then
            triggerEvent("Add Camera Zoom", -0.1, -0.1)
            setProperty('camHUD.angle', -5)
            doTweenAngle('camAngleHUD', 'camHUD', 0, 0.5, "sineInOut")
            setProperty('camGame.angle', 5)
            doTweenAngle('camAngle', 'camGame', 0, 0.5, "sineInOut")
        end
        if curStep % 64 == 58 then
            triggerEvent("Add Camera Zoom", 0.1, 0.1)
            setProperty('camHUD.angle', 5)
            doTweenAngle('camAngleHUD', 'camHUD', 0, 0.5, "sineInOut")
            setProperty('camGame.angle', 5)
            doTweenAngle('camAngle', 'camGame', 0, 0.5, "sineInOut")
        end
        if curStep % 64 == 60 then
            triggerEvent("Add Camera Zoom", -0.1, -0.1)
            setProperty('camHUD.angle', -5)
            doTweenAngle('camAngleHUD', 'camHUD', 0, 0.5, "sineInOut")
            setProperty('camGame.angle', 5)
            doTweenAngle('camAngle', 'camGame', 0, 0.5, "sineInOut")
        end
    end
end

function onUpdatePost()
    doTweenZoom('camZooming', 'camGame', camZoom, 0.5, "sineInOut")
end

function onBeatHit()
    if camBeat1 == true then
        if curBeat % 2 == 0 / gfSpeed then
            triggerEvent("Add Camera Zoom", 0.1, 0.1)
            setProperty('camGame.angle', 5)
            doTweenAngle('camAngle', 'camGame', 0, 0.5, "sineInOut")
            setProperty('camHUD.angle', 5)
            doTweenAngle('camAngleHUD', 'camHUD', 0, 0.5, "sineInOut")
        end

        if curBeat % 2 == 1 / gfSpeed then
            triggerEvent("Add Camera Zoom", -0.1, -0.1)
            setProperty('camGame.angle', -5)
            doTweenAngle('camAngle', 'camGame', 0, 0.5, "sineInOut")
            setProperty('camHUD.angle', -5)
            doTweenAngle('camAngleHUD', 'camHUD', 0, 0.5, "sineInOut")
            for i = 0,7 do
                noteTweenY('strumMove'..i, i, 50, 0.00000000001, "sineInOut")
            end
        end
    end
end