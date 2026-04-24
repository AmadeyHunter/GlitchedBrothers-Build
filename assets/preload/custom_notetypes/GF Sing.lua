function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'GF Sing' and not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
			setPropertyFromGroup('unspawnNotes', i, 'alpha', 0);
			setPropertyFromGroup('unspawnNotes', i, 'visible', false);
		end
	end
end

function opponentNoteHit(id, direction ,noteType, isSustainNote)
if noteType == 'GF Sing' then
	runHaxeCode([[game.opponentStrums.members[]]..direction..[[].playAnim('static', true)]]);
end
end