function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'GlitchAltSing' then
                setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', getPropertyFromGroup('unspawnNotes', i, 'mustPress'));
                setPropertyFromGroup('unspawnNotes', i, 'texture', 'GlitchNOTE_assets');
		setPropertyFromGroup('unspawnNotes', i, 'lowPriority', true);
		setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'GlitchnoteSplashes');
		setPropertyFromGroup('unspawnNotes', i, 'animSuffix', '-alt');
		end
	end
end