local healthDrain = true;
local distortIntensity = 1000.0;
local glitchShaderIntensity = 0;
local abberationShaderIntensity = 0;
local beatShaderAmount = 0.05;

function onCreatePost()
	makeLuaSprite('distortFNFobject')
	makeGraphic('distortFNFobject', screenWidth, screenHeight)
	makeLuaSprite('pibbyFNFobject')
	makeGraphic('pibbyFNFobject', screenWidth, screenHeight)
	makeLuaSprite('chromFNFobject')
	makeGraphic('chromFNFobject', screenWidth, screenHeight)
	initLuaShader('glowy')
runHaxeCode([[
var distortFNF = game.createRuntimeShader('distort');
game.getLuaObject('distortFNFobject').shader = distortFNF;
distortFNF.setFloat("negativity", 0.0);
distortFNF.setFloat("binaryIntensity", 1000.0);
var pibbyFNF = game.createRuntimeShader('Pibbified');
game.getLuaObject('pibbyFNFobject').shader = pibbyFNF;
var chromFNF = game.createRuntimeShader('chromShader');
game.getLuaObject('chromFNFobject').shader = chromFNF;
chromFNF.setFloat('aberration', -0.5);
game.camHUD.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);
game.camGame.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);

			iconP3 = new HealthIcon(game.gf.healthIcon, true);
			iconP3.y = game.healthBar.y - 112;
			iconP3.visible = !ClientPrefs.hideHud;
			iconP3.alpha = ClientPrefs.healthBarAlpha;
			game.addBehindGF(iconP3);

			iconP3.cameras = [game.camHUD];

game.variables.set('iconP3',iconP3);
]])
setProperty('defaultCamZoom',1.18)
setProperty('boyfriend.color',getColorFromHex('969494'))
setProperty('dad.color',getColorFromHex('969494'))
setProperty('gf.color',getColorFromHex('969494'))
setPropertyFromClass('GameOverSubstate', 'characterName', 'gumdead')
setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'new_gumball_death')
setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gfgumballrevive')

makeLuaSprite('blackFNF', nil, 0, 0);
makeGraphic('blackFNF',screenWidth, screenHeight, '000000');
setScrollFactor('blackFNF', 1, 1);
setProperty('blackFNF.alpha',0)
setObjectCamera('blackFNF', 'camHUD')
addLuaSprite('blackFNF', false);

setProperty('iconP3.visible',true)
end

local isCameraOnForcedPos = false;

function onUpdate(elapsed)
if isCameraOnForcedPos then
setProperty('camFollow.x', 1050)
setProperty('camFollow.y', ((getProperty('dad.y') + getProperty('opponentCameraOffset[1]')) + (getProperty('boyfriend.y') + getProperty('boyfriendCameraOffset[1]')) ) / 2)
end
setShaderFloat('distortFNFobject',"binaryIntensity", distortIntensity);
setProperty('iconP3.x',530 + 75);
mult = lerp(0.8, getProperty('iconP3.scale.x'), boundTo(1 - (elapsed * 9 * getProperty('playbackRate')), 0, 1));
setProperty('iconP3.scale.x',mult)
setProperty('iconP3.scale.y',mult)
updateHitbox('iconP3')
end

function onUpdatePost(elapsed)
glitchShaderIntensity = lerp(glitchShaderIntensity, 0, boundTo(elapsed * 7, 0, 1));
abberationShaderIntensity = lerp(abberationShaderIntensity, 0, boundTo(elapsed * 6, 0, 1));
setShaderFloat("pibbyFNFobject", "glitchMultiply", glitchShaderIntensity)
setShaderFloat("pibbyFNFobject", "uTime", os.clock())
setShaderFloat('chromFNFobject',"aberration", abberationShaderIntensity);
runHaxeCode([[
        if (game.healthBar.percent < 20){
	iconP3.shader = game.getLuaObject('distortFNFobject').shader;
	iconP3.animation.curAnim.curFrame = 1;
        }else{
            iconP3.shader = null;
	iconP3.animation.curAnim.curFrame = 0;
        }
]])
end

function opponentNoteHit(id, direction ,noteType, isSustainNote)
if not getPropertyFromGroup('notes', id, 'gfNote') then
if healthDrain then
runHaxeCode([[
if (game.health > 0.1) {
game.health -= 0.0175;
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

function goodNoteHit(id, direction ,noteType, isSustainNote)
if not getPropertyFromGroup('notes', id, 'gfNote') then
runHaxeCode([[
iconP3.changeIcon(game.gf.healthIcon);
]])
else
runHaxeCode([[
iconP3.changeIcon(game.boyfriend.healthIcon);
]])
end
end

function onStartCountdown()
runHaxeCode([[
game.getLuaObject('bfIntro').color = 0xff969494;
]])
end

function onSongStart()
runHaxeCode([[
game.songLength = (150290);
]])
end

function onSectionHit()
abberationShaderIntensity = beatShaderAmount;
end

function onStepHit()
distortIntensity = getRandomFloat(4, 6);
if curStep == 1 then
runHaxeCode([[
game.moveCamera(true);
]])
setProperty('defaultCamZoom',1.3)
triggerEvent('Cinematics', 'on', '18.525');
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
doTweenY('cinematicup', 'cinematicup', 0, 18.525, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 18.525, 'cubeOut')
runHaxeCode([[
game.camOther.fade(0xFF000000, 18.525, true);
]])
doTweenZoom('camGamezoomtag', 'camGame', 0.9, 18.525, 'quadInOut')
end
if curStep == 248 then
isCameraOnForcedPos = true;
setProperty('camFollow.x', 1050)
setProperty('camFollow.y', ((getProperty('dad.y') + getProperty('opponentCameraOffset[1]')) + (getProperty('boyfriend.y') + getProperty('boyfriendCameraOffset[1]')) ) / 2)
doTweenZoom('camGamezoomtag2', 'camGame', 0.7, 0.675, 'quadInOut')
triggerEvent('Cinematics', 'off', '0.675');
doTweenY('cinematicup', 'cinematicup', -100, 0.675, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, 0.675, 'cubeOut')
doTweenAlpha('camHUDalpha', 'camHUD', 1, 2, 'cubeOut')
end
if curStep == 256 then
cameraFlash('camGame', 'FFFFFF', 1, true)
setProperty('defaultCamZoom',0.7)
isCameraOnForcedPos = false;
end
if curStep == 384 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 512 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 1024 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 1152 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 1280 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 1408 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 1520 then
doTweenAlpha('blackFNFalphatag', 'blackFNF', 1, 1.15, 'linear')
doTweenZoom('camGamezoomtag3', 'camGame', 1.6, 1.15, 'linear')
end
if curStep == 1536 then
setProperty('blackFNF.alpha', 0)
setProperty('defaultCamZoom', 0.7)
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 1664 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 1792 then
setProperty('defaultCamZoom', 1.2)
end
if curStep == 1816 then
setProperty('camHUD.alpha', 0)
doTweenZoom('camGamezoomtag4', 'camGame', 1.25, 0.00075, 'quadInOut')
end
if curStep == 1818 then
doTweenZoom('camGamezoomtag5', 'camGame', 1.3, 0.00075, 'quadInOut')
end
if curStep == 1820 then
doTweenZoom('camGamezoomtag6', 'camGame', 1.4, 0.00075, 'quadInOut')
end
if curStep == 1824 then
setProperty('camHUD.alpha', 1)
setProperty('defaultCamZoom', 0.7)
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 1920 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 2048 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 2064 then
cameraFlash('camGame', 'FFFFFF', 1, true)
glitchShaderIntensity = 2;
runHaxeCode([[
game.camHUD.shake(FlxG.random.float(0.025, 0.1), FlxG.random.float(0.075, 0.125));
game.songLength = (FlxG.sound.music.length);
]])
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
setProperty('wtf.visible',false)
doTweenAngle('boyfriendangle3', 'boyfriend', 0, 0.00001, 'sineInOut')
doTweenAngle('dadangle3', 'dad', 0, 0.00001, 'sineInOut')
doTweenAngle('gfangle3', 'gf', 0, 0.00001, 'sineInOut')
makeLuaSprite('touhouBG', nil, -screenWidth * getProperty('camGame.zoom'), -screenHeight * getProperty('camGame.zoom'));
makeGraphic('touhouBG', screenWidth * 3, screenHeight * 3, 'FFFFFF');
setScrollFactor('touhouBG');
addLuaSprite('touhouBG', false);
setProperty('dad.color',getColorFromHex('000000'))
setProperty('boyfriend.color',getColorFromHex('000000'))
setProperty('gf.color',getColorFromHex('000000'))
end
end

function onBeatHit()
    runHaxeCode([[
				iconP3.scale.set(1, 1);
				iconP3.updateHitbox();
    ]])
if curStep > 256 and curStep < 512 then
if curBeat % 2 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 512 and curStep < 752 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 1024 and curStep < 1271 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 1280 and curStep < 1520 then
if curBeat % 2 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 1536 and curStep < 1791 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 1816 and curStep < 2048 then
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
	if tag == 'boyfriendangle3' then
doTweenAngle('boyfriendangle3', 'boyfriend', 0, 0.00001, 'sineInOut')
	end
	if tag == 'dadangle3' then
doTweenAngle('dadangle3', 'dad', 0, 0.00001, 'sineInOut')
	end
	if tag == 'gfangle3' then
doTweenAngle('gfangle3', 'gf', 0, 0.00001, 'sineInOut')
	end
if tag == 'camGamezoomtag' then
setProperty('defaultCamZoom',0.9)
end
if tag == 'camGamezoomtag2' then
setProperty('defaultCamZoom',0.7)
end
if tag == 'blackFNFalphatag' then
setProperty('blackFNF.alpha', 1)
runTimer('blackFNFtimer', 0.001, 1);
end
if tag == 'camGamezoomtag3' then
setProperty('defaultCamZoom',1.6)
end
if tag == 'camGamezoomtag4' then
setProperty('defaultCamZoom',1.25)
end
if tag == 'camGamezoomtag5' then
setProperty('defaultCamZoom',1.3)
end
if tag == 'camGamezoomtag6' then
setProperty('defaultCamZoom',1.4)
end
end

function onTimerCompleted(tag)
if tag == 'blackFNFtimer' then
setProperty('blackFNF.alpha',0)
setProperty('defaultCamZoom',0.7)
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