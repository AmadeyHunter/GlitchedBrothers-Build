function onCreate()
makeLuaSprite('cinematicdown', nil, 0, 0);
makeGraphic('cinematicdown', screenWidth, 100, '000000');
setProperty('cinematicdown.x', 0)
setProperty('cinematicdown.y', screenHeight)
setObjectCamera('cinematicdown', 'camHUD')
addLuaSprite('cinematicdown', false);

makeLuaSprite('cinematicup', nil, 0, 0);
makeGraphic('cinematicup', screenWidth, 100, '000000');
setProperty('cinematicup.x', 0)
setProperty('cinematicup.y', -100)
setObjectCamera('cinematicup', 'camHUD')
addLuaSprite('cinematicup', false);
end

function onEvent(n,v1,v2)
	if n == "Cinematics" then
		if v1 == 'on' then
doTweenY('cinematicup', 'cinematicup', 0, v2, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, v2, 'cubeOut')
		else
doTweenY('cinematicup', 'cinematicup', -100, v2, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, v2, 'cubeOut')
		end
	end
end