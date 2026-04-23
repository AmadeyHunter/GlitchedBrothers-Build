local healthDrain = true;
local distortIntensity = 1000.0;
local jakeGlitchIntensity = 0;
local glitchShaderIntensity = 0;
local abberationShaderIntensity = 0;
local beatShaderAmount = 0.05;

function onCreate()
    runHaxeCode([[
            jake = new Character(game.DAD_X + 100,game.DAD_Y + -90, 'jake');
            game.startCharacterPos(jake, true);
            game.addBehindDad(jake);
            game.variables.set('jake',jake);
        ]]);
end

function onCreatePost()
makeLuaSprite('theBlackness', nil,  -screenWidth * getProperty('camGame.zoom'), -screenHeight * getProperty('camGame.zoom'));
makeGraphic('theBlackness',screenWidth * 3, screenHeight * 3, '000000');
setScrollFactor('theBlackness');
setProperty('theBlackness.alpha',0)
addLuaSprite('theBlackness', false);

makeLuaSprite('blackFNF', nil,  -screenWidth * getProperty('camGame.zoom'), -screenHeight * getProperty('camGame.zoom'));
makeGraphic('blackFNF',screenWidth * 3, screenHeight * 3, '000000');
setScrollFactor('blackFNF');
setProperty('blackFNF.alpha',0)
addLuaSprite('blackFNF', true);
setPropertyFromClass('GameOverSubstate', 'characterName', 'deathscreen')
setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'glitchshit')
setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd')
	makeLuaSprite('distortFNFobject')
	makeGraphic('distortFNFobject', screenWidth, screenHeight)
	makeLuaSprite('pibbyFNFobject')
	makeGraphic('pibbyFNFobject', screenWidth, screenHeight)
	makeLuaSprite('chromFNFobject')
	makeGraphic('chromFNFobject', screenWidth, screenHeight)
	makeLuaSprite('distortJakeFNFobject')
	makeGraphic('distortJakeFNFobject', screenWidth, screenHeight)
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

var distortJakeFNF = game.createRuntimeShader('distort');
game.getLuaObject('distortJakeFNFobject').shader = distortJakeFNF;
distortJakeFNF.setFloat("negativity", 0.0);
distortJakeFNF.setFloat("binaryIntensity", 1000.0);

			iconPibby = new HealthIcon(game.gf.healthIcon, true);
			iconPibby.y = game.healthBar.y - 77;
			iconPibby.visible = !ClientPrefs.hideHud;
			iconPibby.alpha = ClientPrefs.healthBarAlpha;
			game.add(iconPibby);

			iconJake = new HealthIcon("jake", false);
			iconJake.y = game.healthBar.y - 77;
			iconJake.visible = !ClientPrefs.hideHud;
			iconJake.alpha = ClientPrefs.healthBarAlpha;
			game.add(iconJake);

			iconJake.cameras = [game.camHUD];
			iconPibby.cameras = [game.camHUD];

game.variables.set('iconPibby',iconPibby);
game.variables.set('iconJake',iconJake);
]])
        makeLuaText('lyricTxt','',screenWidth,0,getProperty('healthBarBG.y')-72)
    setTextSize('lyricTxt',48)
    setTextAlignment('lyricTxt','CENTER')
    setTextFont('lyricTxt','finn.ttf')
setProperty('lyricTxt.color',getIconColor('dad'))
    setTextBorder('lyricTxt', 1.25, '000000')
setProperty('lyricTxt.alpha',0)
if getPropertyFromClass('ClientPrefs','downScroll') then
setProperty('lyricTxt.y',getProperty('healthBarBG.y')+72)
end
    addLuaText('lyricTxt')
    setObjectCamera('lyricTxt','camOther')
end

local isCameraOnForcedPos = false;

function onUpdate(elapsed)
if isCameraOnForcedPos then
triggerEvent('Camera Follow Pos', '1830', '1100');
end
setShaderFloat('distortFNFobject',"binaryIntensity", distortIntensity);
mult = lerp(0.8, getProperty('iconPibby.scale.x'), boundTo(1 - (elapsed * 9 * getProperty('playbackRate')), 0, 1));
setProperty('iconPibby.scale.x',mult)
setProperty('iconPibby.scale.y',mult)
updateHitbox('iconPibby')
setProperty('iconPibby.x',964)
			
mult2 = lerp(0.8, getProperty('iconJake.scale.x'), boundTo(1 - (elapsed * 9 * getProperty('playbackRate')), 0, 1));
setProperty('iconJake.scale.x',mult2)
setProperty('iconJake.scale.y',mult2)
updateHitbox('iconJake')
setProperty('iconJake.x',163)
end

local ijx = 0;

function onUpdatePost(elapsed)
glitchShaderIntensity = lerp(glitchShaderIntensity, 0, boundTo(elapsed * 7, 0, 1));
abberationShaderIntensity = lerp(abberationShaderIntensity, 0, boundTo(elapsed * 6, 0, 1));
setShaderFloat("pibbyFNFobject", "glitchMultiply", glitchShaderIntensity)
setShaderFloat("pibbyFNFobject", "uTime", os.clock())
setShaderFloat('chromFNFobject',"aberration", abberationShaderIntensity);
runHaxeCode([[
        if (game.healthBar.percent > 80){
	iconJake.shader = game.getLuaObject('distortFNFobject').shader;
	iconJake.animation.curAnim.curFrame = 1;
        }else{
            iconJake.shader = null;
	iconJake.animation.curAnim.curFrame = 0;
        }
        if (game.healthBar.percent < 20){
	iconPibby.shader = game.getLuaObject('distortFNFobject').shader;
	iconPibby.animation.curAnim.curFrame = 1;
        }else{
            iconPibby.shader = null;
	iconPibby.animation.curAnim.curFrame = 0;
        }
]])
setShaderFloat('distortJakeFNFobject',"binaryIntensity", jakeGlitchIntensity);
ijx = ijx - elapsed;
if ijx < 0 then
setShaderFloat('distortJakeFNFobject',"negativity", 0.0);
runHaxeCode([[
jake.shader = null;
]])
end
end

function opponentNoteHit(id, direction ,noteType, isSustainNote)
if noteType == 'Second Char Glitch' then
jakeGlitchIntensity = getRandomFloat(-1, -0.5);
runHaxeCode([[
jake.shader = game.getLuaObject('distortJakeFNFobject').shader;
]])
setShaderFloat('distortJakeFNFobject',"negativity", 1.0);
ijx = 0 + getRandomFloat(0.0475, 0.085);
end
if not getPropertyFromGroup('notes', id, 'gfNote') then
if healthDrain then
runHaxeCode([[
if (game.health > 0.1) {
game.health -= 0.035;
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

	if noteType == 'Second Char Sing' or noteType == 'Both Char Sing' or noteType == 'Second Char Glitch' then
        runHaxeCode([[
            jake.playAnim(game.singAnimations[]]..direction..[[], true);
            jake.holdTimer = 0;
        ]])
	end
end

function goodNoteHit(id, direction ,noteType, isSustainNote)
if not getPropertyFromGroup('notes', id, 'gfNote') then
runHaxeCode([[
iconPibby.changeIcon(game.gf.healthIcon);
]])
else
runHaxeCode([[
iconPibby.changeIcon(game.boyfriend.healthIcon);
]])
end
end

function onSectionHit()
abberationShaderIntensity = beatShaderAmount;
end

function onStepHit()
distortIntensity = getRandomFloat(4, 6);
if curStep == 1 then
setProperty('cameraSpeed',50)
doTweenZoom('camGamezoomtag', 'camGame', 0.7, 0.00075, 'linear')
triggerEvent('Camera Follow Pos', '1830', '1100');
isCameraOnForcedPos = true;
setProperty('camHUD.alpha',0)
triggerEvent('Cinematics', 'on', '0.00075');
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
doTweenY('cinematicup', 'cinematicup', 0, 0.00075, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 0.00075, 'cubeOut')
runHaxeCode([[
game.camOther.fade(0xFF000000, 9.33, true, () -> game.cameraSpeed = 2);
]])
end
if curStep == 128 then
triggerEvent('Camera Follow Pos', '', '');
isCameraOnForcedPos = false;
doTweenY('cinematicup', 'cinematicup', -100, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, 1, 'cubeOut')
setProperty('camHUD.alpha',1)
cameraFlash('camGame', 'FFFFFF', 1, true)
setProperty('defaultCamZoom', 0.9)
end
if curStep == 240 then
doTweenZoom('camGamezoomtag2', 'camGame', 1.2, 0.00075, 'quadInOut')
end
if curStep == 244 then
doTweenZoom('camGamezoomtag3', 'camGame', 1.3, 0.00075, 'quadInOut')
end
if curStep == 248 then
doTweenZoom('camGamezoomtag4', 'camGame', 1.4, 0.00075, 'quadInOut')
end
if curStep == 252 then
doTweenZoom('camGamezoomtag3', 'camGame', 1.3, 0.00075, 'quadInOut')
end
if curStep == 256 then
cameraFlash('camGame', 'FFFFFF', 1, true)
setProperty('defaultCamZoom', 1.1)
end
if curStep == 369 then
setProperty('defaultCamZoom', 1.15)
end
if curStep == 376 then
setProperty('defaultCamZoom', 1.2)
end
if curStep == 378 then
setProperty('defaultCamZoom', 1.3)
end
if curStep == 379 then
setProperty('defaultCamZoom', 1.25)
end
if curStep == 384 then
cameraFlash('camGame', 'FFFFFF', 1, true)
setProperty('defaultCamZoom', 1.1)
end
if curStep == 448 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 508 then
setProperty('defaultCamZoom', 1.3)
end
if curStep == 512 then
cameraFlash('camGame', 'FFFFFF', 1, true)
setProperty('defaultCamZoom',0.9)
end
if curStep == 536 then
setProperty('defaultCamZoom',0.95)
end
if curStep == 540 then
setProperty('defaultCamZoom',1.025)
end
if curStep == 544 then
setProperty('defaultCamZoom',1.1)
end
if curStep == 552 then
setProperty('defaultCamZoom',1.3)
end
if curStep == 559 then
setProperty('defaultCamZoom',1.1)
end
if curStep == 576 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 600 then
setProperty('defaultCamZoom',0.95)
end
if curStep == 604 then
setProperty('defaultCamZoom',1.025)
end
if curStep == 608 then
setProperty('defaultCamZoom',1.1)
end
if curStep == 616 then
setProperty('defaultCamZoom',1.3)
end
if curStep == 624 then
setProperty('defaultCamZoom',1.1)
end
if curStep == 640 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 768 then
triggerEvent('Cinematics', 'on', '1');
doTweenY('cinematicup', 'cinematicup', 0, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 1, 'cubeOut')
end
if curStep == 1024 then
cameraFlash('camGame', 'FFFFFF', 1, true)
triggerEvent('Cinematics', 'off', '1');
doTweenY('cinematicup', 'cinematicup', -100, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, 1, 'cubeOut')
end
if curStep == 1038 then
setProperty('defaultCamZoom',1.1)
end
if curStep == 1056 then
setProperty('defaultCamZoom',0.9)
end
if curStep == 1072 then
doTweenZoom('camGamezoomtag5', 'camGame', 1.1, 1.34, 'quadInOut')
end
if curStep == 1088 then
cameraFlash('camGame', 'FFFFFF', 1, true)
setProperty('defaultCamZoom',0.9)
end
if curStep == 1120 then
setProperty('defaultCamZoom',1.15)
end
if curStep == 1137 then
setProperty('defaultCamZoom',1.2)
end
if curStep == 1144 then
setProperty('defaultCamZoom',1.3)
end
if curStep == 1146 then
setProperty('defaultCamZoom',1.4)
end
if curStep == 1149 then
setProperty('defaultCamZoom',1.25)
end
if curStep == 1152 then
setProperty('defaultCamZoom',0.9)
end
if curStep == 1270 then
setProperty('defaultCamZoom',1.15)
end
if curStep == 1273 then
setProperty('defaultCamZoom',1.2)
end
if curStep == 1276 then
setProperty('defaultCamZoom',1.3)
end
if curStep == 1280 then
cameraFlash('camGame', 'FFFFFF', 1, true)
setProperty('defaultCamZoom',0.9)
end
if curStep == 1306 then
setProperty('defaultCamZoom',1.2)
end
if curStep == 1312 then
setProperty('defaultCamZoom',0.9)
end
if curStep == 1320 then
setProperty('defaultCamZoom',1.1)
end
if curStep == 1324 then
setProperty('defaultCamZoom',1)
end
if curStep == 1328 then
setProperty('defaultCamZoom',0.9)
end
if curStep == 1376 then
setProperty('defaultCamZoom',1.3)
end
if curStep == 1390 then
setProperty('defaultCamZoom',1.1)
end
if curStep == 1408 then
cameraFlash('camGame', 'FFFFFF', 1, true)
triggerEvent('Cinematics', 'on', '1');
doTweenY('cinematicup', 'cinematicup', 0, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 1, 'cubeOut')
end
if curStep == 1536 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 1656 then
setProperty('defaultCamZoom',1.2)
end
if curStep == 1660 then
setProperty('defaultCamZoom',1.3)
end
if curStep == 1664 then
setProperty('defaultCamZoom',1.3)
setProperty('camGame.alpha',0)
setProperty('camHUD.alpha',0)
triggerEvent('Cinematics', 'off', '1');
doTweenY('cinematicup', 'cinematicup', -100, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, 1, 'cubeOut')
end
if curStep == 1696 then
doTweenZoom('camGamezoomtag6', 'camGame', 0.9, 10.67, 'quadInOut')
setProperty('camHUD.alpha',1)
runHaxeCode([[
camHUD.fade(0xFF000000, 10.67, true);
]])
triggerEvent('Cinematics', 'on', '0.6');
doTweenY('cinematicup', 'cinematicup', 0, 0.6, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 0.6, 'cubeOut')
setProperty('camGame.alpha',1)
setProperty('dad.alpha',0.3)
setProperty('boyfriend.alpha',0.3)
end
if curStep == 1832 then
doTweenAlpha('dadalphatag', 'dad', 1, 0.25, 'quadInOut')
end
if curStep == 1952 then
triggerEvent('Cinematics', 'off', '1');
doTweenY('cinematicup', 'cinematicup', -100, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, 1, 'cubeOut')
end
if curStep == 1958 then
setProperty('defaultCamZoom',1.2)
end
if curStep == 1968 then
setProperty('defaultCamZoom',0.9)
end
if curStep == 1974 then
setProperty('defaultCamZoom',1.1)
end
if curStep == 1978 then
setProperty('defaultCamZoom',1)
end
if curStep == 1984 then
setProperty('defaultCamZoom',0.9)
end
if curStep == 1990 then
setProperty('defaultCamZoom',1)
end
if curStep == 1998 then
setProperty('defaultCamZoom',1.2)
end
if curStep == 2006 then
setProperty('defaultCamZoom',0.9)
end
if curStep == 2049 then
triggerEvent('Camera Follow Pos', '1830', '1100');
isCameraOnForcedPos = true;
doTweenZoom('camGamezoomtag7', 'camGame', 0.8, 1.65, 'quadInOut')
end
if curStep == 2062 then
runHaxeCode([[
							for (i in 0...game.opponentStrums.length) {
								FlxTween.tween(game.opponentStrums.members[i], {alpha: 0}, 1, {
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
if curStep == 2064 then
doTweenAlpha('boyfriendalphatag', 'boyfriend', 1, 0.25, 'quadInOut')
end
if curStep == 2066 then
triggerEvent('Camera Follow Pos', '1830', '1100');
isCameraOnForcedPos = true;
end
if curStep == 2071 then
setProperty('defaultCamZoom',0.9)
cameraFlash('camGame', 'FFFFFF', 0.5, true)
end
if curStep == 2080 then
cameraFlash('camGame', 'FFFFFF', 1, true)
triggerEvent('Camera Follow Pos', '1830', '1100');
isCameraOnForcedPos = true;
setProperty('gf.alpha',0.0001)
runHaxeCode([[
jake.alpha = 0.0001;
]])
setProperty('theBlackness.alpha',1)
setProperty('defaultCamZoom',0.65)
end
if curStep == 2140 then
		characterPlayAnim('boyfriend', 'reload', false);
		setProperty('boyfriend.specialAnim', true);
end
if curStep == 2336 then
runHaxeCode([[
if (!ClientPrefs.middleScroll) {
							for (i in 0...game.opponentStrums.length) {
								FlxTween.tween(game.opponentStrums.members[i], {alpha: 1}, 1, {
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
								FlxTween.tween(game.opponentStrums.members[i], {alpha: 0.5}, 1, {
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
setProperty('defaultCamZoom',0.9)
cameraFlash('camGame', 'FFFFFF', 2.5, true)
setProperty('gf.alpha',1)
runHaxeCode([[
jake.alpha = 1;
]])
setProperty('theBlackness.alpha',0)
end
if curStep == 2368 then
runHaxeCode([[
							FlxTween.num(]]..abberationShaderIntensity..[[, 0.1, 2.67, {
								ease: FlxEase.quadInOut,
								onComplete: 
								function (twn:FlxTween)
									{
										FlxTween.num(]]..abberationShaderIntensity..[[, ]]..beatShaderAmount..[[, 1, {
											ease: FlxEase.quadInOut,
											onComplete: 
											function (twn:FlxTween)
												{
												}});
									}});
]])
runTimer('2368timer', 3.67, 1);
end
if curStep == 2372 then
		characterPlayAnim('gf', 'cmon', false);
		setProperty('gf.specialAnim', true);
end
if curStep == 2374 then
doTweenAlpha('lyricTxtalpha', 'lyricTxt', 1, 0.05, 'linear')
setTextString('lyricTxt','COME ON')
runTimer('0.917timer', 0.917, 1);
end
if curStep == 2400 then
setTextString('lyricTxt','')
setProperty('defaultCamZoom',1.1)
triggerEvent('Camera Follow Pos', '', '');
isCameraOnForcedPos = false;
runHaxeCode([[
game.moveCamera(false);
]])
end
if curStep == 2448 then
doTweenZoom('camGamezoomtag2', 'camGame', 1.2, 0.00075, 'quadInOut')
end
if curStep == 2452 then
doTweenZoom('camGamezoomtag3', 'camGame', 1.3, 0.00075, 'quadInOut')
end
if curStep == 2456 then
doTweenZoom('camGamezoomtag4', 'camGame', 1.4, 0.00075, 'quadInOut')
end
if curStep == 2460 then
doTweenZoom('camGamezoomtag3', 'camGame', 1.3, 0.00075, 'quadInOut')
end
if curStep == 2464 then
setProperty('defaultCamZoom',0.9)
cameraFlash('camGame', 'FFFFFF', 1, true)
triggerEvent('Cinematics', 'on', '1');
doTweenY('cinematicup', 'cinematicup', 0, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 1, 'cubeOut')
end
if curStep == 2592 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 2720 then
triggerEvent('Cinematics', 'off', '0.6');
doTweenY('cinematicup', 'cinematicup', -100, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight, 1, 'cubeOut')
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 2784 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 2848 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 2912 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 2976 then
triggerEvent('Cinematics', 'on', '0.6');
doTweenY('cinematicup', 'cinematicup', 0, 0.6, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 0.6, 'cubeOut')
cameraFlash('camGame', 'FFFFFF', 1.5, true)
end
if curStep == 3008 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 3040 then
cameraFlash('camGame', 'FFFFFF', 1.5, true)
end
if curStep == 3088 then
doTweenZoom('camGamezoomtag2', 'camGame', 1.2, 0.00075, 'quadInOut')
end
if curStep == 3092 then
doTweenZoom('camGamezoomtag3', 'camGame', 1.3, 0.00075, 'quadInOut')
end
if curStep == 3096 then
doTweenZoom('camGamezoomtag4', 'camGame', 1.4, 0.00075, 'quadInOut')
end
if curStep == 3100 then
doTweenZoom('camGamezoomtag3', 'camGame', 1.3, 0.00075, 'quadInOut')
end
if curStep == 3104 then
triggerEvent('Cinematics', 'on', '1');
doTweenY('cinematicup', 'cinematicup', 0, 1, 'cubeOut')
doTweenY('cinematicdown', 'cinematicdown', screenHeight -100, 1, 'cubeOut')
setProperty('defaultCamZoom',0.9)
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 3168 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 3228 then
setProperty('defaultCamZoom',1.3)
end
if curStep == 3232 then
setProperty('defaultCamZoom',0.9)
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 3256 then
setProperty('defaultCamZoom',0.95)
end
if curStep == 3260 then
setProperty('defaultCamZoom',1.025)
end
if curStep == 3264 then
setProperty('defaultCamZoom',1.1)
end
if curStep == 3272 then
setProperty('defaultCamZoom',1.3)
end
if curStep == 3279 then
setProperty('defaultCamZoom',1.1)
end
if curStep == 3296 then
cameraFlash('camGame', 'FFFFFF', 1, true)
end
if curStep == 3320 then
setProperty('defaultCamZoom',0.95)
end
if curStep == 3324 then
setProperty('defaultCamZoom',1.025)
end
if curStep == 3328 then
setProperty('defaultCamZoom',1.1)
end
if curStep == 3336 then
setProperty('defaultCamZoom',1.3)
end
if curStep == 3344 then
setProperty('defaultCamZoom',1.1)
end
if curStep == 3360 then
setProperty('camGame.alpha',0)
cameraFlash('camGame', 'FFFFFF', 1, true)
setProperty('dad.alpha',0.0001)
runHaxeCode([[
jake.alpha = 0.0001;
]])
end
if curStep == 3392 then
setProperty('camGame.alpha',1)
setProperty('defaultCamZoom',0.7)
cameraFlash('camGame', 'FFFFFF', 0.4, true)
triggerEvent('Apple Filter', 'on', 'black');
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
setProperty('bg.visible',false)
if not getPropertyFromClass('ClientPrefs','lowQuality') or not getPropertyFromClass('ClientPrefs','flashing') then
setProperty('dark.visible',false)
setProperty('light.visible',false)
setProperty('bulb.visible',false)
end
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
end
if curStep == 3776 then
cameraFlash('camGame', 'FFFFFF', 0.5, true)
setProperty('blackFNF.alpha',1)
end
if curStep == 3791 then
doTweenAlpha('camHUDalphatag', 'camHUD', 0, 3, 'linear')
end
end

function onBeatHit()
    runHaxeCode([[
        if (]]..curBeat..[[ % jake.danceEveryNumBeats == 0 && jake.animation.curAnim != null && !StringTools.startsWith(jake.animation.curAnim.name, 'sing') && !jake.stunned)
        {
            jake.dance();
        }
				iconPibby.scale.set(1, 1);
				iconPibby.updateHitbox();
				iconJake.scale.set(1, 1);
				iconJake.updateHitbox();
    ]])
if curStep > 256 and curStep < 508 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 512 and curStep < 639 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 640 and curStep < 767 then
if curBeat % 2 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 768 and curStep < 1023 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 1024 and curStep < 1136 then
if curBeat % 2 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 1280 and curStep < 1392 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 1408 and curStep < 1664 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 1952 and curStep < 2324 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 2464 and curStep < 2968 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 3104 and curStep < 3223 then
if curBeat % 1 == 0 then
abberationShaderIntensity = beatShaderAmount;
runHaxeCode([[
FlxG.camera.zoom += 0.015 * game.camZoomingMult;
game.camHUD.zoom += 0.03 * game.camZoomingMult;
]])
end
end
if curStep > 3232 and curStep < 3360 then
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
setProperty('defaultCamZoom',1.2)
end
if tag == 'camGamezoomtag3' then
setProperty('defaultCamZoom',1.3)
end
if tag == 'camGamezoomtag4' then
setProperty('defaultCamZoom',1.4)
end
if tag == 'camGamezoomtag5' then
setProperty('defaultCamZoom',getProperty('defaultCamZoom'))
end
if tag == 'camGamezoomtag6' then
setProperty('defaultCamZoom',getProperty('defaultCamZoom'))
end
if tag == 'camGamezoomtag7' then
setProperty('defaultCamZoom',getProperty('defaultCamZoom'))
end
if tag == 'dadalphatag' then
setProperty('dad.alpha',1)
end
if tag == 'boyfriendalphatag' then
setProperty('boyfriend.alpha',1)
end
if tag == 'camHUDalphatag' then
setProperty('camHUD.alpha',0)
end
end

function onTimerCompleted(tag)
if tag == '0.917timer' then
setTextString('lyricTxt','W')
runTimer('0.083timer', 0.083, 1);
end
if tag == '0.083timer' then
setTextString('lyricTxt','WA')
runTimer('0.083timer2', 0.083, 1);
end
if tag == '0.083timer2' then
setTextString('lyricTxt','WA')
runTimer('0.083timer3', 0.083, 1);
end
if tag == '0.083timer3' then
setTextString('lyricTxt','WAAA')
runTimer('0.083timer4', 0.083, 1);
end
if tag == '0.083timer4' then
setTextString('lyricTxt','WAAAA')
runTimer('0.083timer5', 0.083, 1);
end
if tag == '0.083timer5' then
setTextString('lyricTxt','WAAAAA')
runTimer('0.083timer6', 0.083, 1);
end
if tag == '0.083timer6' then
setTextString('lyricTxt','WAAAAAA')
runTimer('0.083timer7', 0.083, 1);
end
if tag == '0.083timer7' then
setTextString('lyricTxt','WAAAAAAA')
runTimer('0.083timer8', 0.083, 1);
end
if tag == '0.083timer8' then
setTextString('lyricTxt','WAAAAAAAA')
runTimer('0.083timer9', 0.083, 1);
end
if tag == '0.083timer9' then
setTextString('lyricTxt','WAAAAAAAAA')
runTimer('0.083timer10', 0.083, 1);
end
if tag == '0.083timer10' then
setTextString('lyricTxt','WAAAAAAAAAA')
runTimer('0.083timer11', 0.083, 1);
end
if tag == '0.083timer11' then
setTextString('lyricTxt','WAAAAAAAAAAH')
runTimer('0.083timer12', 0.083, 1);
end
if tag == '0.083timer12' then
setTextString('lyricTxt','WAAAAAAAAAAH!')
end
if tag == '2368timer' then
abberationShaderIntensity = beatShaderAmount;
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