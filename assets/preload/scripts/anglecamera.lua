local mindless = true;
local jakeSings = false;
local pibbySings = false;

function onUpdatePost(dt)
charAnimOffsetX = 0;
        if mustHitSection == false then
if not jakeSings then
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' or getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' or getProperty('dad.animation.curAnim.name') == 'singLEFTmiss' then
charAnimOffsetX = -20;
            elseif getProperty('dad.animation.curAnim.name') == 'singRIGHT' or getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' or getProperty('dad.animation.curAnim.name') == 'singRIGHTmiss' then
charAnimOffsetX = 20;
            elseif getProperty('dad.animation.curAnim.name') == 'singUP' or getProperty('dad.animation.curAnim.name') == 'singUP-alt' or getProperty('dad.animation.curAnim.name') == 'singUPmiss' then
charAnimOffsetX = 0;
            elseif getProperty('dad.animation.curAnim.name') == 'singDOWN' or getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' or getProperty('dad.animation.curAnim.name') == 'singDOWNmiss' then
charAnimOffsetX = 0;
            else
charAnimOffsetX = 0;
            end
else
            if getProperty('jake.animation.curAnim.name') == 'singLEFT' or getProperty('jake.animation.curAnim.name') == 'singLEFT-alt' or getProperty('jake.animation.curAnim.name') == 'singLEFTmiss' then
charAnimOffsetX = -20;
            elseif getProperty('jake.animation.curAnim.name') == 'singRIGHT' or getProperty('jake.animation.curAnim.name') == 'singRIGHT-alt' or getProperty('jake.animation.curAnim.name') == 'singRIGHTmiss' then
charAnimOffsetX = 20;
            elseif getProperty('jake.animation.curAnim.name') == 'singUP' or getProperty('jake.animation.curAnim.name') == 'singUP-alt' or getProperty('jake.animation.curAnim.name') == 'singUPmiss' then
charAnimOffsetX = 0;
            elseif getProperty('jake.animation.curAnim.name') == 'singDOWN' or getProperty('jake.animation.curAnim.name') == 'singDOWN-alt' or getProperty('jake.animation.curAnim.name') == 'singDOWNmiss' then
charAnimOffsetX = 0;
            else
charAnimOffsetX = 0;
            end
end
        end
        if gfSection == true and mustHitSection == true then
            if getProperty('gf.animation.curAnim.name') == 'singLEFT' or getProperty('gf.animation.curAnim.name') == 'singLEFT-alt' or getProperty('gf.animation.curAnim.name') == 'singLEFTmiss' then
charAnimOffsetX = -20;
            elseif getProperty('gf.animation.curAnim.name') == 'singRIGHT' or getProperty('gf.animation.curAnim.name') == 'singRIGHT-alt' or getProperty('gf.animation.curAnim.name') == 'singRIGHTmiss' then
charAnimOffsetX = 20;
            elseif getProperty('gf.animation.curAnim.name') == 'singUP' or getProperty('gf.animation.curAnim.name') == 'singUP-alt' or getProperty('gf.animation.curAnim.name') == 'singUPmiss' then
charAnimOffsetX = 0;
            elseif getProperty('gf.animation.curAnim.name') == 'singDOWN' or getProperty('gf.animation.curAnim.name') == 'singDOWN-alt' or getProperty('gf.animation.curAnim.name') == 'singDOWNmiss' then
charAnimOffsetX = 0;
            else
charAnimOffsetX = 0;
            end
        elseif mustHitSection == true then
if not pibbySings then
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' or getProperty('boyfriend.animation.curAnim.name') == 'singLEFT-alt' or getProperty('boyfriend.animation.curAnim.name') == 'singLEFTmiss' then
charAnimOffsetX = -20;
            elseif getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' or getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT-alt' or getProperty('boyfriend.animation.curAnim.name') == 'singRIGHTmiss' then
charAnimOffsetX = 20;
            elseif getProperty('boyfriend.animation.curAnim.name') == 'singUP' or getProperty('boyfriend.animation.curAnim.name') == 'singUP-alt' or getProperty('boyfriend.animation.curAnim.name') == 'singUPmiss' then
charAnimOffsetX = 0;
            elseif getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' or getProperty('boyfriend.animation.curAnim.name') == 'singDOWN-alt' or getProperty('boyfriend.animation.curAnim.name') == 'singDOWNmiss' then
charAnimOffsetX = 0;
            else
charAnimOffsetX = 0;
            end
else
            if getProperty('gf.animation.curAnim.name') == 'singLEFT' or getProperty('gf.animation.curAnim.name') == 'singLEFT-alt' or getProperty('gf.animation.curAnim.name') == 'singLEFTmiss' then
charAnimOffsetX = -20;
            elseif getProperty('gf.animation.curAnim.name') == 'singRIGHT' or getProperty('gf.animation.curAnim.name') == 'singRIGHT-alt' or getProperty('gf.animation.curAnim.name') == 'singRIGHTmiss' then
charAnimOffsetX = 20;
            elseif getProperty('gf.animation.curAnim.name') == 'singUP' or getProperty('gf.animation.curAnim.name') == 'singUP-alt' or getProperty('gf.animation.curAnim.name') == 'singUPmiss' then
charAnimOffsetX = 0;
            elseif getProperty('gf.animation.curAnim.name') == 'singDOWN' or getProperty('gf.animation.curAnim.name') == 'singDOWN-alt' or getProperty('gf.animation.curAnim.name') == 'singDOWNmiss' then
charAnimOffsetX = 0;
            else
charAnimOffsetX = 0;
            end
end
        end
if mindless and songName == "Mindless" then
charAnimOffsetX = 0;
end
angleLerp = boundTo(boundTo(dt * 2.4 / 0.4, 0, 1) * getProperty("cameraSpeed") * getProperty("playbackRate"), 0, 1);
setProperty('camGame.angle',lerp(getProperty("camGame.angle"), 0 + charAnimOffsetX / 30, angleLerp))
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