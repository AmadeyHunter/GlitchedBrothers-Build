local healthDrain = true;
local glitchShaderIntensity = 0;
local abberationShaderIntensity = 0;
local beatShaderAmount = 0.05;

function onCreatePost()
makeLuaSprite('blackFNF', nil, 0, 0);
makeGraphic('blackFNF',screenWidth, screenHeight, '000000');
setScrollFactor('blackFNF', 1, 1);
setProperty('blackFNF.alpha',0)
addLuaSprite('blackFNF', false);
setObjectCamera('blackFNF', 'camHUD');

runHaxeCode([[
            finnT = new FlxSprite();
            finnT.x = -260;
            finnT.y = -180;
            finnT.frames = Paths.getSparrowAtlas('characters/Finn_Transformation', null, true);
            finnT.animation.addByPrefix('cutscene', 'FINN-CUTSCENE', 24, false);
            finnT.alpha = 0.0001;
            finnT.scrollFactor.set();
            game.addBehindGF(finnT);
finnT.cameras = [game.camHUD];
game.variables.set('finnT',finnT);
]])

makeLuaSprite('blackie', nil, 0, 0);
makeGraphic('blackie',screenWidth, screenHeight, '000000');
setScrollFactor('blackie', 1, 1);
setProperty('blackie.alpha',0)
addLuaSprite('blackie', false);
setObjectCamera('blackie', 'camOther');

addCharacterToList('finn-sword', 1);
addCharacterToList('finn-slash', 1);
cameraFade('camGame', '000000', 0.0001, true)
setProperty('finnBarThing.alpha', 0.0001)
setProperty('dad.alpha', 0.0001)
setProperty('iconP2.alpha', 0.0001)
setProperty('iconP1.alpha', 0.0001)
setProperty('scoreTxt.alpha', 0.0001)
    for i = 0,3 do
        setPropertyFromGroup('opponentStrums',i,'visible',false)
    end
setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-dead-finn')
setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'bffinndeath')
setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gffinnrevive')
	makeLuaSprite('pibbyFNFobject')
	makeGraphic('pibbyFNFobject', screenWidth, screenHeight)
	makeLuaSprite('chromFNFobject')
	makeGraphic('chromFNFobject', screenWidth, screenHeight)
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

local notealpha = false;

function onUpdatePost(elapsed)
glitchShaderIntensity = lerp(glitchShaderIntensity, 0, boundTo(elapsed * 7, 0, 1));
abberationShaderIntensity = lerp(abberationShaderIntensity, 0, boundTo(elapsed * 6, 0, 1));
setShaderFloat("pibbyFNFobject", "glitchMultiply", glitchShaderIntensity)
setShaderFloat("pibbyFNFobject", "uTime", os.clock())
setShaderFloat('chromFNFobject',"aberration", abberationShaderIntensity);
if notealpha == false then
    for i = 0,3 do
        setPropertyFromGroup('opponentStrums',i,'alpha',0)
    end
end
end

function opponentNoteHit(id, direction ,noteType, isSustainNote)
if not getPropertyFromGroup('notes', id, 'gfNote') then
if healthDrain then
runHaxeCode([[
if (game.health > 0.1) {
game.health -= 0.03;
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
if curStep == 1 then
runHaxeCode([[
game.camGame.fade(0xFF000000, 4.42, true);
]])
end
if curStep == 256 then
doTweenZoom('camGamezoomtag', 'camGame', 1.8, 2.83, 'quadInOut')
doTweenAlpha('blackiealphatag', 'blackie', 1, 2.83, 'quadInOut')
end
if curStep == 298 then
setProperty('dad.alpha',1)
doTweenAlpha('blackiealphatag2', 'blackie', 0, 0.25, 'quadInOut')
end
if curStep == 300 then
    for i = 0,3 do
if getPropertyFromClass('ClientPrefs','opponentStrums') then
        setPropertyFromGroup('opponentStrums',i,'visible',true)
end
        setPropertyFromGroup('opponentStrums',i,'alpha',0)
    end
notealpha = true;
runHaxeCode([[
if (!ClientPrefs.middleScroll) {
							for (i in 0...game.opponentStrums.length) {
								FlxTween.tween(game.opponentStrums.members[i], {alpha: 1}, 0.7, {
									ease: FlxEase.linear,
									onComplete:
									function (twn:FlxTween)
										{
											game.opponentStrums.members[i].alpha = 1;
										}
								});
							}
}
if (ClientPrefs.middleScroll) {
							for (i in 0...game.opponentStrums.length) {
								FlxTween.tween(game.opponentStrums.members[i], {alpha: 0.5}, 0.7, {
									ease: FlxEase.linear,
									onComplete:
									function (twn:FlxTween)
										{
											game.opponentStrums.members[i].alpha = 0.5;
										}
								});
							}
}
]])
doTweenZoom('camGamezoomtag', 'camGame', 1.1, 1.1, 'quadInOut')
end
if curStep == 320 then
doTweenAlpha('finnBarThingalphatag', 'finnBarThing', 1, 0.75, 'quadInOut')
doTweenAlpha('iconP2alphatag', 'iconP2', 1, 0.75, 'quadInOut')
doTweenAlpha('iconP1alphatag', 'iconP1', 1, 0.75, 'quadInOut')
doTweenAlpha('scoreTxtalphatag', 'scoreTxt', 1, 0.75, 'quadInOut')
end
if curStep == 1568 then
doTweenAlpha('blackFNFalphatag', 'blackFNF', 1, 0.4, 'quadInOut')
end
if curStep == 1577 then
runHaxeCode([[
finnT.alpha = 1;
finnT.animation.play('cutscene');
]])
end
if curStep == 1616 then
setProperty('blackFNF.alpha',0)
cameraFlash('camOther', 'FFFFFF', 1, true)
runHaxeCode([[
finnT.alpha = 0.0001;
]])
end
if curStep == 3712 then
cameraFade('camOther', '000000', 2.5, true)
end
end

function onBeatHit()
if curStep > 320 and curStep < 3712 then
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
if tag == 'camGamezoomtag' then
setProperty('defaultCamZoom',getProperty('defaultCamZoom'))
end
if tag == 'blackiealphatag' then
setProperty('blackie.alpha',1)
end
if tag == 'blackiealphatag2' then
setProperty('blackie.alpha',0)
end
if tag == 'finnBarThingalphatag' then
setProperty('finnBarThing.alpha',1)
end
if tag == 'iconP2alphatag' then
setProperty('iconP2.alpha',1)
end
if tag == 'iconP1alphatag' then
setProperty('iconP1.alpha',1)
end
if tag == 'scoreTxtalphatag' then
setProperty('scoreTxt.alpha',1)
end
if tag == 'blackFNFalphatag' then
setProperty('blackFNF.alpha',1)
runTimer('blackFNFtimer', 3.1, 1);
end
end

function onTimerCompleted(tag)
if tag == 'blackFNFtimer' then
setProperty('blackFNF.alpha',0)
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