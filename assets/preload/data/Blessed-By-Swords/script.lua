local healthDrain = true;

function onCreatePost()
runHaxeCode([[
game.iconP1.changeIcon("pibby");
]])
addCharacterToList('finn-slash', 1);
setPropertyFromClass('GameOverSubstate', 'characterName', 'pibby-dead')
setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'glitchhit')
setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd')
end

function opponentNoteHit(id, direction ,noteType, isSustainNote)
if not getPropertyFromGroup('notes', id, 'gfNote') then
if healthDrain then
runHaxeCode([[
if (game.health > 0.1) {
game.health -= 0.0325;
}
]])
end
if _G['dadGhostData.strumTime'] == getPropertyFromGroup('notes', id, 'strumTime') and not isSustainNote then
if healthDrain == true then
runHaxeCode([[
if (game.health > 0.5) {
game.health -= FlxG.random.float(0.075, 0.2);
}
]])
end
end
end
if not isSustainNote then
_G['dadGhostData.strumTime'] = getPropertyFromGroup('notes', id, 'strumTime')	
end
end

function onStepHit()
if curStep == 1 then
doTweenAlpha('boyfriendalpha', 'boyfriend', 0.5, 0.5, 'linear')
end
if curStep == 496 then
setProperty('camHUD.alpha',0)
setProperty('camGame.alpha',0)
end
if curStep ==  524 then
setProperty('camHUD.alpha',1)
setProperty('camGame.alpha',1)
cameraFlash('camOther', 'FFFFFF', 1, true)
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