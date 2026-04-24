function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Second Char Sing' then
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);
		end
	end
end
