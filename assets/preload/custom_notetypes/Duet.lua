function goodNoteHit(id, noteData, noteType, isSustainNote)

    doTweenAlpha('screenfAnim', 'screenf', 0.3, 3, 'cubeOut')

    if noteType == 'Duet' then

        local animToPlay = getProperty('singAnimations')[noteData + 1];

        playAnim('boyfriend', animToPlay, true);

        playAnim('gf', animToPlay, true);

        setProperty('gf.holdTimer', 0);

    end

end


function opponentNoteHit(id, noteData, noteType, isSustainNote)

        doTweenAlpha('screenfAnim', 'screenf', 1, 3, 'cubeOut')


end