local start = true;
local mindless = true;
local jakeSings = false;
local pibbySings = false;

function onUpdate(elapsed)
xx = getMidpointX('dad') + 150 + getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]');
yy = getMidpointY('dad') - 100 + getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]');
xx2 = getMidpointX('boyfriend') - 100 - getProperty('boyfriend.cameraPosition[0]') + getProperty('boyfriendCameraOffset[0]');
yy2 = getMidpointY('boyfriend') - 100 + getProperty('boyfriend.cameraPosition[1]') + getProperty('boyfriendCameraOffset[1]');
xx3 = getMidpointX('gf') + getProperty('gf.cameraPosition[0]') + getProperty('girlfriendCameraOffset[0]');
yy3 = getMidpointY('gf') + getProperty('gf.cameraPosition[1]') + getProperty('girlfriendCameraOffset[1]');
if songName == 'Suffering Siblings' then
xx4 = getMidpointX('jake') + 150 + getProperty('jake.cameraPosition[0]') + getProperty('opponentCameraOffset[0]');
yy4 = getMidpointY('jake') - 100 + getProperty('jake.cameraPosition[1]') + getProperty('opponentCameraOffset[1]');
end
charAnimOffsetX = 0;
charAnimOffsetY = 0;
lerpVal = boundTo(elapsed * 2.4 * getProperty("cameraSpeed") * getProperty("playbackRate"), 0, 1);
        if mustHitSection == false then
if not jakeSings then
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' or getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' or getProperty('dad.animation.curAnim.name') == 'singLEFTmiss' then
charAnimOffsetX = -20;
charAnimOffsetY = 0;
            elseif getProperty('dad.animation.curAnim.name') == 'singRIGHT' or getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' or getProperty('dad.animation.curAnim.name') == 'singRIGHTmiss' then
charAnimOffsetX = 20;
charAnimOffsetY = 0;
            elseif getProperty('dad.animation.curAnim.name') == 'singUP' or getProperty('dad.animation.curAnim.name') == 'singUP-alt' or getProperty('dad.animation.curAnim.name') == 'singUPmiss' then
charAnimOffsetX = 0;
charAnimOffsetY = -20;
            elseif getProperty('dad.animation.curAnim.name') == 'singDOWN' or getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' or getProperty('dad.animation.curAnim.name') == 'singDOWNmiss' then
charAnimOffsetX = 0;
charAnimOffsetY = 20;
            else
charAnimOffsetX = 0;
charAnimOffsetY = 0;
            end
triggerEvent('Camera Follow Pos',xx+charAnimOffsetX,yy+charAnimOffsetY)
else
            if getProperty('jake.animation.curAnim.name') == 'singLEFT' or getProperty('jake.animation.curAnim.name') == 'singLEFT-alt' or getProperty('jake.animation.curAnim.name') == 'singLEFTmiss' then
charAnimOffsetX = -20;
charAnimOffsetY = 0;
            elseif getProperty('jake.animation.curAnim.name') == 'singRIGHT' or getProperty('jake.animation.curAnim.name') == 'singRIGHT-alt' or getProperty('jake.animation.curAnim.name') == 'singRIGHTmiss' then
charAnimOffsetX = 20;
charAnimOffsetY = 0;
            elseif getProperty('jake.animation.curAnim.name') == 'singUP' or getProperty('jake.animation.curAnim.name') == 'singUP-alt' or getProperty('jake.animation.curAnim.name') == 'singUPmiss' then
charAnimOffsetX = 0;
charAnimOffsetY = -20;
            elseif getProperty('jake.animation.curAnim.name') == 'singDOWN' or getProperty('jake.animation.curAnim.name') == 'singDOWN-alt' or getProperty('jake.animation.curAnim.name') == 'singDOWNmiss' then
charAnimOffsetX = 0;
charAnimOffsetY = 20;
            else
charAnimOffsetX = 0;
charAnimOffsetY = 0;
            end
triggerEvent('Camera Follow Pos',xx+charAnimOffsetX,yy+charAnimOffsetY)
end
            end
        if gfSection == true and mustHitSection == true then
            if getProperty('gf.animation.curAnim.name') == 'singLEFT' or getProperty('gf.animation.curAnim.name') == 'singLEFT-alt' or getProperty('gf.animation.curAnim.name') == 'singLEFTmiss' then
charAnimOffsetX = -20;
charAnimOffsetY = 0;
            elseif getProperty('gf.animation.curAnim.name') == 'singRIGHT' or getProperty('gf.animation.curAnim.name') == 'singRIGHT-alt' or getProperty('gf.animation.curAnim.name') == 'singRIGHTmiss' then
charAnimOffsetX = 20;
charAnimOffsetY = 0;
            elseif getProperty('gf.animation.curAnim.name') == 'singUP' or getProperty('gf.animation.curAnim.name') == 'singUP-alt' or getProperty('gf.animation.curAnim.name') == 'singUPmiss' then
charAnimOffsetX = 0;
charAnimOffsetY = -20;
            elseif getProperty('gf.animation.curAnim.name') == 'singDOWN' or getProperty('gf.animation.curAnim.name') == 'singDOWN-alt' or getProperty('gf.animation.curAnim.name') == 'singDOWNmiss' then
charAnimOffsetX = 0;
charAnimOffsetY = 20;
            else
charAnimOffsetX = 0;
charAnimOffsetY = 0;
            end
triggerEvent('Camera Follow Pos',xx3+charAnimOffsetX,yy3+charAnimOffsetY)
        elseif mustHitSection == true then
if not pibbySings then
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' or getProperty('boyfriend.animation.curAnim.name') == 'singLEFT-alt' or getProperty('boyfriend.animation.curAnim.name') == 'singLEFTmiss' then
charAnimOffsetX = -20;
charAnimOffsetY = 0;
            elseif getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' or getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT-alt' or getProperty('boyfriend.animation.curAnim.name') == 'singRIGHTmiss' then
charAnimOffsetX = 20;
charAnimOffsetY = 0;
            elseif getProperty('boyfriend.animation.curAnim.name') == 'singUP' or getProperty('boyfriend.animation.curAnim.name') == 'singUP-alt' or getProperty('boyfriend.animation.curAnim.name') == 'singUPmiss' then
charAnimOffsetX = 0;
charAnimOffsetY = -20;
            elseif getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' or getProperty('boyfriend.animation.curAnim.name') == 'singDOWN-alt' or getProperty('boyfriend.animation.curAnim.name') == 'singDOWNmiss' then
charAnimOffsetX = 0;
charAnimOffsetY = 20;
            else
charAnimOffsetX = 0;
charAnimOffsetY = 0;
            end
triggerEvent('Camera Follow Pos',xx2+charAnimOffsetX,yy2+charAnimOffsetY)
else
            if getProperty('gf.animation.curAnim.name') == 'singLEFT' or getProperty('gf.animation.curAnim.name') == 'singLEFT-alt' or getProperty('gf.animation.curAnim.name') == 'singLEFTmiss' then
charAnimOffsetX = -20;
charAnimOffsetY = 0;
            elseif getProperty('gf.animation.curAnim.name') == 'singRIGHT' or getProperty('gf.animation.curAnim.name') == 'singRIGHT-alt' or getProperty('gf.animation.curAnim.name') == 'singRIGHTmiss' then
charAnimOffsetX = 20;
charAnimOffsetY = 0;
            elseif getProperty('gf.animation.curAnim.name') == 'singUP' or getProperty('gf.animation.curAnim.name') == 'singUP-alt' or getProperty('gf.animation.curAnim.name') == 'singUPmiss' then
charAnimOffsetX = 0;
charAnimOffsetY = -20;
            elseif getProperty('gf.animation.curAnim.name') == 'singDOWN' or getProperty('gf.animation.curAnim.name') == 'singDOWN-alt' or getProperty('gf.animation.curAnim.name') == 'singDOWNmiss' then
charAnimOffsetX = 0;
charAnimOffsetY = 20;
            else
charAnimOffsetX = 0;
charAnimOffsetY = 0;
            end
triggerEvent('Camera Follow Pos',xx2+charAnimOffsetX,yy2+charAnimOffsetY)
end
            end
if start then
triggerEvent('Camera Follow Pos',xx2+charAnimOffsetX,yy2+charAnimOffsetY)
end
if mindless and songName == "Mindless" then
charAnimOffsetX = 0;
charAnimOffsetY = 0;
triggerEvent('Camera Follow Pos',xx2+charAnimOffsetX,yy2+charAnimOffsetY)
end
end

function onSongStart()
start = false;
end

function onSectionHit()
mindless = false;
end

function opponentNoteHit(id, direction ,noteType, isSustainNote)
if songName == 'Suffering Siblings' then
if getPropertyFromGroup('notes', id, 'gfNote') or noteType == 'Second Char Sing' or noteType == 'Both Char Sing' or noteType == 'Second Char Glitch' then
jakeSings = true;
else
jakeSings = false;
end
end
end

function goodNoteHit(id, direction ,noteType, isSustainNote)
if getPropertyFromGroup('notes', id, 'gfNote') then
pibbySings = true;
else
pibbySings = false;
end
end

function lerp(a, b, t)
    return (1-t)*a + t*b
end

function boundTo(val, min, max)
    if val < min then
        return min
    elseif val > max then
        return max
    else
        return val
    end
end