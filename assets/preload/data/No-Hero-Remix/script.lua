local healthDrain = true;
local distortIntensity = 1000.0;
local glitchShaderIntensity = 0;
local abberationShaderIntensity = 0;
local beatShaderAmount = 0.05;

function onCreatePost()
makeAnimatedLuaSprite('noHeroIntro', 'noherocutscenefirst', -200, -400)
addAnimationByPrefix('noHeroIntro', 'finnJumpscareMomento', 'play', 24, true);
setObjectCamera('noHeroIntro', 'camOther');

runHaxeCode([[
game.camOther.fade(0xFF000000, 0.000001);
]])
setProperty('camHUD.alpha', 0)
setProperty('healthBar.visible', false)
setProperty('healthBarBG.visible', false)
setProperty('iconP2.color',getColorFromHex('000000'))
setProperty('scoreTxt.visible', false)
setPropertyFromClass('GameOverSubstate', 'characterName', 'assbf')
setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gffinnrevive')

	makeLuaSprite('pibbyFNFobject')
	makeGraphic('pibbyFNFobject', screenWidth, screenHeight)
	makeLuaSprite('chromFNFobject')
	makeGraphic('chromFNFobject', screenWidth, screenHeight)
	initLuaShader('glowy')
runHaxeCode([[
var pibbyFNF = game.createRuntimeShader('Pibbified');
game.getLuaObject('pibbyFNFobject').shader = pibbyFNF;
var chromFNF = game.createRuntimeShader('chromShader');
game.getLuaObject('chromFNFobject').shader = chromFNF;
chromFNF.setFloat('aberration', -0.5);
game.camHUD.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);
game.camGame.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);
]])
end

function onUpdate()
setProperty('gf.alpha', 0)
runHaxeCode([[
game.iconP2.shake(0.11, 8, 1);
]])
setShaderFloat('distortFNFobject',"binaryIntensity", distortIntensity);
end

function onUpdatePost(elapsed)
glitchShaderIntensity = lerp(glitchShaderIntensity, 0, boundTo(elapsed * 7, 0, 1));
abberationShaderIntensity = lerp(abberationShaderIntensity, 0, boundTo(elapsed * 6, 0, 1));
setShaderFloat("pibbyFNFobject", "glitchMultiply", glitchShaderIntensity)
setShaderFloat("pibbyFNFobject", "uTime", os.clock())
setShaderFloat('chromFNFobject',"aberration", abberationShaderIntensity);
end

function opponentNoteHit(id, direction ,noteType, isSustainNote)
if not getPropertyFromGroup('notes', id, 'gfNote') then
if _G['dadGhostData.strumTime'] == getPropertyFromGroup('notes', id, 'strumTime') and not isSustainNote then
if healthDrain == true then
runHaxeCode([[
if (game.health > 0.5) {
game.health -= FlxG.random.float(0.075, 0.2);
}
]])
end
end
	if not isSustainNote then
	if getRandomBool(50) then
	glitchShaderIntensity = getRandomFloat(0.2, 0.7);
	end
	end
end
if not isSustainNote then
_G['dadGhostData.strumTime'] = getPropertyFromGroup('notes', id, 'strumTime')	
end
end

function onSectionHit()
abberationShaderIntensity = beatShaderAmount;
end

function onStepHit()
distortIntensity = getRandomFloat(4, 6);
if curStep == 1 then
addLuaSprite('noHeroIntro', false);
PlayAnim('noHeroIntro', 'finnJumpscareMomento', false);
end
if curStep == 32 then
runHaxeCode([[
game.camOther.fade(0xFF000000, 0.000001, true);
]])
setProperty('camHUD.alpha',1)
removeLuaSprite('noHeroIntro', true);
cameraFlash('camGame', 'FFFFFF', 1, true)
triggerEvent('Cinematics', 'on', '1.3');
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
doTweenY('cinematicup', 'cinematicup', 0, 1.3, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 1.3, 'cubeOut')
triggerEvent('Apple Filter', 'on', 'white');
runHaxeCode([[
var pibbyFNF = game.createRuntimeShader('Pibbified');
game.getLuaObject('pibbyFNFobject').shader = pibbyFNF;
var chromFNF = game.createRuntimeShader('chromShader');
game.getLuaObject('chromFNFobject').shader = chromFNF;
chromFNF.setFloat('aberration', -0.5);

var glowy = game.createRuntimeShader('glowy');
game.camHUD.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);
game.camGame.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF),new ShaderFilter(glowy)]);
]])
makeLuaSprite('touhouBG', nil, -screenWidth * getProperty('camGame.zoom'), -screenHeight * getProperty('camGame.zoom'));
makeGraphic('touhouBG', screenWidth * 3, screenHeight * 3, 'FFFFFF');
setScrollFactor('touhouBG');
addLuaSprite('touhouBG', false);
setProperty('dad.color',getColorFromHex('000000'))
setProperty('boyfriend.color',getColorFromHex('000000'))
setProperty('gf.color',getColorFromHex('000000'))
end
if curStep == 96 then
doTweenZoom('camGamezoomtag', 'camGame', 1.24, 6.7, 'sineInOut')
end
if curStep == 176 or curStep == 180 or curStep == 184 then
setProperty('camGame.zoom',getProperty('camGame.zoom')+0.05)
end
if curStep == 192 then
triggerEvent('Cinematics', 'off', '1');
doTweenY('cinematicup', 'cinematicup', -100, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, 1, 'cubeOut')
triggerEvent('Apple Filter', 'off', 'white');
runHaxeCode([[
var pibbyFNF = game.createRuntimeShader('Pibbified');
game.getLuaObject('pibbyFNFobject').shader = pibbyFNF;
var chromFNF = game.createRuntimeShader('chromShader');
game.getLuaObject('chromFNFobject').shader = chromFNF;
chromFNF.setFloat('aberration', -0.5);
game.camHUD.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);
game.camGame.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);
]])
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
cameraFlash('camGame', 'FFFFFF', 1, true)
doTweenAlpha('camHUDalpha', 'camHUD', 1, 1, 'sineInOut')
setProperty('iconP2.color',getColorFromHex('FFFFFF'))
end
if curStep == 294 or curStep == 422 or curStep == 646 or curStep == 774 or curStep == 1110 then
setProperty('defaultCamZoom',1)
setProperty('camGame.zoom',1)
end
if curStep == 298 or curStep == 426 or curStep == 650 or curStep == 778 or curStep == 1114 then
setProperty('defaultCamZoom',1.1)
setProperty('camGame.zoom',1.1)
end
if curStep == 302 or curStep == 430 or curStep == 656 or curStep == 784 or curStep == 1118 then
setProperty('defaultCamZoom',0.8)
end
if curStep == 306 or curStep == 434 then
setProperty('defaultCamZoom',1)
setProperty('camGame.zoom',1.1)
end
if curStep == 310 or curStep == 438 then
setProperty('defaultCamZoom',1.1)
setProperty('camGame.zoom',1.1)
end
if curStep == 320 or curStep == 724 then
setProperty('defaultCamZoom',0.85)
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 368 or curStep == 400 then
setProperty('defaultCamZoom',getProperty('defaultCamZoom')+0.15)
end
if curStep == 384 or curStep == 416 then
setProperty('defaultCamZoom',getProperty('defaultCamZoom')-0.15)
end
if curStep == 448 then
setProperty('defaultCamZoom',0.85)
doTweenAlpha('camHUDalpha', 'camHUD', 0, 1, 'sineInOut')
end
if curStep == 460 then
setProperty('defaultCamZoom',1.45)
end
if curStep == 464 then
setProperty('defaultCamZoom',0.9)
doTweenAlpha('camHUDalpha', 'camHUD', 1, 1.5, 'sineInOut')
cameraFlash('camGame', 'FFFFFF', 1, true)
runHaxeCode([[
FlxG.camera.filtersEnabled = false;
game.camHUD.filtersEnabled = false;
game.opponentStrums.forEach(yeah -> yeah.shader = null);
]])
setTextFont('timeTxt','vcr.ttf')
setProperty('cnlogo.alpha',0)
animOffsetValue = 0;
end
if curStep == 592 then
cameraFlash('camGame', 'FFFFFF', 1, true)
runHaxeCode([[
FlxG.camera.filtersEnabled = true;
game.camHUD.filtersEnabled = true;
]])
setTextFont('timeTxt','finn.ttf')
setProperty('pibbyHealthbar.alpha',1)
	makeLuaSprite('distortFNFobject')
	makeGraphic('distortFNFobject', screenWidth, screenHeight)
runHaxeCode([[
var distortFNF = game.createRuntimeShader('distort');
game.getLuaObject('distortFNFobject').shader = distortFNF;
distortFNF.setFloat("negativity", 0.0);
distortFNF.setFloat("binaryIntensity", 1000.0);
game.opponentStrums.forEach(yeah -> yeah.shader = distortFNF);
]])
setProperty('cnlogo.alpha',0.5)
animOffsetValue = 20;
end
if curStep == 720 then
setProperty('defaultCamZoom',1.05)
end
if curStep == 848 then
doTweenAlpha('camHUDalpha', 'camHUD', 0, 0.7, 'sineInOut')
triggerEvent('Goofy Ahh Blammed Lights', 'on', '');
makeLuaSprite('theBlackness', nil,  -screenWidth * getProperty('camGame.zoom'), -screenHeight * getProperty('camGame.zoom'));
makeGraphic('theBlackness',screenWidth * 3, screenHeight * 3, '000000');
setScrollFactor('theBlackness');
setProperty('theBlackness.alpha',0)
addLuaSprite('theBlackness', false);
doTweenAlpha('theBlacknessalpha', 'theBlackness', 1, 0.7, 'linear')
runHaxeCode([[
FlxTween.color(game.boyfriend, 0.7, 0xFFFFFFFF, 0xff31a2fd, {ease: FlxEase.quadInOut});
FlxTween.color(game.gf, 0.7, 0xFFFFFFFF, 0xff31a2fd, {ease: FlxEase.quadInOut});
FlxTween.color(game.dad, 0.7, 0xFFFFFFFF, 0xff31a2fd, {ease: FlxEase.quadInOut});
]])
end
if curStep == 869 then
setProperty('camHUD.alpha',1)
setProperty('camHUD.zoom',getProperty('camHUD.zoom')+1)
end
if curStep == 880 then
setProperty('defaultCamZoom',1.25)
cameraFlash('camGame', 'FFFFFF', 1, true)
triggerEvent('Goofy Ahh Blammed Lights', 'off', '');
doTweenAlpha('theBlacknessalpha', 'theBlackness', 0, 0.7, 'linear')
runHaxeCode([[
FlxTween.color(game.boyfriend, 0.7, 0xff31a2fd, 0xFFFFFFFF, {ease: FlxEase.quadInOut});
FlxTween.color(game.gf, 0.7, 0xff31a2fd, 0xFFFFFFFF, {ease: FlxEase.quadInOut});
FlxTween.color(game.dad, 0.7, 0xff31a2fd, 0xFFFFFFFF, {ease: FlxEase.quadInOut});
]])
end
if curStep == 982 then
setProperty('defaultCamZoom',1.35)
end
if curStep == 986 then
setProperty('defaultCamZoom',1.45)
end
if curStep == 990 then
setProperty('defaultCamZoom',1.55)
end
if curStep == 994 then
setProperty('defaultCamZoom',1.25)
end
if curStep == 998 then
setProperty('defaultCamZoom',1.35)
end
if curStep == 1008 then
setProperty('defaultCamZoom',0.86)
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 1126 then
setProperty('defaultCamZoom',1)
end
if curStep == 1136 then
doTweenZoom('camGamezoomtag2', 'camGame', 0.84, 4, 'sineInOut')
end
if curStep == 1264 then
runHaxeCode([[
game.camGame.fade(0xFF000000, 0.55);
]])
doTweenAlpha('camHUDalpha', 'camHUD', 0.001, 0.5, 'sineInOut')
end
end

function onBeatHit()
if curStep > 192 and curStep < 296 or curStep > 320 and curStep < 424 or curStep > 592 and curStep < 648 or curStep > 592 and curStep < 645 or curStep > 656 and curStep < 719 or curStep > 725 and curStep < 773 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
end

function onTweenCompleted(tag)
if tag == 'camGamezoomtag' then
doTweenAlpha('camHUDalpha', 'camHUD', 0, 1, 'sineInOut')
end
if tag == 'camGamezoomtag2' then
setProperty('defaultCamZoom',0.84)
end
end

function lerp(a, b, t)
    return (1-t)*a + t*b
end

function boundTo(val, min, max)
    if val < min then
        return min
    elseif val > max then
        return max
    else
        return val
    end
end