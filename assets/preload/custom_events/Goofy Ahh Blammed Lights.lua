function onCreate()
makeLuaSprite('theBlackness', nil,  -screenWidth * getProperty('camGame.zoom'), -screenHeight * getProperty('camGame.zoom'));
makeGraphic('theBlackness',screenWidth * 3, screenHeight * 3, '000000');
setScrollFactor('theBlackness', 1, 1);
setProperty('theBlackness.alpha',0)
addLuaSprite('theBlackness', false);
end

function onEvent(n,v1,v2)
	if n == "Goofy Ahh Blammed Lights" then
		if v1 == 'on' then
doTweenAlpha('theBlacknessalpha', 'theBlackness', 1, 0.7, 'linear')
runHaxeCode([[
FlxTween.color(game.boyfriend, 0.7, 0xFFFFFF, 0xff31a2fd, {ease: FlxEase.quadInOut});
FlxTween.color(game.gf, 0.7, 0xFFFFFF, 0xff31a2fd, {ease: FlxEase.quadInOut});
FlxTween.color(game.dad, 0.7, 0xFFFFFF, 0xff31a2fd, {ease: FlxEase.quadInOut});
]])
		end
		if v1 == 'off' then
doTweenAlpha('theBlacknessalpha', 'theBlackness', 0, 0.7, 'linear')
runHaxeCode([[
FlxTween.color(game.boyfriend, 0.7, 0xff31a2fd, 0xFFFFFF, {ease: FlxEase.quadInOut});
FlxTween.color(game.gf, 0.7, 0xff31a2fd, 0xFFFFFF, {ease: FlxEase.quadInOut});
FlxTween.color(game.dad, 0.7, 0xff31a2fd, 0xFFFFFF, {ease: FlxEase.quadInOut});
]])
		end
	end
end