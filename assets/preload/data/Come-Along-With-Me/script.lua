local healthDrain = true;
local distortIntensity = 1000.0;
local glitchShaderIntensity = 0;
local abberationShaderIntensity = 0;
local beatShaderAmount = 0.05;

function onCreatePost()
makeLuaSprite('theBlackness', nil,  -screenWidth * getProperty('camGame.zoom'), -screenHeight * getProperty('camGame.zoom'));
makeGraphic('theBlackness',screenWidth * 3, screenHeight * 3, '000000');
setScrollFactor('theBlackness');
setProperty('theBlackness.alpha',0)
addLuaSprite('theBlackness', false);

makeLuaSprite('blackie', nil, 0, 0);
makeGraphic('blackie',screenWidth, screenHeight, '000000');
setScrollFactor('blackie', 1, 1);
setProperty('blackie.alpha',0)
addLuaSprite('blackie', false);
setObjectCamera('blackie', 'camOther');
runHaxeCode([[
for (i in 0...game.opponentStrums.length) {
game.opponentStrums.members[i].shader = null;
}
]])
makeLuaSprite('camShitforReveal', 'CameraShtuff', 0, 0);
screenCenter('camShitforReveal');
setObjectCamera('camShitforReveal', 'camOther');
addLuaSprite('camShitforReveal', false)
runHaxeCode([[
game.camOther.fade(0xFF000000, 0.000001);
]])
setProperty('camHUD.alpha',0)
setProperty('iconP2.alpha',0.0001)
setProperty('iconP1.alpha',0.0001)
setProperty('boyfriend.color',getColorFromHex('9791FF'))
setProperty('finnBarThing.alpha',0.0001)
setProperty('scoreTxt.alpha',1)
setProperty('boyfriendGroup.visible',false)
addCharacterToList('finn-sword', 1);
addCharacterToList('finncawm_reveal', 1);
addCharacterToList('bfcawn', 0);
addCharacterToList('finncawn', 1);
setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-dead-finn')
setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'bffinndeath')
setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gffinnrevive')
	makeLuaSprite('pibbyFNFobject')
	makeGraphic('pibbyFNFobject', screenWidth, screenHeight)
	makeLuaSprite('chromFNFobject')
	makeGraphic('chromFNFobject', screenWidth, screenHeight)
	makeLuaSprite('blurFNFZoomEditionobject')
	makeGraphic('blurFNFZoomEditionobject', screenWidth, screenHeight)
	makeLuaSprite('blurFNFZoomEditionHUDobject')
	makeGraphic('blurFNFZoomEditionHUDobject', screenWidth, screenHeight)
	initLuaShader('blurZoom')
runHaxeCode([[
var pibbyFNF = game.createRuntimeShader('Pibbified');
game.getLuaObject('pibbyFNFobject').shader = pibbyFNF;
var chromFNF = game.createRuntimeShader('chromShader');
game.getLuaObject('chromFNFobject').shader = chromFNF;
chromFNF.setFloat('aberration', -0.5);
var blurFNFZoomEdition = game.createRuntimeShader('blurZoom');
game.getLuaObject('blurFNFZoomEditionobject').shader = blurFNFZoomEdition;
var blurFNFZoomEditionHUD = game.createRuntimeShader('blurZoom');
game.getLuaObject('blurFNFZoomEditionHUDobject').shader = blurFNFZoomEditionHUD;
game.camHUD.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF),new ShaderFilter(blurFNFZoomEdition)]);
game.camGame.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF),new ShaderFilter(blurFNFZoomEditionHUD)]);

var distortCAWMFNF = game.createRuntimeShader('distort');
game.getLuaObject('distortCAWMFNFobject').shader = distortCAWMFNF;
distortCAWMFNF.setFloat("negativity", 0.0);
distortCAWMFNF.setFloat("binaryIntensity", 1000.0);
]])
setShaderFloat("blurFNFZoomEditionobject", "posX", 0.5)
setShaderFloat("blurFNFZoomEditionobject", "posY", 0.5)
setShaderFloat("blurFNFZoomEditionobject", "focusPower", 6)
setShaderFloat("blurFNFZoomEditionHUDobject", "posX", 0.5)
setShaderFloat("blurFNFZoomEditionHUDobject", "posY", 0.5)
setShaderFloat("blurFNFZoomEditionHUDobject", "focusPower", 2)
end

function onUpdate()
setShaderFloat('distortFNFobject',"binaryIntensity", distortIntensity);
end

local distortdad = false;
local canShakeNote = true;

function onUpdatePost(elapsed)
glitchShaderIntensity = lerp(glitchShaderIntensity, 0, boundTo(elapsed * 7, 0, 1));
abberationShaderIntensity = lerp(abberationShaderIntensity, 0, boundTo(elapsed * 6, 0, 1));
setShaderFloat("pibbyFNFobject", "glitchMultiply", glitchShaderIntensity)
setShaderFloat("pibbyFNFobject", "uTime", os.clock())
setShaderFloat('chromFNFobject',"aberration", abberationShaderIntensity);
if not canShakeNote then
        setPropertyFromGroup('opponentStrums', 0, 'x', defaultOpponentStrumX0)
        setPropertyFromGroup('opponentStrums', 1, 'x', defaultOpponentStrumX1)
        setPropertyFromGroup('opponentStrums', 2, 'x', defaultOpponentStrumX2)
        setPropertyFromGroup('opponentStrums', 3, 'x', defaultOpponentStrumX3)
        setPropertyFromGroup('opponentStrums', 0, 'y', defaultOpponentStrumY0)
        setPropertyFromGroup('opponentStrums', 1, 'y', defaultOpponentStrumY1)
        setPropertyFromGroup('opponentStrums', 2, 'y', defaultOpponentStrumY2)
        setPropertyFromGroup('opponentStrums', 3, 'y', defaultOpponentStrumY3)
end
if distortdad == true then
runHaxeCode([[
game.dad.shader = game.getLuaObject('distortFNFobject').shader;
]])
end
end

function opponentNoteHit(id, direction ,noteType, isSustainNote)
if noteType == 'Glitch Note' then
distortdad = false;
end
if not getPropertyFromGroup('notes', id, 'gfNote') then
if healthDrain then
runHaxeCode([[
if (game.health > 0.1) {
game.health -= 0.0225;
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
doTweenAlpha('camHUDalphatag', 'camHUD', 0, 1, 'linear')
end
if curStep == 36 then
runHaxeCode([[
							game.camOther.fade(0xFF000000, 5, true);
							for (i in 0...game.opponentStrums.length) {
								game.opponentStrums.members[i].visible = false;
								game.opponentStrums.members[i].alpha = 0;
							}
							for (i in 0...game.playerStrums.length) {
								game.playerStrums.members[i].visible = false;
								game.playerStrums.members[i].alpha = 0;
							}
]])
end
if curStep == 128 then
setProperty('camHUD.alpha',1)
cameraFlash('camOther', 'FFFFFF', 1, true)
runHaxeCode([[
							for (i in 0...game.opponentStrums.length) {
								if(ClientPrefs.opponentStrums) game.opponentStrums.members[i].visible = true;
								if(!ClientPrefs.middleScroll) game.opponentStrums.members[i].alpha = 1;
								if(ClientPrefs.middleScroll) game.opponentStrums.members[i].alpha = 0.5;
							}
]])
end
if curStep == 186 then
runHaxeCode([[
							for (i in 0...game.playerStrums.length) {
								game.playerStrums.members[i].visible = true;
								game.playerStrums.members[i].alpha =	0.0001;
								FlxTween.tween(game.playerStrums.members[i], {alpha: 1}, 0.5, {
									ease: FlxEase.linear,
									onComplete:
									function (twn:FlxTween)
										{
											game.playerStrums.members[i].alpha = 1;
										}
								});
							}
]])
end
if curStep == 378 then
doTweenAlpha('camHUDalphatag', 'camHUD', 0, 0.25, 'linear')
setProperty('defaultCamZoom',1.35)
end
if curStep == 384 then
	makeLuaSprite('distortFNFobject')
	makeGraphic('distortFNFobject', screenWidth, screenHeight)
runHaxeCode([[
var distortFNF = game.createRuntimeShader('distort');
game.getLuaObject('distortFNFobject').shader = distortFNF;
distortFNF.setFloat("negativity", 0.0);
distortFNF.setFloat("binaryIntensity", 1000.0);
for (i in 0...game.opponentStrums.length) {
game.opponentStrums.members[i].shader = game.getLuaObject('distortFNFobject').shader;
}
game.dad.shader = game.getLuaObject('distortFNFobject').shader;
]])
distortdad = true;
setProperty('defaultCamZoom',0.9)
cameraFlash('camOther', 'FFFFFF', 1, true)
doTweenAlpha('camHUDalphatag2', 'camHUD', 1, 0.25, 'linear')
end
if curStep == 608 then
doTweenAlpha('theBlacknessalpha', 'theBlackness', 1, 0.6, 'sineInOut')
end
if curStep == 628 then
cameraFlash('camOther', 'FFFFFF', 0.3, true)
end
if curStep == 640 then
doTweenAlpha('finnBarThingalpha', 'finnBarThing', 1, 0.25, 'quadInOut')
triggerEvent('Change Character', 'Dad', 'finncawm_reveal');
setProperty('defaultCamZoom',0.75)
if not getPropertyFromClass('ClientPrefs','lowQuality') then
makeLuaSprite('vig', 'vignette', 0, 0);
screenCenter('vig');
setObjectCamera('vig', 'camOther');
addLuaSprite('vig', false)
end
setShaderFloat("blurFNFZoomEditionobject", "focusPower", 0)
setShaderFloat("blurFNFZoomEditionHUDobject", "focusPower", 0)
doTweenAlpha('theBlacknessalpha', 'theBlackness', 0, 0.6, 'sineInOut')
end
if curStep == 656 then
setProperty('defaultCamZoom',0.85)
end
if curStep == 672 then
setProperty('defaultCamZoom',0.75)
end
if curStep == 720 then
setProperty('defaultCamZoom',0.9)
end
if curStep == 736 then
setProperty('defaultCamZoom',0.85)
end
if curStep == 848 then
runHaxeCode([[
FlxG.camera.fade(0xFF000000, 3.52);
]])
end
if curStep == 896 then
cameraFlash('camGame', 'FFFFFF', 1, true)
runHaxeCode([[
FlxG.camera.fade(0xFF000000, 0.0000001, true);
]])
setProperty('boyfriendGroup.visible',true)
runHaxeCode([[
game.dad.x = game.DAD_X - 200;
game.dad.y = game.DAD_Y - 0;
]])
fuckyouDadX = getProperty('dad.x');
fuckyouDadY = getProperty('dad.y');
end
if curStep == 960 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 1024 then
doTweenZoom('camGamezoomtag', 'camGame', 0.9, 0.75, 'quadInOut')
end
if curStep == 1032 then
setProperty('camHUD.alpha', 0)
doTweenZoom('camGamezoomtag2', 'camGame', 1, 0.00075, 'quadInOut')
end
if curStep == 1034 then
doTweenZoom('camGamezoomtag3', 'camGame', 1.1, 0.00075, 'quadInOut')
end
if curStep == 1036 then
doTweenZoom('camGamezoomtag4', 'camGame', 1.2, 0.00075, 'quadInOut')
end
if curStep == 1040 then
setProperty('camHUD.alpha',1)
setProperty('defaultCamZoom',0.8)
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 1280 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 1520 then
runHaxeCode([[
FlxG.camera.fade(0xFF000000, 1.18);
]])
doTweenZoom('camGamezoomtag3', 'camGame', 1.1, 1.18, 'quadInOut')
end
if curStep == 1535 then
setProperty('boyfriendGroup.visible',false)
runHaxeCode([[
FlxG.camera.fade(0xFF000000, 10, true);
]])
end
if curStep == 1536 then
cameraFlash('camHUD', 'FFFFFF', 2.5, true)
runHaxeCode([[
game.dad.x = game.DAD_X + 260;
game.dad.y = game.DAD_Y + 250;
]])
triggerEvent('Change Character', 'Dad', 'finncawm_start_new');
setProperty('defaultCamZoom',getProperty('defaultCamZoom')+0.35)
setProperty('cameraSpeed',50)
runTimer('cameraSpeedtimer', 0.0461, 1);
end
if curStep == 1648 then
triggerEvent('Change Character', 'Dad', 'finncawm_reveal');
cameraFlash('camGame', 'FFFFFF', 0.3, true)
end
if curStep == 1664 then
cameraFlash('camGame', 'FFFFFF', 1, true)
triggerEvent('Change Character', 'Dad', 'finn-sword-sha');
setProperty('dad.x', fuckyouDadX)
setProperty('dad.y', fuckyouDadY)
setProperty('boyfriendGroup.visible', true)
end
if curStep == 1775 then
doTweenAlpha('blackiealpha', 'blackie', 1, 1, 'linear')
runHaxeCode([[
							for (i in 0...game.opponentStrums.length) {
								FlxTween.tween(game.opponentStrums.members[i], {alpha: 0}, 1);
							}
]])
end
if curStep == 1792 then
cameraFlash('camOther', 'FFFFFF', 1.33, true)
setProperty('blackie.alpha', 0)
setProperty('theBlackness.alpha', 1)
triggerEvent('Change Character', 'Dad', 'finncawn');
triggerEvent('Change Character', 'BF', 'bfcawn');
setObjectCamera('dad', 'camHUD')
setObjectCamera('boyfriend', 'camHUD')
setProperty('boyfriend.angle', 180)
setProperty('dad.x', 80)
setProperty('dad.y', screenHeight + 100)
setProperty('boyfriend.x', 750)
setProperty('boyfriend.y', -340)
doTweenY('boyfriendy', 'boyfriend', 40, 1, 'sineInOut')
doTweenY('dady', 'dad', 260, 1, 'sineInOut')
canShakeNote = false;

runHaxeCode([[
							for (i in 0...game.playerStrums.length) {
								FlxTween.tween(game.playerStrums.members[i], {alpha: 1}, 1.15, {onStart: goofyAhh -> {
									if (!ClientPrefs.middleScroll) {
										if (!ClientPrefs.downScroll) {
									game.playerStrums.forEach(yeah -> {
										FlxTween.tween(yeah, {x: yeah.x - 620}, 2.1, {ease: FlxEase.quadInOut});
									});
								}}}});
							}
]])
setProperty('timeBar.alpha', 0)
setProperty('timeBarBG.alpha', 0)
setProperty('timeTxt.alpha', 1)
setProperty('scoreTxt.alpha', 0)
setProperty('finnBarThing.alpha', 0)
setProperty('iconP1.alpha', 0)
setProperty('iconP2.alpha', 0)
end
if curStep == 2176 then
runHaxeCode([[
							for (i in 0...game.playerStrums.length) {
								FlxTween.tween(game.playerStrums.members[i], {alpha: 0}, 6.34, {
									ease: FlxEase.linear,
									onComplete:
									function (twn:FlxTween)
										{
											game.playerStrums.members[i].alpha = 0;
										}
								});
							}
]])
doTweenAlpha('botplayTxtalphatag', 'botplayTxt', 0, 6.34, 'linear')
doTweenAlpha('timeBaralphatag', 'timeBar', 0, 6.34, 'linear')
doTweenAlpha('timeTxtalphatag', 'timeTxt', 0, 6.34, 'linear')
doTweenAlpha('timeBarBGalphatag', 'timeBarBG', 0, 6.34, 'linear')
runHaxeCode([[
							for (i in 0...game.opponentStrums.length) {
								FlxTween.tween(game.opponentStrums.members[i], {alpha: 0}, 6.34, {
									ease: FlxEase.linear,
									onComplete:
									function (twn:FlxTween)
										{
											game.opponentStrums.members[i].alpha = 0;
										}
								});
							}
]])
end
if curStep == 2432 then
setProperty('blackie.alpha', 1)
runHaxeCode([[
game.dad.cameras = [game.camHUD];
game.boyfriend.cameras = [game.camHUD];
]])
triggerEvent('Change Character', 'Dad', 'finncawn');
triggerEvent('Change Character', 'BF', 'bfcawn');
setProperty('boyfriend.angle', 180)
setProperty('dad.x', 400)
setProperty('dad.y', 730)
setProperty('boyfriend.x', 800)
setProperty('boyfriend.y', 640)
end
end

function onBeatHit()
if curStep > 832 and curStep < 888 then
if curBeat % 2 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 896 and curStep < 1024 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 1040 and curStep < 1264 then
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
if curStep > 1792 and curStep < 2176 then
if curBeat % 2 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
end

function onTweenCompleted(tag)
if tag == 'camHUDalphatag' then
setProperty('camHUD.alpha', 0)
end
if tag == 'camHUDalphatag2' then
setProperty('camHUD.alpha', 1)
end
if tag == 'finnBarThingalpha' then
setProperty('finnBarThing.alpha', 1)
doTweenAlpha('iconP1alpha', 'iconP1', 1, 0.15, 'quadInOut')
doTweenAlpha('iconP2alpha', 'iconP2', 1, 0.15, 'quadInOut')
end
if tag == 'camGamezoomtag' then
setProperty('defaultCamZoom',0.9)
end
if tag == 'camGamezoomtag2' then
setProperty('defaultCamZoom',1)
end
if tag == 'camGamezoomtag3' then
setProperty('defaultCamZoom',1.1)
end
if tag == 'camGamezoomtag4' then
setProperty('defaultCamZoom',1.2)
end
if tag == 'botplayTxtalphatag' then
setProperty('botplayTxt.alpha',0)
end
if tag == 'timeBaralphatag' then
setProperty('timeBar.alpha',0)
end
if tag == 'timeTxtalphatag' then
setProperty('timeTxt.alpha',0)
end
if tag == 'timeBarBGalphatag' then
setProperty('timeBarBG.alpha',0)
end
end

function onTimerCompleted(tag)
if tag == 'cameraSpeedtimer' then
setProperty('cameraSpeed',1)
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