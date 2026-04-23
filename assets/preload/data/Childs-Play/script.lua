local healthDrain = true;
local distortIntensity = 1000.0;
local glitchShaderIntensity = 0;
local abberationShaderIntensity = 0;
local beatShaderAmount = 0.05;

function onCreatePost()
healthDrain = false;
runHaxeCode([[
for (i in 0...game.opponentStrums.length) {
game.opponentStrums.members[i].shader = null;
}
]])
setPropertyFromClass('GameOverSubstate', 'characterName', 'gumdead')
setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'new_gumball_death')
setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gfgumballrevive')
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
setProperty('gf.alpha',0)
setShaderFloat('distortFNFobject',"binaryIntensity", distortIntensity);
end

function onUpdatePost(elapsed)
glitchShaderIntensity = lerp(glitchShaderIntensity, 0, boundTo(elapsed * 7, 0, 1));
abberationShaderIntensity = lerp(abberationShaderIntensity, 0, boundTo(elapsed * 6, 0, 1));
setShaderFloat("pibbyFNFobject", "glitchMultiply", glitchShaderIntensity)
setShaderFloat("pibbyFNFobject", "uTime", os.clock())
setShaderFloat('chromFNFobject',"aberration", abberationShaderIntensity);
end

function onSongStart()
runHaxeCode([[
game.songLength = (152000);
]])
end

function opponentNoteHit(id, direction ,noteType, isSustainNote)
if not getPropertyFromGroup('notes', id, 'gfNote') then
if healthDrain then
runHaxeCode([[
if (game.health > 0.1) {
game.health -= 0.0075;
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

local fakeSongLength = 152000

function onStepHit()
distortIntensity = getRandomFloat(4, 6);
if curStep == 1 then
setProperty('camHUD.alpha',1)
cameraFlash('camOther', '000000', 10.67, true)
end
if curStep == 64 then
doTweenZoom('camGamezoomtag', 'camGame', 1.4, 9.33, 'smoothStepInOut')
end
if curStep == 128 then
setProperty('defaultCamZoom',1.2)
end
if curStep == 256 then
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
]])
end
if curStep == 352 then
doTweenZoom('camGamezoomtag2', 'camGame', 1.4, 5.33, 'smoothStepInOut')
end
if curStep == 400 then
runHaxeCode([[
game.moveCamera(true);
]])
end
if curStep == 410 then
setProperty('defaultCamZoom',1.2)
end
if curStep == 416 then
healthDrain = true;
setProperty('health',1)
setProperty('camGame.alpha',1)
setProperty('camHUD.alpha',1)
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 672 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 928 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 1198 then
triggerEvent('Cinematics', 'on', '3');
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
doTweenY('cinematicup', 'cinematicup', 0, 3, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 3, 'cubeOut')
runHaxeCode([[
			var songLengthTween:FlxTween;
		 	songLengthTween = FlxTween.num(]]..fakeSongLength..[[, 198390, 3, {ease: FlxEase.linear}, function(num) { game.songLength = (num); });
							FlxTween.tween(game.camGame, {zoom: 1.5}, 3, {
								ease: FlxEase.quadInOut,
								onComplete: 
								function (twn:FlxTween)
									{
                                        if (ClientPrefs.flashing) {
                                            game.camGame.flash(0xFFFFFFFF, 1);
                                        }
                                            game.health = 0.1;
                                        game.triggerEventNote('Apple Filter', 'on', 'black');
var pibbyFNF = game.createRuntimeShader('Pibbified');
game.getLuaObject('pibbyFNFobject').shader = pibbyFNF;
var chromFNF = game.createRuntimeShader('chromShader');
game.getLuaObject('chromFNFobject').shader = chromFNF;
chromFNF.setFloat('aberration', -0.5);

var glowy = game.createRuntimeShader('glowy');
game.camHUD.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);
game.camGame.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF),new ShaderFilter(glowy)]);
						touhouBG = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
							-FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, 0xFF000000);
						game.boyfriend.colorTransform.blueOffset = 255;
						game.boyfriend.colorTransform.redOffset = 255;
						game.boyfriend.colorTransform.greenOffset = 255;
						game.dad.colorTransform.blueOffset = 255;
						game.dad.colorTransform.redOffset = 255;
						game.dad.colorTransform.greenOffset = 255;
                            game.gf.colorTransform.blueOffset = 255;
                            game.gf.colorTransform.redOffset = 255;
                            game.gf.colorTransform.greenOffset = 255;
						touhouBG.scrollFactor.set();
						game.addBehindGF(touhouBG);
game.variables.set('touhouBG',touhouBG);
                if (!ClientPrefs.lowQuality) game.getLuaObject('wall').alpha = 0.0001;
                if (!ClientPrefs.lowQuality) game.getLuaObject('vignette2').alpha = 0.0001; 
                if (!ClientPrefs.lowQuality) game.getLuaObject('vignette').alpha = 0.0001; 
                if (!ClientPrefs.lowQuality) game.getLuaObject('light').alpha = 0.0001; 
                if (!ClientPrefs.lowQuality) game.getLuaObject('daGloop').alpha = 0.0001;
                if (!ClientPrefs.lowQuality) game.getLuaObject('daGloop2').alpha = 0.0001;
										game.defaultCamZoom = 1.4;
									}
							});
]])
end
if curStep == 1456 then
runHaxeCode([[
			var songLengthTween:FlxTween;
		 	songLengthTween = FlxTween.num(]]..fakeSongLength..[[, FlxG.sound.music.length, 1.92, {ease: FlxEase.linear}, function(num) { game.songLength = (num); });
]])
end
if curStep == 1472 then
setProperty('defaultCamZoom',1.2)
cameraFlash('camGame', 'FFFFFF', 1.5, true)
triggerEvent('Apple Filter', 'off', 'black');
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
runHaxeCode([[
                if (!ClientPrefs.lowQuality) game.getLuaObject('wall').alpha = 1;
                if (!ClientPrefs.lowQuality) game.getLuaObject('vignette2').alpha = 1;
                if (!ClientPrefs.lowQuality) game.getLuaObject('vignette').alpha = 1;
                if (!ClientPrefs.lowQuality) game.getLuaObject('light').alpha = 1;
                if (!ClientPrefs.lowQuality) game.getLuaObject('daGloop').alpha = 1;
                if (!ClientPrefs.lowQuality) game.getLuaObject('daGloop2').alpha = 1;
]])
end
if curStep == 1728 then
setProperty('defaultCamZoom',1.2)
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 1984 then
triggerEvent('Cinematics', 'off', '2');
doTweenY('cinematicup', 'cinematicup', -100, 2, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, 2, 'cubeOut')
end
if curStep == 2192 then
runHaxeCode([[
							FlxTween.tween(game.camGame, {zoom: 1.4}, 6.63, {
								ease: FlxEase.quadInOut,
								onComplete: 
								function (twn:FlxTween)
									{
										game.defaultCamZoom = game.defaultCamZoom;
										game.camGame.alpha = 0;
										game.camHUD.alpha = 0;
									}
							});
]])
end
end

function onBeatHit()
if curStep > 672 and curStep < 1183 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 1472 and curStep < 1984 then
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
setProperty('defaultCamZoom',getProperty('defaultCamZoom'))
end
if tag == 'camGamezoomtag2' then
setProperty('defaultCamZoom',getProperty('defaultCamZoom'))
setProperty('camGame.alpha',0)
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