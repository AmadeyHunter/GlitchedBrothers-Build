function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Sword' then
                setPropertyFromGroup('unspawnNotes', i, 'mustPress', true);
                setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false);
                setPropertyFromGroup('unspawnNotes', i, 'texture', 'SwordNOTE_assets');
		setPropertyFromGroup('unspawnNotes', i, 'lowPriority', true);
		setPropertyFromGroup('unspawnNotes', i, 'missHealth', 0.3);
		setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);
		end
	end
end

function goodNoteHit(id, direction ,noteType, isSustainNote)
if noteType == 'Sword' then
characterPlayAnim('boyfriend', 'dodge')
setProperty('boyfriend.specialAnim', true);
characterPlayAnim('dad', 'attack')
setProperty('dad.specialAnim', true);
end
end

function noteMiss(id, direction ,noteType, isSustainNote)
if noteType == 'Sword' then
    runHaxeCode([[
FlxG.camera.shake(0.01, 0.2);
    ]])
characterPlayAnim('boyfriend', 'hurt')
setProperty('boyfriend.specialAnim', true);
characterPlayAnim('dad', 'attack')
setProperty('dad.specialAnim', true);
end
end