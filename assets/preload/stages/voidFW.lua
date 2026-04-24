local charColors = {'969494', 'BFE5BA'}
local houseColors = {'8f8f8f', '9ADA91'}
local rockColors = {'bababa', 'B8D4B5'}
local coolThingColors = {'c4c0c0', 'C1CEAA'}

local timerShit = 0.7
local timerShit2 = 0.7

function onCreate()
initLuaShader('pixel')
initLuaShader('file')
	makeLuaSprite('pixelobject')
	makeGraphic('pixelobject', screenWidth, screenHeight)
	makeLuaSprite('fileobject')
	makeGraphic('fileobject', screenWidth, screenHeight)
makeLuaSprite('voidb', 'stages/voidFW/void3/1b', 0, -200);
setProperty('voidb.scale.x',1.2)
setProperty('voidb.scale.y',1.2)
setProperty('voidb.antialiasing',true)
setScrollFactor('voidb', 0.6, 0.6);
updateHitbox('voidb');
setProperty('voidb.visible',false)
runHaxeCode([[
    void = new FlxSprite(0, -200);
    void.frames = Paths.getSparrowAtlas('stages/voidFW/void');
    void.animation.addByPrefix('idle', 'idle', 24, true);
    void.animation.play('idle');
    void.setGraphicSize(Std.int(void.width * 1.7));
    void.antialiasing = true;
    void.scrollFactor.set(0.6, 0.6);
    void.updateHitbox();
    game.addBehindGF(void);

var coolShader = game.createRuntimeShader('file');
game.getLuaObject('fileobject').shader = coolShader;
    if (ClientPrefs.shaders) game.getLuaObject('voidb').shader = coolShader;

   if (!ClientPrefs.lowQuality)
   {
var pixel = game.createRuntimeShader('pixel');
pixel.setFloat("size", 10);
game.getLuaObject('pixelobject').shader = pixel;

        chatImLazyToDoMathematicalShitSoHeresACopyOfScaryGlitchAhh = new FlxSprite(-500, -300);
        chatImLazyToDoMathematicalShitSoHeresACopyOfScaryGlitchAhh.loadGraphic(Paths.image('stages/voidFW/void3/2b'));
        chatImLazyToDoMathematicalShitSoHeresACopyOfScaryGlitchAhh.scale.set(1.2, 1.2);
        chatImLazyToDoMathematicalShitSoHeresACopyOfScaryGlitchAhh.antialiasing = ClientPrefs.globalAntialiasing;
        chatImLazyToDoMathematicalShitSoHeresACopyOfScaryGlitchAhh.scrollFactor.set(0.6, 0.6);
        chatImLazyToDoMathematicalShitSoHeresACopyOfScaryGlitchAhh.updateHitbox();
        if (ClientPrefs.shaders) chatImLazyToDoMathematicalShitSoHeresACopyOfScaryGlitchAhh.shader = pixel;

        scaryGlitchAhh = new FlxSprite(0, -200);
        scaryGlitchAhh.loadGraphic(Paths.image('stages/voidFW/void3/2b'));
        scaryGlitchAhh.scale.set(1.2, 1.2);
        scaryGlitchAhh.antialiasing = ClientPrefs.globalAntialiasing;
        scaryGlitchAhh.scrollFactor.set(0.6, 0.6);
        scaryGlitchAhh.updateHitbox();
        scaryGlitchAhh.visible = false;
        if (ClientPrefs.shaders) scaryGlitchAhh.shader = pixel;

        moreGlitchWaaaButBehindTheRock = new FlxSprite(0, -200);
        moreGlitchWaaaButBehindTheRock.loadGraphic(Paths.image('stages/voidFW/void3/2b'));
        moreGlitchWaaaButBehindTheRock.scale.set(1.2, 1.2);
        moreGlitchWaaaButBehindTheRock.antialiasing = ClientPrefs.globalAntialiasing;
        moreGlitchWaaaButBehindTheRock.scrollFactor.set(0.6, 0.6);
        moreGlitchWaaaButBehindTheRock.updateHitbox();
        moreGlitchWaaaButBehindTheRock.visible = false;
        if (ClientPrefs.shaders) moreGlitchWaaaButBehindTheRock.shader = pixel;

        moreGlitchWaaa = new FlxSprite(0, 210);
        moreGlitchWaaa.loadGraphic(Paths.image('stages/voidFW/void3/2b', 'image'));
        moreGlitchWaaa.scale.set(1.2, 1.2);
        moreGlitchWaaa.antialiasing = ClientPrefs.globalAntialiasing;
        moreGlitchWaaa.scrollFactor.set(1.1, 1.1);
        moreGlitchWaaa.updateHitbox();
        moreGlitchWaaa.visible = false;
        if (ClientPrefs.shaders) moreGlitchWaaa.shader = pixel;

        foregroundGlitch = new FlxSprite(200, 0);
        foregroundGlitch.loadGraphic(Paths.image('stages/voidFW/Ilustracion_sin_titulo-9'));
        foregroundGlitch.setGraphicSize(Std.int(foregroundGlitch.width * 2.33));
        foregroundGlitch.antialiasing = ClientPrefs.globalAntialiasing;
        foregroundGlitch.scrollFactor.set(1.2, 1.2);
        foregroundGlitch.updateHitbox();
        if (ClientPrefs.shaders) foregroundGlitch.shader = pixel;

game.variables.set('chatImLazyToDoMathematicalShitSoHeresACopyOfScaryGlitchAhh',chatImLazyToDoMathematicalShitSoHeresACopyOfScaryGlitchAhh);
game.variables.set('scaryGlitchAhh',scaryGlitchAhh);
game.variables.set('moreGlitchWaaaButBehindTheRock', moreGlitchWaaaButBehindTheRock);
game.variables.set('moreGlitchWaaa',moreGlitchWaaa);
game.variables.set('foregroundGlitch',foregroundGlitch);
   }

game.variables.set('void',void);
game.variables.set('voidb',voidb);
]])

makeLuaSprite('house', 'stages/voidFW/Ilustracion_sin_titulo-3', 0, -200);
setGraphicSize('house',getProperty('house.width') * 2.5)
setProperty('house.antialiasing',true)
setScrollFactor('house', 0.85, 0.85);
updateHitbox('house');
setProperty('house.color',getColorFromHex(houseColors[1]))

makeLuaSprite('rock', 'stages/voidFW/Ilustracion_sin_titulo-4', 0, -200);
setGraphicSize('rock',getProperty('rock.width') * 2.5)
setProperty('rock.antialiasing',true)
setScrollFactor('rock', 1, 1);
updateHitbox('rock');
setProperty('rock.color',getColorFromHex(rockColors[1]))

makeLuaSprite('rock2', 'stages/voidFW/Ilustracion_sin_titulo-5', 0, -200);
setGraphicSize('rock2',getProperty('rock2.width') * 2.5)
setProperty('rock2.antialiasing',true)
setScrollFactor('rock2', 1.3, 0.7);
updateHitbox('rock2');

makeLuaSprite('houseb', 'stages/voidFW/void3/3b', 0, -200);
setProperty('houseb.scale.x',1.2)
setProperty('houseb.scale.y',1.2)
setProperty('houseb.antialiasing',true)
setScrollFactor('houseb', 0.85, 0.85);
updateHitbox('houseb');
setProperty('houseb.visible',false)

makeLuaSprite('rockb', 'stages/voidFW/void3/5b', 0, -200);
setProperty('rockb.scale.x',1.2)
setProperty('rockb.scale.y',1.2)
setProperty('rockb.antialiasing',true)
setScrollFactor('rockb', 1, 1);
updateHitbox('rockb');
setProperty('rockb.visible',false)

makeLuaSprite('rock2b', 'stages/voidFW/void3/11', 0, -200);
setProperty('rock2b.scale.x',1.2)
setProperty('rock2b.scale.y',1.2)
setProperty('rock2b.antialiasing',true)
setScrollFactor('rock2b', 1.3, 0.7);
updateHitbox('rock2b');
setProperty('rock2b.visible',false)

if not getPropertyFromClass('ClientPrefs','lowQuality') then
makeLuaSprite('rock3', 'stages/voidFW/Ilustracion_sin_titulo-6', 0, -200);
setGraphicSize('rock3',getProperty('rock3.width') * 2.5)
setProperty('rock3.antialiasing',true)
setScrollFactor('rock3', 0.9, 0.9);
updateHitbox('rock3');
setProperty('rock3.color',getColorFromHex(houseColors[1]))

makeLuaSprite('rock4', 'stages/voidFW/Ilustracion_sin_titulo-7', 0, -200);
setGraphicSize('rock4',getProperty('rock4.width') * 2.5)
setProperty('rock4.antialiasing',true)
setScrollFactor('rock4', 0.85, 0.85);
updateHitbox('rock4');
setProperty('rock4.color',getColorFromHex(houseColors[1]))

makeLuaSprite('wtf', 'stages/voidFW/Ilustracion_sin_titulo-8', 0, -200);
setGraphicSize('wtf',getProperty('wtf.width') * 2.5)
setProperty('wtf.antialiasing',true)
setScrollFactor('wtf', 1, 1);
updateHitbox('wtf');
setProperty('wtf.color',getColorFromHex(coolThingColors[1]))

makeLuaSprite('rock3b', 'stages/voidFW/void3/11', 0, -200);
setProperty('rock3b.scale.x',1.2)
setProperty('rock3b.scale.y',1.2)
setProperty('rock3b.antialiasing',true)
setScrollFactor('rock3b', 0.9, 0.9);
updateHitbox('rock3b');
setProperty('rock3b.visible',false)

makeLuaSprite('rock4b', 'stages/voidFW/void3/4', 0, -200);
setProperty('rock4b.scale.x',1.2)
setProperty('rock4b.scale.y',1.2)
setProperty('rock4b.antialiasing',true)
setScrollFactor('rock4b', 0.85, 0.85);
updateHitbox('rock4b');
setProperty('rock4b.visible',false)

makeLuaSprite('wtfb', 'stages/voidFW/void3/6', 0, -200);
setProperty('wtfb.scale.x',1.2)
setProperty('wtfb.scale.y',1.2)
setProperty('wtfb.antialiasing',true)
setScrollFactor('wtfb', 1, 1);
updateHitbox('wtfb');
setProperty('wtfb.visible',false)

addLuaSprite('rock4', false);
doTweenAngle('rock4angle', 'rock4', 360, 30, 'sineInOut')
addLuaSprite('rock3', false);
addLuaSprite('wtf', false);
doTweenAngle('rock3angle', 'rock3', 360, 30, 'sineInOut')
doTweenAngle('wtfangle', 'wtf', 2, 5, 'sineInOut')
end

addLuaSprite('rock2', false);
addLuaSprite('house', false);
doTweenAngle('houseangle', 'house', 4, 6, 'sineInOut')
doTweenAngle('rock2angle', 'rock2', -2, 2.5, 'sineInOut')
runHaxeCode([[
   if (!ClientPrefs.lowQuality)
   {
game.addBehindGF(chatImLazyToDoMathematicalShitSoHeresACopyOfScaryGlitchAhh);
   }
]])
addLuaSprite('rock', false);
addLuaSprite('voidb', false);
runHaxeCode([[
   if (!ClientPrefs.lowQuality)
   {
game.addBehindGF(scaryGlitchAhh);
game.addBehindGF(moreGlitchWaaaButBehindTheRock);
   }
]])
if not getPropertyFromClass('ClientPrefs','lowQuality') then
addLuaSprite('rock4b', false);
doTweenX('rock4bx', 'rock4b', 2500, timerShit2, 'sineInOut')
addLuaSprite('rock3b', false);
doTweenAngle('rock3bangle', 'rock3b', 360, 30, 'sineInOut')
end
addLuaSprite('rock2b', false);
doTweenAngle('rock2bangle', 'rock2b', -2, 2.5, 'sineInOut')
addLuaSprite('houseb', false);
doTweenAngle('housebangle', 'houseb', 16, 6, 'sineInOut')
doTweenX('housebx', 'houseb', 2000, timerShit2, 'sineInOut')
addLuaSprite('rockb', false);
doTweenAngle('rockbangle', 'rockb', -0.5, 2.5, 'sineInOut')
if not getPropertyFromClass('ClientPrefs','lowQuality') then
addLuaSprite('wtfb', false);
doTweenAngle('wtfbangle', 'wtfb', 5, 3, 'sineInOut')
end
runHaxeCode([[
   if (!ClientPrefs.lowQuality)
   {
game.add(moreGlitchWaaa);
game.addBehindGF(foregroundGlitch);
   }
]])
end

function onUpdate()
setShaderFloat("fileobject", "iTime", os.clock())
end

local angleSpeed = 0;
local angleValue = 0;

function onSongStart()
setProperty('boyfriend.color',getColorFromHex(charColors[1]))
setProperty('dad.color',getColorFromHex(charColors[1]))
setProperty('gf.color',getColorFromHex(charColors[1]))

angleSpeed = 1;
angleValue = 1;
end

function onStepHit()
if curStep == 513 then
doTweenAngle('boyfriendangle', 'boyfriend', -2.1, 2.5, 'sineInOut')
doTweenAngle('dadangle', 'dad', -2.1, 2.5, 'sineInOut')
doTweenAngle('rockangle', 'rock', -0.8, 2.5, 'sineInOut')
end
if curStep == 1438 then
angleSpeed = 0.8;
doTweenAngle('boyfriendangle3', 'boyfriend', 0, 0.0001, 'sineInOut')
doTweenAngle('dadangle3', 'dad', 0.0001, 2.5, 'sineInOut')
setProperty('voidb.visible',true)
runHaxeCode([[
        void.visible = false;
        if (!ClientPrefs.lowQuality) scaryGlitchAhh.visible = true;
        if (!ClientPrefs.lowQuality) moreGlitchWaaa.visible = true;
        if (!ClientPrefs.lowQuality) moreGlitchWaaaButBehindTheRock.visible = true;
]])
if not getPropertyFromClass('ClientPrefs','lowQuality') then
setProperty('wtf.visible',false)
setProperty('rock3.visible',false)
setProperty('rock4.visible',false)
setProperty('rock3b.visible',true)
setProperty('rock4b.visible',true)
setProperty('wtfb.visible',true)
end
setProperty('rock.visible',false)
setProperty('rock2.visible',false)
setProperty('house.visible',false)
setProperty('rockb.visible',true)
setProperty('rock2b.visible',true)
setProperty('houseb.visible',true)
end
if curStep == 516 then
setProperty('boyfriend.color',getColorFromHex('a8a4a4'))
setProperty('dad.color',getColorFromHex('a8a4a4'))
setProperty('gf.color',getColorFromHex('a8a4a4'))
end
end

function onBeatHit()
setShaderFloat('pixelobject',"size", getRandomInt(5, 15));
end

function onTweenCompleted(tag)
	if tag == 'houseangle' then
doTweenAngle('houseangle2', 'house', -4 * angleValue, 6 / angleSpeed, 'sineInOut')
	end
	if tag == 'houseangle2' then
doTweenAngle('houseangle', 'house', 4 * angleValue, 6 / angleSpeed, 'sineInOut')
	end
	if tag == 'rock2angle' then
doTweenAngle('rock2angle2', 'rock2', 1.2 * angleValue, 6 / angleSpeed, 'sineInOut')
	end
	if tag == 'rock2angle2' then
doTweenAngle('rock2angle', 'rock2', -2 * angleValue, 6 / angleSpeed, 'sineInOut')
	end
	if tag == 'rock3angle' then
doTweenAngle('rock3angle2', 'rock3', 0 * angleValue, 6 / angleSpeed, 'sineInOut')
	end
	if tag == 'rock3angle2' then
doTweenAngle('rock3angle', 'rock3', 360 * angleValue, 6 / angleSpeed, 'sineInOut')
	end
	if tag == 'wtfangle' then
doTweenAngle('wtfangle2', 'wtf', -2 * angleValue, 5 / angleSpeed, 'sineInOut')
	end
	if tag == 'wtfangle2' then
doTweenAngle('wtfangle', 'wtf', 2 * angleValue, 5 / angleSpeed, 'sineInOut')
	end
	if tag == 'boyfriendangle' then
doTweenAngle('boyfriendangle2', 'boyfriend', 2.1 * angleValue, 2.5 / angleSpeed, 'sineInOut')
	end
	if tag == 'boyfriendangle2' then
doTweenAngle('boyfriendangle', 'boyfriend', -2.1 * angleValue, 2.5 / angleSpeed, 'sineInOut')
	end
	if tag == 'boyfriendangle3' then
doTweenAngle('boyfriendangle3', 'boyfriend', 0 * angleValue, 0.0001 / angleSpeed, 'sineInOut')
	end
	if tag == 'dadangle' then
doTweenAngle('dadangle2', 'dad', 2.1 * angleValue, 2.5 / angleSpeed, 'sineInOut')
	end
	if tag == 'dadangle2' then
doTweenAngle('dadangle', 'dad', -2.1 * angleValue, 2.5 / angleSpeed, 'sineInOut')
	end
	if tag == 'dadangle3' then
doTweenAngle('dadangle3', 'dad', 0 * angleValue, 0.0001 / angleSpeed, 'sineInOut')
	end
	if tag == 'rockangle' then
doTweenAngle('rockangle2', 'rock', 0.8 * angleValue, 2.5 / angleSpeed, 'sineInOut')
	end
	if tag == 'rockangle2' then
doTweenAngle('rockangle', 'rock', -0.8 * angleValue, 2.5 / angleSpeed, 'sineInOut')
	end
	if tag == 'housebangle2' then
doTweenAngle('housebangle', 'houseb', -12 * angleValue, 6 / angleSpeed, 'sineInOut')
	end
	if tag == 'housebangle2' then
doTweenAngle('housebangle', 'houseb', 16 * angleValue, 6 / angleSpeed, 'sineInOut')
	end
	if tag == 'rockbangle2' then
doTweenAngle('rockbangle', 'rockb', 0.5 * angleValue, 2.5 / angleSpeed, 'sineInOut')
	end
	if tag == 'rockbangle2' then
doTweenAngle('rockbangle', 'rockb', -0.5 * angleValue, 2.5 / angleSpeed, 'sineInOut')
	end
	if tag == 'rock2bangle2' then
doTweenAngle('rock2bangle', 'rock2b', 1.2 * angleValue, 2.5 / angleSpeed, 'sineInOut')
	end
	if tag == 'rock2bangle2' then
doTweenAngle('rock2bangle', 'rock2b', -2 * angleValue, 2.5 / angleSpeed, 'sineInOut')
	end
	if tag == 'rock3bangle2' then
doTweenAngle('rock3bangle', 'rock3b', 0 * angleValue, 30 / angleSpeed, 'sineInOut')
	end
	if tag == 'rock3bangle2' then
doTweenAngle('rock3bangle', 'rock3b', 360 * angleValue, 30 / angleSpeed, 'sineInOut')
	end
	if tag == 'wtfbangle' then
doTweenAngle('wtfbangle2', 'wtfb', -5 * angleValue, 3 / angleSpeed, 'sineInOut')
	end
	if tag == 'wtfbangle2' then
doTweenAngle('wtfbangle', 'wtfb', 5 * angleValue, 3 / angleSpeed, 'sineInOut')
	end
	if tag == 'housebx' then
timerShit2 = getRandomFloat(4, 9)
setProperty('houseb.x',-1800)
setProperty('houseb.scale.x',getRandomInt(0.75, 1.1))
setProperty('houseb.scale.y',getProperty('houseb.scale.x'))
doTweenX('housebx2', 'houseb', 2000, timerShit2, 'sineInOut')
	end
	if tag == 'housebx2' then
timerShit2 = getRandomFloat(4, 9)
setProperty('houseb.x',-1800)
setProperty('houseb.scale.x',getRandomInt(0.75, 1.1))
setProperty('houseb.scale.y',getProperty('houseb.scale.x'))
doTweenX('housebx', 'houseb', 2000, timerShit2, 'sineInOut')
	end
	if tag == 'rock4bx' then
timerShit2 = getRandomFloat(3, 7)
setProperty('rock4b.x',-1800)
setProperty('rock4b.scale.x',getRandomInt(0.75, 1.1))
setProperty('rock4b.scale.y',getProperty('rock4b.scale.x'))
doTweenX('rock4bx2', 'rock4b', 2500, timerShit2, 'sineInOut')
	end
	if tag == 'rock4bx2' then
timerShit2 = getRandomFloat(3, 7)
setProperty('rock4b.x',-1800)
setProperty('rock4b.scale.x',getRandomInt(0.75, 1.1))
setProperty('rock4b.scale.y',getProperty('rock4b.scale.x'))
doTweenX('rock4bx', 'rock4b', 2500, timerShit2, 'sineInOut')
	end
end