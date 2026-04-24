local dodgeAnims = {"dodgeLEFT", "dodgeDOWN", "dodgeUP", "dodgeRIGHT"}
function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'Dodge Note' then
		characterPlayAnim('boyfriend', dodgeAnims[direction + 1], false);
		setProperty('boyfriend.specialAnim', true);
    end
end