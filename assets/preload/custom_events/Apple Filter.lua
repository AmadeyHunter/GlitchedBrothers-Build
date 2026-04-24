function onEvent(n,v1,v2)
	if n == "Apple Filter" then
		if v1 == 'on' then
		if v2 == 'black' then
makeLuaSprite('touhouBG', nil, -screenWidth * getProperty('camGame.zoom'), -screenHeight * getProperty('camGame.zoom'));
makeGraphic('touhouBG', screenWidth * 3, screenHeight * 3, '000000');
setScrollFactor('touhouBG');
addLuaSprite('touhouBG', false);
setProperty('boyfriend.colorTransform.blueOffset',255)
setProperty('boyfriend.colorTransform.redOffset',255)
setProperty('boyfriend.colorTransform.greenOffset',255)
setProperty('dad.colorTransform.blueOffset',255)
setProperty('dad.colorTransform.redOffset',255)
setProperty('dad.colorTransform.greenOffset',255)
setProperty('gf.colorTransform.blueOffset',255)
setProperty('gf.colorTransform.redOffset',255)
setProperty('gf.colorTransform.greenOffset',255)
		else
makeLuaSprite('touhouBG', nil, -screenWidth * getProperty('camGame.zoom'), -screenHeight * getProperty('camGame.zoom'));
makeGraphic('touhouBG', screenWidth * 3, screenHeight * 3, 'FFFFFF');
setScrollFactor('touhouBG');
addLuaSprite('touhouBG', false);
setProperty('dad.color',getColorFromHex('000000'))
setProperty('boyfriend.color',getColorFromHex('000000'))
setProperty('gf.color',getColorFromHex('000000'))
		end
		else
setProperty('boyfriend.colorTransform.blueOffset',0)
setProperty('boyfriend.colorTransform.redOffset',0)
setProperty('boyfriend.colorTransform.greenOffset',0)
setProperty('dad.colorTransform.blueOffset',0)
setProperty('dad.colorTransform.redOffset',0)
setProperty('dad.colorTransform.greenOffset',0)
setProperty('gf.colorTransform.blueOffset',0)
setProperty('gf.colorTransform.redOffset',0)
setProperty('gf.colorTransform.greenOffset',0)
setProperty('dad.color',getColorFromHex('FFFFFF'))
setProperty('boyfriend.color',getColorFromHex('FFFFFF'))
setProperty('gf.color',getColorFromHex('FFFFFF'))
setProperty('touhouBG.alpha',0)
		end
	end
end