function opponentNoteHit(id, direction ,noteType, isSustainNote)
if noteType == 'Glitch Note' then
        setPropertyFromGroup('opponentStrums', 0, 'x', defaultOpponentStrumX0 + getRandomInt(-8, 8))
        setPropertyFromGroup('opponentStrums', 1, 'x', defaultOpponentStrumX1 + getRandomInt(-8, 8))
        setPropertyFromGroup('opponentStrums', 2, 'x', defaultOpponentStrumX2 + getRandomInt(-8, 8))
        setPropertyFromGroup('opponentStrums', 3, 'x', defaultOpponentStrumX3 + getRandomInt(-8, 8))
        setPropertyFromGroup('opponentStrums', 0, 'y', defaultOpponentStrumY0 + getRandomInt(-8, 8))
        setPropertyFromGroup('opponentStrums', 1, 'y', defaultOpponentStrumY1 + getRandomInt(-8, 8))
        setPropertyFromGroup('opponentStrums', 2, 'y', defaultOpponentStrumY2 + getRandomInt(-8, 8))
        setPropertyFromGroup('opponentStrums', 3, 'y', defaultOpponentStrumY3 + getRandomInt(-8, 8))
end
end