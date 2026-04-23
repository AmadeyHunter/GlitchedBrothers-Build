local healthDrain = true;
local distortIntensity = 1000.0;
local glitchShaderIntensity = 0;
local abberationShaderIntensity = 0;
local beatShaderAmount = 0.05;

function onCreate()
    addHaxeLibrary('MP4Handler','vlc')
    addHaxeLibrary('Event', 'openfl.events')
end

function onCreatePost()
addCharacterToList('darwinfw', 0);
setProperty('gf.alpha', 0)
setPropertyFromClass('GameOverSubstate', 'characterName', 'darwindeath')
setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'glitchhit')
setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd')
cameraFade('camOther', '000000', 0.000001, true)
setProperty('camHUD.alpha', 0)
setProperty('healthBar.visible',false)
setProperty('healthBarBG.visible',false)
setProperty('pibbyHealthbar.visible',false)
setProperty('iconP1.visible',false)
setProperty('iconP2.visible',false)
setProperty('scoreTxt.visible',false)
	makeLuaSprite('pibbyFNFobject')
	makeGraphic('pibbyFNFobject', screenWidth, screenHeight)
	makeLuaSprite('chromFNFobject')
	makeGraphic('chromFNFobject', screenWidth, screenHeight)
	makeLuaSprite('mawFNFobject')
	makeGraphic('mawFNFobject', screenWidth, screenHeight)
	makeLuaSprite('fwGlitchobject')
	makeGraphic('fwGlitchobject', screenWidth, screenHeight)
	initLuaShader('glowy')
	initLuaShader('fwGlitch')
runHaxeCode([[
var pibbyFNF = game.createRuntimeShader('Pibbified');
game.getLuaObject('pibbyFNFobject').shader = pibbyFNF;
var chromFNF = game.createRuntimeShader('chromShader');
game.getLuaObject('chromFNFobject').shader = chromFNF;
chromFNF.setFloat('aberration', -0.5);
game.camHUD.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);
game.camGame.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);
]])
makeLuaSprite('blackie', nil, 0, 0);
makeGraphic('blackie',screenWidth, screenHeight, '000000');
setScrollFactor('blackie', 1, 1);
setProperty('blackie.alpha',0)
addLuaSprite('blackie', false);
setObjectCamera('blackie', 'camOther');
end

local isCameraOnForcedPos = false;

function onUpdate()
setProperty('gf.alpha',0)
if isCameraOnForcedPos then
triggerEvent('Camera Follow Pos', '1520', '970');
end
setShaderFloat('distortFNFobject',"binaryIntensity", distortIntensity);
setShaderFloat("fwGlitchobject", "iTime", os.clock())
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
if healthDrain then
runHaxeCode([[
if (game.health > 0.1) {
game.health -= 0.02;
}
]])
end
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
setProperty('boyfriend.y',getProperty('boyfriend.y')+42)
triggerEvent('Camera Follow Pos', '1520', '970');
isCameraOnForcedPos = true;
triggerEvent('Cinematics', 'on', '10.11');
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
doTweenY('cinematicup', 'cinematicup', 0, 10.11, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 10.11, 'cubeOut')
setProperty('camHUD.alpha',0)
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
runHaxeCode([[
game.camGame.fade(0xFF000000, 0.000001, true);
game.camOther.fade(0xFF000000, 10.11, true);
]])
end
if curStep == 256 then
cameraFlash('camGame', 'FFFFFF', 1, true)
triggerEvent('Cinematics', 'off', '1.5');
doTweenY('cinematicup', 'cinematicup', -100, 1.5, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, 1.5, 'cubeOut')
triggerEvent('Camera Follow Pos', '', '');
isCameraOnForcedPos = false;
setProperty('camHUD.alpha', 1)
end
if curStep == 497 then
setProperty('defaultCamZoom', 0.75)
end
if curStep == 501 then
setProperty('defaultCamZoom', 0.9)
end
if curStep == 505 then
setProperty('defaultCamZoom', 1.1)
end
if curStep == 514 then
cameraFlash('camGame', 'FFFFFF', 1.5, true)
setProperty('defaultCamZoom', 0.7)
end
if curStep == 515 then
cameraFlash('camGame', 'FFFFFF', 1.5, true)
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
end
if curStep == 562 then
setProperty('defaultCamZoom', 0.85)
end
if curStep == 578 then
setProperty('defaultCamZoom', 0.7)
end
if curStep == 627 then
setProperty('defaultCamZoom', 0.95)
end
if curStep == 643 then
cameraFlash('camGame', 'FFFFFF', 1.5, true)
setProperty('defaultCamZoom', 0.7)
end
if curStep == 756 then
doTweenZoom('camGamezoomtag', 'camGame', 0.8, 1, 'quadInOut')
end
if curStep == 772 then
triggerEvent('Cinematics', 'on', '1');
doTweenY('cinematicup', 'cinematicup', 0, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 1, 'cubeOut')
end
if curStep == 788 then
setProperty('defaultCamZoom', 0.95)
end
if curStep == 803 then
doTweenZoom('camGamezoomtag', 'camGame', 0.8, 0.075, 'quadInOut')
end
if curStep == 805 then
doTweenZoom('camGamezoomtag2', 'camGame', 0.7, 0.075, 'quadInOut')
end
if curStep == 854 then
setProperty('defaultCamZoom', 0.95)
end
if curStep == 868 then
doTweenZoom('camGamezoomtag', 'camGame', 0.8, 0.075, 'quadInOut')
end
if curStep == 870 then
doTweenZoom('camGamezoomtag2', 'camGame', 0.7, 0.075, 'quadInOut')
end
if curStep == 902 then
cameraFlash('camGame', 'FFFFFF', 1, true)
triggerEvent('Cinematics', 'off', '1');
doTweenY('cinematicup', 'cinematicup', -100, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, 1, 'cubeOut')
setProperty('defaultCamZoom', 1)
end
if curStep == 967 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 1032 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 1180 then
setProperty('pibbyHealthbar.alpha',0)
setProperty('blackie.alpha',1)
end
if curStep == 1190 then
setProperty('defaultCamZoom', 0.7)
setProperty('health', 0.5)
end
if curStep == 1440 then
triggerEvent('Cinematics', 'on', '1');
doTweenY('cinematicup', 'cinematicup', 0, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 1, 'cubeOut')
cameraFlash('camGame', 'FFFFFF', 1, true)
setProperty('pibbyHealthbar.alpha',1)
setProperty('blackie.alpha',0)
	makeLuaSprite('distortFNFobject')
	makeGraphic('distortFNFobject', screenWidth, screenHeight)
runHaxeCode([[
var distortFNF = game.createRuntimeShader('distort');
game.getLuaObject('distortFNFobject').shader = distortFNF;
distortFNF.setFloat("negativity", 0.0);
distortFNF.setFloat("binaryIntensity", 1000.0);
game.playerStrums.forEach(strum -> strum.shader = distortFNF);
]])
setProperty('boyfriend.color',getColorFromHex('bababa'))
setProperty('dad.color',getColorFromHex('bababa'))
makeLuaSprite('vig', 'vignette', 0, 0);
setScrollFactor('vig', 1, 1);
setObjectCamera('vig', 'camOther')
screenCenter('vig')
addLuaSprite('vig', false);
end
if curStep == 1706 then
triggerEvent('Cinematics', 'off', '1');
doTweenY('cinematicup', 'cinematicup', -100, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, 1, 'cubeOut')
cameraFlash('camGame', 'FFFFFF', 1, true)
setProperty('defaultCamZoom', 0.8)
end
if curStep == 1822 then
setProperty('defaultCamZoom', 0.85)
end
if curStep == 1830 then
setProperty('defaultCamZoom', 0.9)
end
if curStep == 1838 then
triggerEvent('Cinematics', 'on', '1');
doTweenY('cinematicup', 'cinematicup', 0, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 1, 'cubeOut')
cameraFlash('camGame', 'FFFFFF', 1, true)
setProperty('defaultCamZoom', 1)
end
if curStep == 1972 then
triggerEvent('Cinematics', 'off', '1');
doTweenY('cinematicup', 'cinematicup', -100, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, 1, 'cubeOut')
setProperty('defaultCamZoom', 0.7)
end
if curStep == 1988 then
cameraFlash('camGame', 'FFFFFF', 1, true)
runHaxeCode([[
var pibbyFNF = game.createRuntimeShader('Pibbified');
game.getLuaObject('pibbyFNFobject').shader = pibbyFNF;
var chromFNF = game.createRuntimeShader('chromShader');
game.getLuaObject('chromFNFobject').shader = chromFNF;
chromFNF.setFloat('aberration', -0.5);
var glitchFWFNF = game.createRuntimeShader('fwGlitch');
game.getLuaObject('fwGlitchobject').shader = glitchFWFNF;
game.camHUD.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);
game.camGame.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF),new ShaderFilter(glitchFWFNF)]);
]])
end
if curStep == 2038 then
setProperty('defaultCamZoom', 0.85)
end
if curStep == 2055 then
setProperty('defaultCamZoom', 0.7)
end
if curStep == 2105 then
setProperty('defaultCamZoom', 0.95)
end
if curStep == 2121 then
setProperty('defaultCamZoom', 0.9)
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 2155 then
setProperty('defaultCamZoom', 1)
end
if curStep == 2389 then
cameraFlash('camOther', 'FFFFFF', 1, true)
fullPibbyHealthbar = true;
setProperty('camGame.alpha', 0)
setProperty('camHUD.alpha', 0)
end
if curStep == 2610 then
doTweenAlpha('camHUDalphatag', 'camHUD', 1, 1, 'linear')
setProperty('timeBar.alpha',0)
setProperty('timeTxt.alpha',0)
setProperty('timeBarBG.alpha',0)
runHaxeCode([[
game.playerStrums.forEach(playerNotes -> playerNotes.alpha = 0);
]])
end
if curStep == 2715 then
cameraFlash('camOther', 'FFFFFF', 1, true)
setProperty('camHUD.alpha', 0)
end
end

function onBeatHit()
if curStep > 514 and curStep < 772 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 902 and curStep < 1163 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 1440 and curStep < 1822 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 1838 and curStep < 1972 then
if curBeat % 2 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 1988 and curStep < 2255 then
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
setProperty('defaultCamZoom',0.7)
end
if tag == 'camGamezoomtag2' then
setProperty('defaultCamZoom',0.8)
end
if tag == 'camHUDalphatag' then
setProperty('camHUD.alpha',1)
end
end

function getIconColor(chr)
	return getColorFromHex(rgbToHex(getProperty(chr .. ".healthColorArray")))
end

function rgbToHex(array)
	return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
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