local introCharacter = 'bf_intro';

function onCreate()
luaDebugMode = true
    addHaxeLibrary('Std')
    addHaxeLibrary('Math')
    addHaxeLibrary('Date')
    addHaxeLibrary('Application','lime.app')
    setProperty('introSoundsSuffix', 'pibby')

if songName == "Child's Play" or songName == 'My Amazing World' or songName == 'Retcon' then
introCharacter = 'bf_intro_gumball';
elseif songName == "Retcon" then
introCharacter = 'bf_intro_but_retcon';
elseif songName == 'Mindless' or songName == 'Blessed by Swords' or songName == 'Brotherly Love' or songName == 'Suffering Siblings' then
introCharacter = 'bf_intro_finn';
else
introCharacter = 'bf_intro';
end

    runHaxeCode([[

		sprite = new FlxSprite().loadGraphic(Paths.image('cursor/mouse (1)'));

		FlxG.mouse.load(sprite.pixels);

            bfIntro = new Boyfriend(game.BF_X, game.BF_Y, ']]..introCharacter..[[');

            game.startCharacterPos(bfIntro, true);
            bfIntro.playAnim('Go', true);
            bfIntro.specialAnim = true;

            game.add(bfIntro);

		cnlogo = new BGSprite('cnlogo', 990, 600, 0, 0);
		cnlogo.setGraphicSize(Std.int(cnlogo.width * 0.17));
		cnlogo.updateHitbox();
		if(ClientPrefs.downScroll) cnlogo.y -= 530;
        cnlogo.alpha = 0.5;
		cnlogo.cameras = [game.camOther];

		var leDate = Date.now();
		if (leDate.getHours() >= 17 && leDate.getHours() <= 24) {
			cnlogo.loadGraphic(Paths.image('aslogo'));
			cnlogo.x = 1046.5;
			cnlogo.y = 660;
			cnlogo.setGraphicSize(Std.int(cnlogo.width * 0.09));
			cnlogo.updateHitbox();
			if(ClientPrefs.downScroll) cnlogo.y -= 530;
			trace(cnlogo.y);
		}

		if (leDate.getHours() >= 1 && leDate.getHours() <= 6) {
			cnlogo.loadGraphic(Paths.image('aslogo'));
			cnlogo.x = 1046.5;
			cnlogo.y = 660;
			cnlogo.setGraphicSize(Std.int(cnlogo.width * 0.09));
			cnlogo.updateHitbox();
			if(ClientPrefs.downScroll) cnlogo.y -= 530;
		}

		if (leDate.getHours() >= 6 && leDate.getHours() <= 17) {
			cnlogo.loadGraphic(Paths.image('cnlogo'));
			cnlogo.x = 990;
			cnlogo.y = 600;
			cnlogo.setGraphicSize(Std.int(cnlogo.width * 0.17));
			cnlogo.updateHitbox();
			if(ClientPrefs.downScroll) cnlogo.y -= 530;
		}
		switch (PlayState.SONG.song)
		{
			case 'Mindless':
				game.add(cnlogo);

			case 'Blessed by Swords':
				game.add(cnlogo);

			case 'Brotherly Love':
				game.add(cnlogo);

			case 'Suffering Siblings':
				game.add(cnlogo);

			case 'No Hero Remix':
				game.add(cnlogo);

			case "Child's Play":
				game.add(cnlogo);

			case 'My Amazing World':
				game.add(cnlogo);

			case 'Retcon':
				game.add(cnlogo);

			case 'Forgotten World':
				game.add(cnlogo);

			default: // the nothing
		}

        var numberIntro:FlxSprite = new FlxSprite();
        numberIntro.screenCenter();
        numberIntro.x -= 200;
        numberIntro.y -= 200;
        numberIntro.frames = Paths.getSparrowAtlas('Numbers');
        numberIntro.alpha = 0.0001;
        numberIntro.cameras = [game.camOther];
        
        numberIntro.animation.addByPrefix('3', '3', 30, false);
        numberIntro.animation.addByPrefix('2', '2', 30, false);
        numberIntro.animation.addByPrefix('1', '1', 30, false);
        numberIntro.animation.addByPrefix('Go', 'Go', 30, false);
        
        numberIntro.animation.finishCallback = (name) -> {numberIntro.visible = false;}
        game.add(numberIntro);
game.variables.set('numberIntro',numberIntro);
game.variables.set('bfIntro',bfIntro);
game.variables.set('cnlogo',cnlogo);
    ]])

if songName == "Child's Play" or songName == 'My Amazing World' or songName == 'Retcon' or songName == 'Forgotten World' or songName == 'No Hero Remix' then
	makeAnimatedLuaSprite('pibbyHealthbar', 'healthbar/healthbarShader', 0, 0)
for i = 0, 41 do
addAnimationByPrefix('pibbyHealthbar', 'health'..i, 'healthbar'..i..'', 12, true);
end
	addLuaSprite('pibbyHealthbar', true)
scaleObject('pibbyHealthbar',1,1)
updateHitbox('pibbyHealthbar')
setProperty('pibbyHealthbar.x',65)
end
if songName == 'Mindless' or songName == 'Blessed by Swords' or songName == 'Brotherly Love' or songName == 'Suffering Siblings' or songName == 'Come Along With Me' then
makeAnimatedLuaSprite('finnBarThing', 'healthbar/iconbar', 0, 0)
setProperty('finnBarThing.y',565)
setProperty('finnBarThing.x',197)
addAnimationByPrefix('finnBarThing', 'idle2', 'Icons Bar 2', 24, true);
addAnimationByPrefix('finnBarThing', 'idle3', 'Icons Bar 1', 24, true);
addAnimationByPrefix('finnBarThing', 'idle1', 'Icons Bar 3', 24, true);
setScrollFactor('finnBarThing', 1, 1);
setProperty('finnBarThing.alpha',getPropertyFromClass('ClientPrefs','healthBarAlpha'))
if getPropertyFromClass('ClientPrefs','downScroll') then
setProperty('finnBarThing.y',0.12)
end
addLuaSprite('finnBarThing', true)
end
end

local distortIntensity = 1000.0;
local dadGlitchIntensity = 0;
local glitchShaderIntensity = 0;
local abberationShaderIntensity = 0;
local beatShaderAmount = 0.05;

function onCreatePost()
if songName == "Child's Play" or songName == 'My Amazing World' or songName == 'Retcon' or songName == 'Forgotten World' or songName == 'No Hero Remix' then
setObjectCamera('pibbyHealthbar', 'camHUD')
setProperty('pibbyHealthbar.y',getProperty('iconP1.y') + 50)
end
if songName == 'Mindless' or songName == 'Blessed by Swords' or songName == 'Brotherly Love' or songName == 'Suffering Siblings' or songName == 'Come Along With Me' then
setObjectCamera('finnBarThing', 'camHUD')
end
if getProperty('gf.curCharacter') == 'pibby' then
    runHaxeCode([[
            pibbyIntro = new Boyfriend(game.BF_X + -68.55, game.BF_Y + -76.15, 'pibby_intro');
            game.startCharacterPos(pibbyIntro);
            pibbyIntro.playAnim('Go', true);
            pibbyIntro.specialAnim = true;
game.addBehindGF(pibbyIntro);
game.variables.set('pibbyIntro',pibbyIntro);
    ]])
end
if songName == "Child's Play" or songName == 'My Amazing World' or songName == 'Retcon' or songName == 'Forgotten World' then
setTextFont('scoreTxt','gumball.ttf')
setTextFont('timeTxt','gumball.ttf')
setTextFont('botplayTxt','gumball.ttf')
elseif songName == 'Mindless' or songName == 'Blessed by Swords' or songName == 'Brotherly Love' or songName == 'Suffering Siblings' or songName == 'No Hero Remix' then
setTextFont('scoreTxt','finn.ttf')
setTextFont('timeTxt','finn.ttf')
setTextFont('botplayTxt','finn.ttf')
elseif songName == 'Come Along With Me' then
setTextFont('scoreTxt','cawm.ttf')
setTextFont('timeTxt','cawm.ttf')
setTextFont('botplayTxt','cawm.ttf')
else
end
setProperty('healthBar.visible', false)
setProperty('healthBarBG.visible', false)
initLuaShader('distort')
initLuaShader('Pibbified')
initLuaShader('chromShader')
	makeLuaSprite('distortFNFobject')
	makeGraphic('distortFNFobject', screenWidth, screenHeight)
	makeLuaSprite('pibbyFNFobject')
	makeGraphic('pibbyFNFobject', screenWidth, screenHeight)
	makeLuaSprite('chromFNFobject')
	makeGraphic('chromFNFobject', screenWidth, screenHeight)
	makeLuaSprite('distortDadFNFobject')
	makeGraphic('distortDadFNFobject', screenWidth, screenHeight)
	makeLuaSprite('distortCAWMFNFobject')
	makeGraphic('distortCAWMFNFobject', screenWidth, screenHeight)
dadColor = getIconColor('dad');
runHaxeCode([[
game.timeBar.createFilledBar(0xFF000000, ]]..dadColor..[[);

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
for (i in 0...game.opponentStrums.length) {
game.opponentStrums.members[i].shader = game.getLuaObject('distortFNFobject').shader;
}

var distortDadFNF = game.createRuntimeShader('distort');
game.getLuaObject('distortDadFNFobject').shader = distortDadFNF;
distortDadFNF.setFloat("negativity", 0.0);
distortDadFNF.setFloat("binaryIntensity", 1000.0);

var distortCAWMFNF = game.createRuntimeShader('distort');
game.getLuaObject('distortCAWMFNFobject').shader = distortCAWMFNF;
distortCAWMFNF.setFloat("negativity", 0.0);
distortCAWMFNF.setFloat("binaryIntensity", 1000.0);

game.variables.set('distortDadFNF',distortDadFNF);
game.variables.set('distortCAWMFNF',distortCAWMFNF);
]])
setProperty('debugKeysChart', null)
setProperty('debugKeysCharacter', null)
end

local dodgeMisses = 0;

function onUpdate()
health = getProperty('health')
if songName == "Child's Play" or songName == 'My Amazing World' or songName == 'Retcon' or songName == 'Forgotten World' or songName == 'No Hero Remix' then
setProperty('scoreTxt.y',getProperty('healthBar.y') + 40)
setProperty('scoreTxt.x',getProperty('pibbyHealthbar.x') - 350)
end
if songName == 'Mindless' or songName == 'Blessed by Swords' or songName == 'Brotherly Love' or songName == 'Suffering Siblings' or songName == 'Come Along With Me' then
if curBeat % 1 == 0 then
playAnim('finnBarThing','idle'..(2 - dodgeMisses) + 1)
end
end
setShaderFloat('distortFNFobject',"binaryIntensity", distortIntensity);
if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SEVEN', true) or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.EIGHT', true) or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.NINE', true) or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SIX', true) then
runHaxeCode([[
				game.canPause = false;
				FlxTween.tween(FlxG.sound.music, {pitch: 0.001}, 6, {onComplete: e -> FlxG.sound.music.stop()});
				FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.6}, 6);
				FlxTween.tween(game.camHUD, {alpha: 0}, 5);
				FlxTween.tween(game.vocals, {pitch: 0.001}, 6, {onComplete: e -> game.vocals.stop()});
				FlxG.sound.music.fadeOut(6.5);
				game.vocals.fadeOut(6.5);
				game.camOther.fade(0xFF000000, 6, false, () -> {
					FlxG.sound.music.stop();
					new FlxTimer().start(2, e -> game.camOther.fade(0x000000, 3, true));
				});
]])
runTimer('f', 8, 1);
end
end

local idx = 0;

function onUpdatePost(elapsed)
if songName == "Child's Play" or songName == 'My Amazing World' or songName == 'Retcon' or songName == 'Forgotten World' or songName == 'No Hero Remix' then
setProperty('iconP1.x',530)
setProperty('iconP2.x',50)
end
if songName == 'Mindless' or songName == 'Blessed by Swords' or songName == 'Brotherly Love' or songName == 'Suffering Siblings' or songName == 'Come Along With Me' then
setProperty('iconP1.x',614)
setProperty('iconP2.x',513)
end
glitchShaderIntensity = lerp(glitchShaderIntensity, 0, boundTo(elapsed * 7, 0, 1));
abberationShaderIntensity = lerp(abberationShaderIntensity, 0, boundTo(elapsed * 6, 0, 1));
runHaxeCode([[
        if (game.healthBar.percent > 80){
	game.iconP2.shader = game.getLuaObject('distortFNFobject').shader;
        }else{
            game.iconP2.shader = null;
        }
        if (game.healthBar.percent < 20){
	game.iconP1.shader = game.getLuaObject('distortFNFobject').shader;
        }else{
            game.iconP1.shader = null;
        }
]])
setShaderFloat("pibbyFNFobject", "glitchMultiply", glitchShaderIntensity)
setShaderFloat("pibbyFNFobject", "uTime", os.clock())
setShaderFloat('chromFNFobject',"aberration", abberationShaderIntensity);
setShaderFloat('distortDadFNFobject',"binaryIntensity", dadGlitchIntensity);
setShaderFloat('distortCAWMFNFobject',"binaryIntensity", dadGlitchIntensity);
idx = idx - elapsed;
if idx < 0 then
setShaderFloat('distortDadFNFobject',"negativity", 0.0);
runHaxeCode([[
game.dad.shader = null;
]])
end
if dodgeMisses >= 3 then
setProperty('health',0)
end
runHaxeCode([[
			sprite = new FlxSprite().loadGraphic(Paths.image('cursor/mouse (' + FlxG.random.int(1, 10) + ')'));
			FlxG.mouse.load(sprite.pixels);
]])
end

function opponentNoteHit(id, direction ,noteType, isSustainNote)
resetHealthBar()
if noteType == 'Glitch Note' then
dadGlitchIntensity = getRandomFloat(-1, -0.5);
runHaxeCode([[
game.dad.shader = game.getLuaObject('distortDadFNFobject').shader;
]])
setShaderFloat('distortDadFNFobject',"negativity", 1.0);
idx = 0 + getRandomFloat(0.0475, 0.085);
end
if not getPropertyFromGroup('notes', id, 'gfNote') then
	if _G['dadGhostData.strumTime'] == getPropertyFromGroup('notes', id, 'strumTime') and not isSustainNote then
runHaxeCode([[
game.camGame.shake(FlxG.random.float(0.015, 0.02), FlxG.random.float(0.075, 0.125));
game.camHUD.shake(FlxG.random.float(0.015, 0.02), FlxG.random.float(0.075, 0.125));
]])
        setPropertyFromGroup('opponentStrums', 0, 'x', defaultOpponentStrumX0 + getRandomInt(-8, 8))
        setPropertyFromGroup('opponentStrums', 1, 'x', defaultOpponentStrumX1 + getRandomInt(-8, 8))
        setPropertyFromGroup('opponentStrums', 2, 'x', defaultOpponentStrumX2 + getRandomInt(-8, 8))
        setPropertyFromGroup('opponentStrums', 3, 'x', defaultOpponentStrumX3 + getRandomInt(-8, 8))
        setPropertyFromGroup('opponentStrums', 0, 'y', defaultOpponentStrumY0 + getRandomInt(-8, 8))
        setPropertyFromGroup('opponentStrums', 1, 'y', defaultOpponentStrumY1 + getRandomInt(-8, 8))
        setPropertyFromGroup('opponentStrums', 2, 'y', defaultOpponentStrumY2 + getRandomInt(-8, 8))
        setPropertyFromGroup('opponentStrums', 3, 'y', defaultOpponentStrumY3 + getRandomInt(-8, 8))
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
resetHealthBar()
if not getPropertyFromGroup('notes', id, 'gfNote') then
runHaxeCode([[
game.iconP1.changeIcon(game.boyfriend.healthIcon);
]])
setProperty('scoreTxt.color', getIconColor('boyfriend'))
else
runHaxeCode([[
game.iconP1.changeIcon(game.gf.healthIcon);
]])
setProperty('scoreTxt.color', getIconColor('gf'))
end
end

function noteMiss(id, direction ,noteType, isSustainNote)
resetHealthBar()
if noteType == 'Dodge Note' then
dodgeMisses = dodgeMisses + 1;
end
end

function onUpdateScore(miss)
if getProperty('scoreZoom') and not miss and not getProperty('cpuControlled') then
setProperty('scoreTxt.scale.x',1)
setProperty('scoreTxt.scale.y',1)
cancelTween('scoreTxtTween')
setProperty('scoreTxt.angle',getRandomInt(-2, 2,-1, 0, 1))
doTweenAngle('scoreTxtTween', 'scoreTxt', 0, 0.2, 'sineInOut')
end
end

function onStepHit()
distortIntensity = getRandomFloat(4, 6);
end

function onBeatHit()
if getProperty('gf.curCharacter') == 'darwin-noremote' or getProperty('gf.curCharacter') == 'darwinretcon' then
if curBeat % 2 == 0 then
if getRandomBool(25) then
setProperty('gf.idleSuffix','-blink')
else
setProperty('gf.idleSuffix','')
end
end
end
end

function onSectionHit()
abberationShaderIntensity = beatShaderAmount;
end

function onStartCountdown()
setProperty('camHUD.alpha',0)
if getProperty('gf.curCharacter') == 'pibby' then
setProperty('gf.alpha', 0)
end
setProperty('boyfriend.alpha',0)
end

function onCountdownTick(tick)
resetHealthBar()
if tick == 0 then
cameraBump()
if getProperty('gf.curCharacter') == 'pibby' then
runHaxeCode([[
game.getLuaObject('pibbyIntro').playAnim('3', true);
game.getLuaObject('pibbyIntro').specialAnim = true;
]])
end
runHaxeCode([[
game.getLuaObject('bfIntro').playAnim('3', true);
game.getLuaObject('bfIntro').specialAnim = true;
FlxG.sound.play(Paths.sound('3'), 0.6);
game.getLuaObject('numberIntro').alpha = 1;
game.getLuaObject('numberIntro').animation.play('3');
]])
end
if tick == 1 then
cameraBump()
if getProperty('gf.curCharacter') == 'pibby' then
runHaxeCode([[
game.getLuaObject('pibbyIntro').playAnim('2', true);
game.getLuaObject('pibbyIntro').specialAnim = true;
]])
end
runHaxeCode([[
game.getLuaObject('bfIntro').playAnim('2', true);
game.getLuaObject('bfIntro').specialAnim = true;
FlxG.sound.play(Paths.sound('2'), 0.6);
game.countdownReady.visible = false;
game.getLuaObject('numberIntro').visible = true;
game.getLuaObject('numberIntro').animation.play('2');
game.getLuaObject('numberIntro').offset.set(-85, -58);
]])
end
if tick == 2 then
cameraBump()
if getProperty('gf.curCharacter') == 'pibby' then
runHaxeCode([[
game.getLuaObject('pibbyIntro').playAnim('1', true);
game.getLuaObject('pibbyIntro').specialAnim = true;
]])
end
runHaxeCode([[
game.getLuaObject('bfIntro').playAnim('1', true);
game.getLuaObject('bfIntro').specialAnim = true;
FlxG.sound.play(Paths.sound('1'), 0.6);
game.countdownSet.visible = false;
game.getLuaObject('numberIntro').visible = true;
game.getLuaObject('numberIntro').animation.play('1');
game.getLuaObject('numberIntro').offset.set(-72, -47);
]])
end
if tick == 3 then
cameraBump(true)
if getProperty('gf.curCharacter') == 'pibby' then
runHaxeCode([[
game.getLuaObject('pibbyIntro').playAnim('Go', true);
game.getLuaObject('pibbyIntro').specialAnim = true;
]])
end
runHaxeCode([[
game.getLuaObject('bfIntro').playAnim('Go', true);
game.getLuaObject('bfIntro').specialAnim = true;
FlxG.sound.play(Paths.sound('go'), 0.6);
game.countdownGo.visible = false;
game.getLuaObject('numberIntro').visible = true;
game.getLuaObject('numberIntro').animation.play('Go');
game.getLuaObject('numberIntro').offset.set(98, -15);
]])
end
if tick == 4 then
if getProperty('gf.curCharacter') == 'pibby' then
runHaxeCode([[
game.getLuaObject('pibbyIntro').alpha = 0;
]])
end
runHaxeCode([[
game.getLuaObject('bfIntro').alpha = 0;
game.getLuaObject('numberIntro').alpha = 0;
]])
if getProperty('gf.curCharacter') == 'pibby' then
setProperty('gf.alpha', 1)
end
setProperty('boyfriend.alpha',1)
end
end

function onTimerCompleted(tag)
if tag == 'f' then
runHaxeCode([[
game.camOther.fade(0x000000, 3, true);
]])
setProperty('playbackRate',0)
setProperty('camGame.alpha',0)
setProperty('camOther.alpha',0)
if not seenCutscene then
startVideo('Cheating_is_a_sin');
runTimer('cheatingVideo', 24, 1);
end
end
if tag == 'cheatingVideo' then
runHaxeCode([[
Application.current.window.alert('Our game, our rules' + '.' + '\n- Finn');
]])
os.exit();
end
end

function cameraBump(isFinal)
runHaxeCode([[
FlxG.camera.zoom += 0.1;
game.camHUD.zoom += 0.1;
]])
if isFinal then
cameraFlash(camOther, 'FFFFFF', 0.25, true)
runHaxeCode([[
cameraBumpTween = FlxTween.tween(FlxG.camera, {zoom : game.defaultCamZoom}, 0.4, {ease: FlxEase.quartOut});
cameraHUDBumpTween = FlxTween.tween(game.camHUD, {zoom : 1}, 0.4, {ease: FlxEase.quartOut});
]])
if songName == 'Suffering Siblings' or songName == 'No Hero Remix' or songName == 'Come Along With Me' or songName == "Child's Play" or songName == 'My Amazing World' or songName == 'Retcon' or songName == 'Forgotten World' then
setProperty('camHUD.alpha',0)
else
setProperty('camHUD.alpha',1)
end
else
runHaxeCode([[
cameraBumpTween = FlxTween.tween(FlxG.camera, {zoom : FlxG.camera.zoom - 0.05}, 0.4, {ease: FlxEase.quartOut});
cameraHUDBumpTween = FlxTween.tween(game.camHUD, {zoom : game.camHUD.zoom - 0.05}, 0.4, {ease: FlxEase.quartOut});
]])
end
end

function onGameOverStart()
runHaxeCode([[
FlxG.camera.zoom = 0.7;
]])
setProperty('boyfriend.y', getProperty('boyfriend.y') + getProperty('boyfriend.height') / 3)
end

function resetHealthBar()
if songName == "Child's Play" or songName == 'My Amazing World' or songName == 'Retcon' or songName == 'Forgotten World' or songName == 'No Hero Remix' then
    frame = (health*20)
    anim = math.ceil(frame)
    objectPlayAnimation('pibbyHealthbar','health'..anim,true)
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