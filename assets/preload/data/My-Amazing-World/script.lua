local healthDrain = true;
local distortIntensity = 1000.0;
local glitchShaderIntensity = 0;
local abberationShaderIntensity = 0;
local beatShaderAmount = 0.05;

function onCreatePost()
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

setProperty('gf.alpha', 0)
runHaxeCode([[
game.moveCamera(true);
game.camOther.fade(0xFF000000, 0.000001);
]])
setProperty('camHUD.alpha', 0)
setProperty('defaultCamZoom',1.7)
setPropertyFromClass('GameOverSubstate', 'characterName', 'gumdead')
setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'new_gumball_death')
setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gfgumballrevive')
	makeLuaSprite('pibbyFNFobject')
	makeGraphic('pibbyFNFobject', screenWidth, screenHeight)
	makeLuaSprite('chromFNFobject')
	makeGraphic('chromFNFobject', screenWidth, screenHeight)
	makeLuaSprite('mawFNFobject')
	makeGraphic('mawFNFobject', screenWidth, screenHeight)
	initLuaShader('glowy')
initLuaShader('monitor')
initLuaShader('MAWVHS')
runHaxeCode([[
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

        makeLuaText('lyricTxt','',screenWidth,0,getProperty('healthBarBG.y')-72)
    setTextSize('lyricTxt',48)
    setTextAlignment('lyricTxt','CENTER')
    setTextFont('lyricTxt','gumball.ttf')
setProperty('lyricTxt.color',getIconColor('dad'))
    setTextBorder('lyricTxt', 1.25, '000000')
setProperty('lyricTxt.alpha',0)
if getPropertyFromClass('ClientPrefs','downScroll') then
setProperty('lyricTxt.y',getProperty('healthBarBG.y')+72)
end
    addLuaText('lyricTxt')
    setObjectCamera('lyricTxt','camOther')

        makeLuaText('channelTxt','',screenWidth,-400,90)
    setTextSize('channelTxt',56)
    setTextAlignment('channelTxt','CENTER')
    setTextFont('channelTxt','vcr.ttf')
setProperty('channelTxt.color',getColorFromHex('00FF00'))
    setTextBorder('channelTxt', 1.25, '000000')
    setObjectCamera('channelTxt','camHUD')
setScrollFactor('channelTxt');
    addLuaText('channelTxt')

setProperty('iconP3.visible',false)
end

function onUpdate(elapsed)
setShaderFloat("mawFNFobject", "iTime", os.clock())
setProperty('iconP3.x',530 + 75);
mult = lerp(0.8, getProperty('iconP3.scale.x'), boundTo(1 - (elapsed * 9 * getProperty('playbackRate')), 0, 1));
setProperty('iconP3.scale.x',mult)
setProperty('iconP3.scale.y',mult)
updateHitbox('iconP3')
end

function onUpdatePost(elapsed)
setShaderFloat('distortFNFobject',"binaryIntensity", distortIntensity);
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
game.health -= 0.0150;
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

function onSectionHit()
abberationShaderIntensity = beatShaderAmount;
end

function onStepHit()
distortIntensity = getRandomFloat(4, 6);
if curStep == 1 then
triggerEvent('Cinematics', 'on', '9.6');
doTweenY('cinematicup', 'cinematicup', 0, 9.6, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 9.6, 'cubeOut')
setProperty('camHUD.alpha', 1)
runHaxeCode([[
game.camGame.fade(0x101010, 0.000001, true);
game.camOther.fade(0xFF000000, 9.6, true);
]])
doTweenZoom('camGamezoomtag3', 'camGame', 1.1, 9.6, 'linear')
end
if curStep == 128 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 240 then
setProperty('defaultCamZoom', 1)
end
if curStep == 246 then
setProperty('defaultCamZoom', 1.1)
end
if curStep == 252 then
setProperty('defaultCamZoom', 1.2)
end
if curStep == 256 then
triggerEvent('Cinematics', 'off', '0.4');
doTweenY('cinematicup', 'cinematicup', -100, 0.4, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, 0.4, 'cubeOut')
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 384 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 492 then
setProperty('defaultCamZoom', 1)
end
if curStep == 498 then
setProperty('defaultCamZoom', 1.1)
end
if curStep == 504 then
setProperty('defaultCamZoom', 1.2)
end
if curStep == 512 then
cameraFlash('camGame', 'FFFFFF', 1, true)
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

                if (!ClientPrefs.lowQuality) game.getLuaObject('wall').alpha = 0.0001;
                if (!ClientPrefs.lowQuality) game.getLuaObject('vignette2').alpha = 0.0001; 
                if (!ClientPrefs.lowQuality) game.getLuaObject('vignette').alpha = 0.0001; 
                if (!ClientPrefs.lowQuality) game.getLuaObject('light').alpha = 0.0001; 
                if (!ClientPrefs.lowQuality) daGloop.alpha = 0.0001;
                if (!ClientPrefs.lowQuality) daGloop2.alpha = 0.0001;
]])
makeLuaSprite('touhouBG', nil, -screenWidth * getProperty('camGame.zoom'), -screenHeight * getProperty('camGame.zoom'));
makeGraphic('touhouBG', screenWidth * 3, screenHeight * 3, 'FFFFFF');
setScrollFactor('touhouBG');
addLuaSprite('touhouBG', false);
setProperty('dad.color',getColorFromHex('000000'))
setProperty('boyfriend.color',getColorFromHex('000000'))
setProperty('gf.color',getColorFromHex('000000'))
triggerEvent('Cinematics', 'on', '1.2');
doTweenY('cinematicup', 'cinematicup', 0, 1.2, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 1.2, 'cubeOut')
end
if curStep == 768 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 1008 then
triggerEventNote('Cinematics', 'off', '0.6');
doTweenY('cinematicup', 'cinematicup', -100, 0.6, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, 0.6, 'cubeOut')
end
if curStep == 1024 then
triggerEvent('Apple Filter', 'off', 'white');
runHaxeCode([[
var pibbyFNF = game.createRuntimeShader('Pibbified');
game.getLuaObject('pibbyFNFobject').shader = pibbyFNF;
var chromFNF = game.createRuntimeShader('chromShader');
game.getLuaObject('chromFNFobject').shader = chromFNF;
chromFNF.setFloat('aberration', -0.5);
game.camHUD.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);
game.camGame.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);

                if (!ClientPrefs.lowQuality) game.getLuaObject('wall').alpha = 1;
                if (!ClientPrefs.lowQuality) game.getLuaObject('vignette2').alpha = 1; 
                if (!ClientPrefs.lowQuality) game.getLuaObject('vignette').alpha = 1; 
                if (!ClientPrefs.lowQuality) game.getLuaObject('light').alpha = 1; 
                if (!ClientPrefs.lowQuality) daGloop.alpha = 1;
                if (!ClientPrefs.lowQuality) daGloop2.alpha = 1;
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
setProperty('camGame.zoom',1.7)
triggerEvent('Cinematics', 'on', '4.8');
doTweenY('cinematicup', 'cinematicup', 0, 4.8, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 4.8, 'cubeOut')
runHaxeCode([[
game.camOther.fade(000000, 4.8, true);
]])
doTweenZoom('camGamezoomtag3', 'camGame', 1.1, 9.6, 'linear')
end
if curStep == 1080 then
triggerEvent('Cinematics', 'off', '1');
doTweenY('cinematicup', 'cinematicup', -100, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, 1, 'cubeOut')
end
if curStep == 1280 then
setProperty('defaultCamZoom',1.3)
triggerEvent('Cinematics', 'on', '0.6');
doTweenY('cinematicup', 'cinematicup', 0, 0.6, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 0.6, 'cubeOut')
end
if curStep == 1296 then
setProperty('defaultCamZoom',1.1)
end
if curStep == 1424 then
doTweenZoom('camGamezoomtag3', 'camGame', 1.8, 9.6, 'linear')
end
if curStep == 1520 then
setProperty('gf.alpha',1)
setProperty('boyfriend.alpha',0.3)
end
if curStep == 1552 then
doTweenAlpha('lyricTxtalpha', 'lyricTxt', 1, 0.05, 'linear')
setProperty('lyricTxt.color',getColorFromHex('FF784B'))
setProperty('camGame.alpha',0)
setTextString('lyricTxt','GUMBALL!')
end
if curStep == 1560 then
setProperty('lyricTxt.color',getColorFromHex('52A5EB'))
setTextString('lyricTxt','D')
runTimer('0.01875timer', 0.01875, 1);
end
if curStep == 1568 then
setPropertyFromClass('GameOverSubstate', 'characterName', 'darwindeath')
setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'glitchhit')
setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd')
hiCameraPleaseFocusOnGfPleaseAndThankYou = true;
setTextString('lyricTxt','')
setProperty('camGame.alpha',1)
setProperty('iconP3.visible',true)
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

                if (!ClientPrefs.lowQuality) game.getLuaObject('wall').alpha = 0.0001;
                if (!ClientPrefs.lowQuality) game.getLuaObject('vignette2').alpha = 0.0001; 
                if (!ClientPrefs.lowQuality) game.getLuaObject('vignette').alpha = 0.0001; 
                if (!ClientPrefs.lowQuality) game.getLuaObject('light').alpha = 0.0001; 
                if (!ClientPrefs.lowQuality) daGloop.alpha = 0.0001;
                if (!ClientPrefs.lowQuality) daGloop2.alpha = 0.0001;
]])
setProperty('touhouBG.alpha',1)
setProperty('dad.color',getColorFromHex('000000'))
setProperty('boyfriend.color',getColorFromHex('000000'))
setProperty('gf.color',getColorFromHex('000000'))
cameraFlash('camGame', 'FFFFFF', 1, true)
triggerEvent('Cinematics', 'on', '1');
doTweenY('cinematicup', 'cinematicup', 0, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 1, 'cubeOut')
doTweenZoom('camGamezoomtag3', 'camGame', 0.9, 9.6, 'linear')
end
if curStep == 1824 then
triggerEvent('Apple Filter', 'off', 'white');
runHaxeCode([[
var pibbyFNF = game.createRuntimeShader('Pibbified');
game.getLuaObject('pibbyFNFobject').shader = pibbyFNF;
var chromFNF = game.createRuntimeShader('chromShader');
game.getLuaObject('chromFNFobject').shader = chromFNF;
chromFNF.setFloat('aberration', -0.5);
game.camHUD.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);
game.camGame.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);

                if (!ClientPrefs.lowQuality) game.getLuaObject('wall').alpha = 1;
                if (!ClientPrefs.lowQuality) game.getLuaObject('vignette2').alpha = 1; 
                if (!ClientPrefs.lowQuality) game.getLuaObject('vignette').alpha = 1; 
                if (!ClientPrefs.lowQuality) game.getLuaObject('light').alpha = 1; 
                if (!ClientPrefs.lowQuality) daGloop.alpha = 1;
                if (!ClientPrefs.lowQuality) daGloop2.alpha = 1;
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
triggerEvent('Cinematics', 'off', '1');
doTweenY('cinematicup', 'cinematicup', -100, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, 1, 'cubeOut')
end
if curStep == 1696 then
runHaxeCode([[
game.moveCamera(true);
]])
end
if curStep == 1952 then
runHaxeCode([[
game.moveCamera(true);
]])
end
if curStep == 2016 then
runHaxeCode([[
game.moveCamera(true);
]])
end
if curStep == 2064 then
runHaxeCode([[
game.moveCamera(true);
]])
end
if curStep == 2080 then
runHaxeCode([[
							for (i in 0...game.opponentStrums.length) {
								game.opponentStrums.members[i].alpha = 0;
							}
]])
cameraFlash('camOther', 'FFFFFF', 1.75, true)
triggerEvent('Cinematics', 'on', '1.8');
doTweenY('cinematicup', 'cinematicup', 0, 1.8, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 1.8, 'cubeOut')
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

                if (!ClientPrefs.lowQuality) game.getLuaObject('wall').alpha = 0.0001;
                if (!ClientPrefs.lowQuality) game.getLuaObject('vignette2').alpha = 0.0001; 
                if (!ClientPrefs.lowQuality) game.getLuaObject('vignette').alpha = 0.0001; 
                if (!ClientPrefs.lowQuality) game.getLuaObject('light').alpha = 0.0001; 
                if (!ClientPrefs.lowQuality) daGloop.alpha = 0.0001;
                if (!ClientPrefs.lowQuality) daGloop2.alpha = 0.0001;
]])
setProperty('touhouBG.alpha',1)
setProperty('dad.color',getColorFromHex('000000'))
setProperty('boyfriend.color',getColorFromHex('000000'))
setProperty('gf.color',getColorFromHex('000000'))
setProperty('boyfriend.alpha',0)
end
if curStep == 2112 then
doTweenAlpha('lyricTxtalpha', 'lyricTxt', 1, 0.05, 'linear')
setTextString('lyricTxt','THE DARKNESS...')
runTimer('lyricTxtalpha0timer', 0.675, 1);
runHaxeCode([[
game.moveCamera(true);
]])
end
if curStep == 2128 then
doTweenAlpha('lyricTxtalpha', 'lyricTxt', 1, 0.05, 'linear')
setTextString('lyricTxt',"IT'S CALLING ME...")
runTimer('lyricTxtalpha0timer', 0.675, 1);
end
if curStep == 2144 then
setTextString('lyricTxt','')
setProperty('iconP3.visible',false)
changeChannel(1);
runHaxeCode([[
							for (i in 0...game.opponentStrums.length) {
								if(!ClientPrefs.middleScroll) game.opponentStrums.members[i].alpha = 1;
								if(ClientPrefs.middleScroll) game.opponentStrums.members[i].alpha = 0.5;
							}
]])
setTextString('lyricTxt','')
setProperty('defaultCamZoom',0.8)
triggerEvent('Apple Filter', 'off', 'white');
runHaxeCode([[
var pibbyFNF = game.createRuntimeShader('Pibbified');
game.getLuaObject('pibbyFNFobject').shader = pibbyFNF;
var chromFNF = game.createRuntimeShader('chromShader');
game.getLuaObject('chromFNFobject').shader = chromFNF;
chromFNF.setFloat('aberration', -0.5);
game.camHUD.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);
game.camGame.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);

                if (!ClientPrefs.lowQuality) game.getLuaObject('wall').alpha = 1;
                if (!ClientPrefs.lowQuality) game.getLuaObject('vignette2').alpha = 1; 
                if (!ClientPrefs.lowQuality) game.getLuaObject('vignette').alpha = 1; 
                if (!ClientPrefs.lowQuality) game.getLuaObject('light').alpha = 1; 
                if (!ClientPrefs.lowQuality) daGloop.alpha = 1;
                if (!ClientPrefs.lowQuality) daGloop2.alpha = 1;
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
setProperty('dad.x',getProperty('dad.x')+150)
cameraFlash('camOther', 'FFFFFF', 1, true)
triggerEvent('Cinematics', 'off', '1');
doTweenY('cinematicup', 'cinematicup', -100, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, 1, 'cubeOut')
setProperty('dad.y',getProperty('dad.y') + 30)
runHaxeCode([[
var pibbyFNF = game.createRuntimeShader('Pibbified');
game.getLuaObject('pibbyFNFobject').shader = pibbyFNF;
var chromFNF = game.createRuntimeShader('chromShader');
game.getLuaObject('chromFNFobject').shader = chromFNF;
chromFNF.setFloat('aberration', -0.5);
var crtFNF = game.createRuntimeShader('monitor');
var mawFNF = game.createRuntimeShader('MAWVHS');
game.getLuaObject('mawFNFobject').shader = mawFNF;
game.camOther.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF),new ShaderFilter(crtFNF)]);
game.camHUD.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF),new ShaderFilter(crtFNF)]);
game.camGame.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF),new ShaderFilter(crtFNF),new ShaderFilter(mawFNF)]);
]])
end
if curStep == 2176 then
changeChannel(2);
doTweenZoom('camGamezoomtag', 'camGame', 1.1, 0.00075, 'quadInOut')
end
if curStep == 2208 then
changeChannel(3);
doTweenZoom('camGamezoomtag2', 'camGame', 0.8, 0.00075, 'quadInOut')
end
if curStep == 2272 then
changeChannel(1);
end
if curStep == 2304 then
changeChannel(2);
doTweenZoom('camGamezoomtag', 'camGame', 1.1, 0.00075, 'quadInOut')
end
if curStep == 2336 then
changeChannel(3);
doTweenZoom('camGamezoomtag2', 'camGame', 0.8, 0.00075, 'quadInOut')
end
if curStep == 2400 then
changeChannel(1);
setProperty('camGame.zoom', 1.7)
triggerEvent('Cinematics', 'on', '4.8');
doTweenY('cinematicup', 'cinematicup', 0, 4.8, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 4.8, 'cubeOut')
runHaxeCode([[
game.camGame.fade(0xFF000000, 4.8, true);
]])
doTweenZoom('camGamezoomtag3', 'camGame', 1.1, 4.8, 'quadInOut')
end
if curStep == 2432 then
changeChannel(2);
end
if curStep == 2464 then
changeChannel(3);
doTweenZoom('camGamezoomtag2', 'camGame', 0.8, 0.00075, 'quadInOut')
triggerEvent('Cinematics', 'off', '1');
doTweenY('cinematicup', 'cinematicup', -100, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, 1, 'cubeOut')
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 2528 then
changeChannel(1);
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 2560 then
changeChannel(2);
doTweenZoom('camGamezoomtag', 'camGame', 1.1, 0.00075, 'quadInOut')
end
if curStep == 2592 then
changeChannel(3);
doTweenZoom('camGamezoomtag2', 'camGame', 0.8, 0.00075, 'quadInOut')
end
if curStep == 2604 then
changeChannel(1);
end
if curStep == 2624 then
changeChannel(2);
doTweenZoom('camGamezoomtag', 'camGame', 1.1, 0.00075, 'quadInOut')
end
if curStep == 2632 then
changeChannel(3);
doTweenZoom('camGamezoomtag2', 'camGame', 0.8, 0.00075, 'quadInOut')
end
if curStep == 2640 then
changeChannel(1);
end
if curStep == 2648 then
changeChannel(2);
doTweenZoom('camGamezoomtag', 'camGame', 1.1, 0.00075, 'quadInOut')
end
if curStep == 2656 then
changeChannel(3);
runHaxeCode([[
game.moveCamera(false);
]])
setProperty('defaultCamZoom',1.3)
end
if curStep == 2672 then
setProperty('defaultCamZoom',1.4)
end
if curStep == 2678 then
setProperty('defaultCamZoom',1.5)
end
if curStep == 2684 then
setProperty('defaultCamZoom',1.6)
end
if curStep == 2688 then
setProperty('iconP3.visible',true)
changeChannel(0);
setProperty('boyfriend.alpha',1)
setProperty('defaultCamZoom',0.7)
cameraFlash('camGame', 'FFFFFF', 1, true)
runHaxeCode([[
							game.camHUD.setFilters([]);
                            game.camOther.setFilters([]);
							game.camGame.setFilters([]);
]])
setProperty('boyfriend.x',getProperty('boyfriend.x')+160)
setProperty('boyfriend.y',getProperty('boyfriend.y')+70)
setProperty('dad.y',getProperty('dad.y')-30)
end
end

function changeChannel(number)
if number == 0 then
setTextString('channelTxt','AV')
end
if number == 1 then
setTextString('channelTxt','CH 06')
end
if number == 2 then
setTextString('channelTxt','CH 02')
end
if number == 3 then
setTextString('channelTxt','CH 03')
end
end

function onBeatHit()
    runHaxeCode([[
				iconP3.scale.set(1, 1);
				iconP3.updateHitbox();
    ]])
if curStep > 1 and curStep < 256 then
if curBeat % 2 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 256 and curStep < 495 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 512 and curStep < 1079 then
if curBeat % 2 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 1080 and curStep < 1280 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 1824 and curStep < 2080 then
if curBeat % 2 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 2144 and curStep < 2400 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 2464 and curStep < 2656 then
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
if tag == 'lyricTxtalpha' then
setProperty('lyricTxt.alpha',1)
end
if tag == 'camGamezoomtag' then
setProperty('defaultCamZoom',1.1)
end
if tag == 'camGamezoomtag2' then
setProperty('defaultCamZoom',0.8)
end
if tag == 'camGamezoomtag3' then
setProperty('defaultCamZoom',getProperty('defaultCamZoom'))
end
end

function onTimerCompleted(tag)
if tag == 'lyricTxtalpha0timer' then
doTweenAlpha('lyricTxtalpha0', 'lyricTxt', 0, 0.05, 'linear')
end
if tag == '0.01875timer' then
setTextString('lyricTxt','D-D')
runTimer('0.0375timer', 0.0375, 1);
end
if tag == '0.0375timer' then
setTextString('lyricTxt','D-D-D')
runTimer('0.01875timer2', 0.01875, 1);
end
if tag == '0.01875timer2' then
setTextString('lyricTxt','D-D-D-D')
runTimer('0.01875timer3', 0.01875, 1);
end
if tag == '0.01875timer3' then
setTextString('lyricTxt','D-D-D-D-D')
runTimer('0.01875timer4', 0.01875, 1);
end
if tag == '0.01875timer4' then
setTextString('lyricTxt','D-D-D-D-D-D')
runTimer('0.01875timer5', 0.01875, 1);
end
if tag == '0.01875timer5' then
setTextString('lyricTxt','DARWIN?')
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