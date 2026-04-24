local shootAnims = {"shootLEFT", "shootDOWN", "shootUP", "shootRIGHT"}
function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'Attack Note' then
		characterPlayAnim('boyfriend', shootAnims[direction + 1], false);
		setProperty('boyfriend.specialAnim', true);
    end
end