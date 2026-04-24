function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Glitch' then
                setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', getPropertyFromGroup('unspawnNotes', i, 'mustPress'));
                setPropertyFromGroup('unspawnNotes', i, 'texture', 'GlitchNOTE_assets');
		setPropertyFromGroup('unspawnNotes', i, 'lowPriority', true);
		setPropertyFromGroup('unspawnNotes', i, 'missHealth', 0.3);
		setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true);
		setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'GlitchnoteSplashes');
		end
	end
end

function goodNoteHit(id, direction ,noteType, isSustainNote)
if noteType == 'Glitch' then
characterPlayAnim('boyfriend', 'dodge')
setProperty('boyfriend.specialAnim', true);
playSound('glitchhit', 0.3)
end
end

function noteMiss(id, direction ,noteType, isSustainNote)
if noteType == 'Glitch' then
setProperty('health', getProperty('health')+0.0475);
    runHaxeCode([[
FlxG.camera.shake(0.01, 0.2);
    ]])
addMisses(-1);
end
end