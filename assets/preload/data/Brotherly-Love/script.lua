local healthDrain = true;
local glitchShaderIntensity = 0;
local abberationShaderIntensity = 0;
local beatShaderAmount = 0.05;

function onCreatePost()
setPropertyFromClass('GameOverSubstate', 'characterName', 'jake_death')
setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'bfjakedeath')
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
game.health -= 0.025;
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
setProperty('defaultCamZoom',1.2)
end
if curStep == 506 then
setProperty('camHUD.angle',0)
setProperty('camGame.angle',0)
setProperty('camHUD.x',0)
setProperty('camGame.x',0)
setProperty('camGame.scroll.y',0)
end
if curStep == 890 then
setProperty('camHUD.angle',0)
setProperty('camGame.angle',0)
setProperty('camHUD.x',0)
setProperty('camGame.x',0)
setProperty('camGame.scroll.y',0)
end
if curStep == 1013 then
runHaxeCode([[
game.camHUD.fade(0xFF000000, 0.9, false, function() {
game.camHUD.fade(0xFF000000, 0.2, true);
});
]])
end
if curStep == 1440 then
runHaxeCode([[
game.camHUD.fade(0xFFFFFFFF, 6, false, function() {
game.camHUD.fade(0xFFFFFFFF, 0.75, true);
});
]])
end
if curStep == 1520 then
setProperty('camGame.alpha',0)
end
if curStep == 1536 then
setProperty('camGame.alpha',1)
end
if curStep == 1792 then
setProperty('camHUD.angle',0)
setProperty('camGame.angle',0)
setProperty('camHUD.x',0)
setProperty('camGame.x',0)
setProperty('camGame.scroll.y',0)
end
if curStep == 3337 then
setProperty('camHUD.angle',0)
setProperty('camGame.angle',0)
setProperty('camHUD.x',0)
setProperty('camGame.x',0)
setProperty('camGame.scroll.y',0)
doTweenAlpha('camHUDalphatag', 'camHUD', 0, 1, 'linear')
runHaxeCode([[
FlxG.camera.fade();
]])
end
end

local angleshit = 1;
local anglevar = 1;

function onBeatHit()
if curStep > 256 and curStep < 496 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
if curStep % 4 == 0 then
doTweenY('camHUDy', 'camHUD', -12, stepCrochet * 0.002, 'circOut')
doTweenY('camGamescrolly', 'camGame.scroll', 12, stepCrochet * 0.002, 'sineIn')
end
if curStep % 4 == 2 then
doTweenY('camHUDy', 'camHUD', 0, stepCrochet * 0.002, 'sineIn')
doTweenY('camGamescrolly', 'camGame.scroll', 0, stepCrochet * 0.002, 'sineIn')
end
if curBeat % 2 == 0 then
angleshit = anglevar;
else
angleshit = -anglevar;
end
setProperty('camHUD.angle',angleshit * 1.5)
setProperty('camGame.angle',angleshit * 1.5)
doTweenAngle('camHUDangle', 'camHUD', angleshit, stepCrochet * 0.002, 'circOut')
doTweenAngle('camGameangle', 'camGame', angleshit, stepCrochet * 0.002, 'circOut')
doTweenX('camHUDx', 'camHUD', -angleshit*2, crochet * 0.001, 'linear')
doTweenX('camGamex', 'camGame', -angleshit*2, crochet * 0.001, 'linear')
end
end
if curStep > 512 and curStep < 880 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
if curStep % 4 == 0 then
doTweenY('camHUDy', 'camHUD', -12, stepCrochet * 0.002, 'circOut')
doTweenY('camGamescrolly', 'camGame.scroll', 12, stepCrochet * 0.002, 'sineIn')
end
if curStep % 4 == 2 then
doTweenY('camHUDy', 'camHUD', 0, stepCrochet * 0.002, 'sineIn')
doTweenY('camGamescrolly', 'camGame.scroll', 0, stepCrochet * 0.002, 'sineIn')
end
if curBeat % 2 == 0 then
angleshit = anglevar;
else
angleshit = -anglevar;
end
setProperty('camHUD.angle',angleshit * 1.5)
setProperty('camGame.angle',angleshit * 1.5)
doTweenAngle('camHUDangle', 'camHUD', angleshit, stepCrochet * 0.002, 'circOut')
doTweenAngle('camGameangle', 'camGame', angleshit, stepCrochet * 0.002, 'circOut')
doTweenX('camHUDx', 'camHUD', -angleshit*2, crochet * 0.001, 'linear')
doTweenX('camGamex', 'camGame', -angleshit*2, crochet * 0.001, 'linear')
end
end
if curStep > 1536 and curStep < 1792 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
if curStep % 4 == 0 then
doTweenY('camHUDy', 'camHUD', -12, stepCrochet * 0.002, 'circOut')
doTweenY('camGamescrolly', 'camGame.scroll', 12, stepCrochet * 0.002, 'sineIn')
end
if curStep % 4 == 2 then
doTweenY('camHUDy', 'camHUD', 0, stepCrochet * 0.002, 'sineIn')
doTweenY('camGamescrolly', 'camGame.scroll', 0, stepCrochet * 0.002, 'sineIn')
end
if curBeat % 2 == 0 then
angleshit = anglevar;
else
angleshit = -anglevar;
end
setProperty('camHUD.angle',angleshit * 1.5)
setProperty('camGame.angle',angleshit * 1.5)
doTweenAngle('camHUDangle', 'camHUD', angleshit, stepCrochet * 0.002, 'circOut')
doTweenAngle('camGameangle', 'camGame', angleshit, stepCrochet * 0.002, 'circOut')
doTweenX('camHUDx', 'camHUD', -angleshit*2, crochet * 0.001, 'linear')
doTweenX('camGamex', 'camGame', -angleshit*2, crochet * 0.001, 'linear')
end
end
if curStep > 2304 and curStep < 3327 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
if curStep % 4 == 0 then
doTweenY('camHUDy', 'camHUD', -12, stepCrochet * 0.002, 'circOut')
doTweenY('camGamescrolly', 'camGame.scroll', 12, stepCrochet * 0.002, 'sineIn')
end
if curStep % 4 == 2 then
doTweenY('camHUDy', 'camHUD', 0, stepCrochet * 0.002, 'sineIn')
doTweenY('camGamescrolly', 'camGame.scroll', 0, stepCrochet * 0.002, 'sineIn')
end
if curBeat % 2 == 0 then
angleshit = anglevar;
else
angleshit = -anglevar;
end
setProperty('camHUD.angle',angleshit * 1.5)
setProperty('camGame.angle',angleshit * 1.5)
doTweenAngle('camHUDangle', 'camHUD', angleshit, stepCrochet * 0.002, 'circOut')
doTweenAngle('camGameangle', 'camGame', angleshit, stepCrochet * 0.002, 'circOut')
doTweenX('camHUDx', 'camHUD', -angleshit*2, crochet * 0.001, 'linear')
doTweenX('camGamex', 'camGame', -angleshit*2, crochet * 0.001, 'linear')
end
end
end

function onEvent(n,v1,v2)
	if n == "Apple Filter" then
		if v1 == 'on' then
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
		else
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
	end
end

function onTweenCompleted(tag)
if tag == 'camHUDalphatag' then
setProperty('camHUD.alpha',0)
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