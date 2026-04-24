local charColors = {'969494', 'BFE5BA'}
local houseColors = {'8f8f8f', '9ADA91'}
local rockColors = {'bababa', 'B8D4B5'}
local coolThingColors = {'c4c0c0', 'C1CEAA'}

function onCreate()
runHaxeCode([[
    void = new FlxSprite(-80, -200);
    void.frames = Paths.getSparrowAtlas('stages/schoolMAW/void/void');
    void.animation.addByPrefix('idle', 'idle', 24, true);
    void.animation.play('idle');
    void.setGraphicSize(Std.int(void.width * 1.7));
    void.antialiasing = true;
    void.scrollFactor.set(0.4, 0.4);
    void.updateHitbox();
    game.addBehindGF(void);
]])

makeLuaSprite('background', 'stages/schoolMAW/Ilustracion_sin_titulo-1', 0, 0);
setGraphicSize('background',getProperty('background.width') * 1.3)
setProperty('background.antialiasing',true)
setScrollFactor('background', 1, 1);
updateHitbox('background');
addLuaSprite('background', false);

    runHaxeCode([[
    ch1 = new FlxSprite(100, 150);
    ch1.loadGraphic(Paths.image('stages/schoolMAW/channels/chn1'));
    ch1.setGraphicSize(Std.int(ch1.width * 1));
    ch1.antialiasing = ClientPrefs.globalAntialiasing;
    ch1.scrollFactor.set(1, 1);
    ch1.updateHitbox();

    ch2 = new FlxSprite(125, -20);
    ch2.loadGraphic(Paths.image('stages/schoolMAW/channels/chn2'));
    ch2.setGraphicSize(Std.int(ch2.width * 1));
    ch2.antialiasing = ClientPrefs.globalAntialiasing;
    ch2.scrollFactor.set(1, 1);
    ch2.updateHitbox();

    ch3 = new FlxSprite(100, 150);
    ch3.loadGraphic(Paths.image('stages/schoolMAW/channels/chn3'));
    ch3.setGraphicSize(Std.int(ch1.width * 1));
    ch3.antialiasing = ClientPrefs.globalAntialiasing;
    ch3.scrollFactor.set(1, 1);
    ch3.updateHitbox();
    ch3.scale.x += 0.2; // just in case....

game.variables.set('ch1',ch1);
game.variables.set('ch2',ch2);
game.variables.set('ch3',ch3);
]])

makeLuaSprite('wall', 'stages/schoolMAW/Ilustracion_sin_titulo-2', -200, 200);
setGraphicSize('wall',getProperty('wall.width') * 1.1)
setProperty('wall.antialiasing',true)
setScrollFactor('wall', 1, 1);
updateHitbox('wall');

if not getPropertyFromClass('ClientPrefs','lowQuality') then
addLuaSprite('wall', true);
end

initLuaShader('pixel')
    runHaxeCode([[
var pixel = game.createRuntimeShader('pixel');
pixel.setFloat("size", 10);

        daGloop = new FlxSprite();
        daGloop.x = 50;
        daGloop.y = 110;
        daGloop.scale.set(1.5, 1.5);
        daGloop.frames = Paths.getSparrowAtlas('stages/schoolMAW/topgoop');
        daGloop.animation.addByPrefix('topey', 'gooey', 24, false);
        if(ClientPrefs.shaders) daGloop.shader = pixel;

        daGloop2 = new FlxSprite();
        daGloop2.x = 1450;
        daGloop2.y = 110;
        daGloop2.scale.set(1.5, 1.5);
        daGloop2.frames = Paths.getSparrowAtlas('stages/schoolMAW/secondtopgoop');
        daGloop2.animation.addByPrefix('topey2', 'gooey', 24, false);
        if(ClientPrefs.shaders) daGloop2.shader = pixel;

        daGloop4 = new FlxSprite();
        daGloop4.x = 910;
        daGloop4.y = 300;
        daGloop4.scale.set(1.7, 1.7);
        daGloop4.frames = Paths.getSparrowAtlas('stages/schoolMAW/droplet');
        daGloop4.animation.addByPrefix('dropey', 'gooey', 24, false);
        if(ClientPrefs.shaders) daGloop4.shader = pixel;

        daGloop5 = new FlxSprite();
        daGloop5.x = 715;
        daGloop5.y = 595;
        daGloop5.scale.set(1.7, 1.7);
        daGloop5.frames = Paths.getSparrowAtlas('stages/schoolMAW/sinkgoop');
        daGloop5.animation.addByPrefix('sinkey', 'gooey', 24, false);
        if(ClientPrefs.shaders) daGloop5.shader = pixel;

        penny = new FlxSprite();
        penny.x = 800;
        penny.y = 220;
        penny.scale.set(1.3, 1.3);
        penny.frames = Paths.getSparrowAtlas('stages/schoolMAW/penny');
        penny.animation.addByPrefix('idle', 'idle', 6, true);

    if (!ClientPrefs.lowQuality) game.addBehindGF(daGloop5);
    if (!ClientPrefs.lowQuality) game.addBehindGF(daGloop4);
    if (!ClientPrefs.lowQuality) game.addBehindGF(penny);
    if (!ClientPrefs.lowQuality) game.add(daGloop);
    if (!ClientPrefs.lowQuality) game.add(daGloop2);
    if (!ClientPrefs.lowQuality) game.add(vignette);
    if (!ClientPrefs.lowQuality) game.add(vignette2);
    if (!ClientPrefs.lowQuality) game.add(light);

game.variables.set('daGloop',daGloop);
game.variables.set('daGloop2',daGloop2);
game.variables.set('daGloop5',daGloop5);
game.variables.set('daGloop4',daGloop4);
game.variables.set('penny',penny);
]])

makeLuaSprite('house', 'stages/schoolMAW/void/Ilustracion_sin_titulo-2', 0, -200);
setGraphicSize('house',getProperty('house.width') * 2.5)
setProperty('house.antialiasing',true)
setScrollFactor('house', 0.85, 0.85);
updateHitbox('house');
setProperty('house.color',getColorFromHex(houseColors[1]))

makeLuaSprite('rock', 'stages/schoolMAW/void/Ilustracion_sin_titulo-3', 0, -200);
setGraphicSize('rock',getProperty('rock.width') * 2.5)
setProperty('rock.antialiasing',true)
setScrollFactor('rock', 1, 1);
updateHitbox('rock');
setProperty('rock.color',getColorFromHex(rockColors[1]))

if not getPropertyFromClass('ClientPrefs','lowQuality') then
makeLuaSprite('rock2', 'stages/schoolMAW/void/Ilustracion_sin_titulo-4', 0, -200);
setGraphicSize('rock2',getProperty('rock2.width') * 2.5)
setProperty('rock2.antialiasing',true)
setScrollFactor('rock2', 1.1, 1.1);
updateHitbox('rock2');

makeLuaSprite('rock3', 'stages/schoolMAW/void/Ilustracion_sin_titulo-5', 0, -200);
setGraphicSize('rock3',getProperty('rock3.width') * 2.5)
setProperty('rock3.antialiasing',true)
setScrollFactor('rock3', 0.9, 0.9);
updateHitbox('rock3');
setProperty('rock3.color',getColorFromHex(houseColors[1]))

makeLuaSprite('rock4', 'stages/schoolMAW/void/Ilustracion_sin_titulo-6', 0, -200);
setGraphicSize('rock4',getProperty('rock4.width') * 2.5)
setProperty('rock4.antialiasing',true)
setScrollFactor('rock4', 0.85, 0.85);
updateHitbox('rock4');
setProperty('rock4.color',getColorFromHex(houseColors[1]))

makeLuaSprite('wtf', 'stages/schoolMAW/void/Ilustracion_sin_titulo-7', 0, -200);
setGraphicSize('wtf',getProperty('wtf.width') * 2.5)
setProperty('wtf.antialiasing',true)
setScrollFactor('wtf', 1, 1);
updateHitbox('wtf');
setProperty('wtf.color',getColorFromHex(coolThingColors[1]))

doTweenAngle('houseangle', 'house', 4, 6, 'sineInOut')
doTweenAngle('rockangle', 'rock', -0.5, 2.5, 'sineInOut')
doTweenAngle('rock2angle', 'rock2', -2, 2.5, 'sineInOut')
doTweenAngle('rock3angle', 'rock3', 360, 30, 'sineInOut')
doTweenAngle('wtfangle', 'wtf', 2, 5, 'sineInOut')

doTweenAngle('rock4angle', 'rock4', 360, 30, 'sineInOut')
end

makeLuaSprite('light', 'stages/schoolMAW/light', -500, 50);
setGraphicSize('light',getProperty('light.width') * 1)
setProperty('light.antialiasing',true)
setScrollFactor('light', 1, 1);
updateHitbox('light');

makeLuaSprite('vignette', 'stages/schoolMAW/Ilustracion_sin_titulo-3', 0, 0);
setGraphicSize('vignette',getProperty('vignette.width') * 1.3)
setProperty('vignette.antialiasing',true)
setScrollFactor('vignette', 1, 1);
updateHitbox('vignette');

makeLuaSprite('vignette2', 'stages/schoolMAW/188_sin_titulo11_20230523094718', 0, 0);
setGraphicSize('vignette2',getProperty('vignette2.width') * 1.3)
setProperty('vignette2.antialiasing',true)
setScrollFactor('vignette2', 1, 1);
updateHitbox('vignette2');

if not getPropertyFromClass('ClientPrefs','lowQuality') then
addLuaSprite('vignette', true);
addLuaSprite('vignette2', true);
addLuaSprite('light', true);
end
end

local followchars = true;
local didit = false;
local dadit = false;
local bfit = false;

function onUpdate()
if followchars == true then
if mustHitSection == false then
dadit = true;
if dadit and bfit then
didit = false;
bfit = false;
end
if didit == false then
setProperty('defaultCamZoom',1.2)
didit = true;
end
else
bfit = true;
if bfit and dadit then
didit = false;
dadit = false;
end
if didit == false then
setProperty('defaultCamZoom',0.9)
didit = true;
end
end
end
if followchars == false then
triggerEvent('Camera Follow Pos',940,720)
end
end

function onSongStart()
setProperty('camZooming',true)
setProperty('dad.x',300)
setProperty('dad.y',450)
end

function onStepHit()
if curStep == 2144 then
followchars = false;
triggerEvent('Camera Follow Pos',940,720)
    runHaxeCode([[
                if (!ClientPrefs.lowQuality) game.getLuaObject('wall').visible = false;
                if (!ClientPrefs.lowQuality) game.getLuaObject('vignette2').visible = false; 
                if (!ClientPrefs.lowQuality) game.getLuaObject('vignette').visible = false;
                game.getLuaObject('background').visible = false;
                if (!ClientPrefs.lowQuality) game.getLuaObject('light').visible = false;
                if (!ClientPrefs.lowQuality) daGloop5.visible = false;
                if (!ClientPrefs.lowQuality) daGloop4.visible = false;
                if (!ClientPrefs.lowQuality) daGloop2.visible = false;
                if (!ClientPrefs.lowQuality) daGloop.visible = false;
                if (!ClientPrefs.lowQuality) penny.visible = false;
                game.addBehindGF(ch1);
]])
setProperty('gf.y',720)
end
if curStep == 2176 then
runHaxeCode([[
                ch1.visible = false;
                game.addBehindGF(ch2);
]])
end
if curStep == 2208 then
runHaxeCode([[
                ch2.visible = false;
                game.addBehindGF(ch3);
]])
end
if curStep == 2272 then
runHaxeCode([[
                ch3.visible = false;
                ch1.visible = true;
]])
end
if curStep == 2304 then
runHaxeCode([[
                ch1.visible = false;
                ch2.visible = true;
]])
end
if curStep == 2336 then
runHaxeCode([[
                ch2.visible = false;
                ch3.visible = true;
]])
end
if curStep == 2400 then
runHaxeCode([[
                ch3.visible = false;
                ch1.visible = true;
]])
end
if curStep == 2432 then
runHaxeCode([[
                ch1.visible = false;
                ch2.visible = true;
]])
end
if curStep == 2464 then
runHaxeCode([[
                ch2.visible = false;
                ch3.visible = true;
]])
end
if curStep == 2528 then
runHaxeCode([[
                ch3.visible = false;
                ch1.visible = true;
]])
end
if curStep == 2560 then
runHaxeCode([[
                ch1.visible = false;
                ch2.visible = true;
]])
end
if curStep == 2592 then
runHaxeCode([[
                ch2.visible = false;
                ch3.visible = true;
]])
end
if curStep == 2604 then
runHaxeCode([[
                ch3.visible = false;
                ch1.visible = true;
]])
end
if curStep == 2624 then
runHaxeCode([[
                ch1.visible = false;
                ch2.visible = true;
]])
end
if curStep == 2632 then
runHaxeCode([[
                ch2.visible = false;
                ch3.visible = true;
]])
end
if curStep == 2640 then
runHaxeCode([[
                ch3.visible = false;
                ch1.visible = true;
]])
end
if curStep == 2648 then
runHaxeCode([[
                ch1.visible = false;
                ch2.visible = true;
]])
end
if curStep == 2656 then
followchars = true;
triggerEvent('Camera Follow Pos',0,0)
runHaxeCode([[
                ch2.visible = false;
                ch3.visible = true;
]])
end
if curStep == 2688 then
if not getPropertyFromClass('ClientPrefs','lowQuality') then
addLuaSprite('rock4', false);
addLuaSprite('rock3', false);
addLuaSprite('rock2', false);
end
addLuaSprite('house', false);
addLuaSprite('rock', false);
if not getPropertyFromClass('ClientPrefs','lowQuality') then
addLuaSprite('wtf', false);
end
runHaxeCode([[
                ch1.visible = false;
                ch2.visible = false;
                ch3.visible = false;
]])
setProperty('gf.x',1670)
setProperty('gf.y',900)
setProperty('dad.x',900)
setProperty('dad.y',740)
setProperty('boyfriend.x',1570)
setProperty('boyfriend.y',800)
setProperty('boyfriend.color',getColorFromHex(charColors[1]))
setProperty('dad.color',getColorFromHex(charColors[1]))
setProperty('gf.color',getColorFromHex(charColors[1]))
end
end

function onBeatHit()
if curBeat % 1 == 0 then
    runHaxeCode([[
        if (!ClientPrefs.lowQuality) daGloop5.animation.play('sinkey');
        if (!ClientPrefs.lowQuality) daGloop4.animation.play('dropey');
        if (!ClientPrefs.lowQuality) daGloop2.animation.play('topey2');
        if (!ClientPrefs.lowQuality) daGloop.animation.play('topey');
        if (!ClientPrefs.lowQuality) penny.animation.play('idle');
]])
end
end

function onTweenCompleted(tag)
	if tag == 'houseangle' then
doTweenAngle('houseangle2', 'house', -4, 6, 'sineInOut')
	end
	if tag == 'houseangle2' then
doTweenAngle('houseangle', 'house', 4, 6, 'sineInOut')
	end
	if tag == 'rockangle' then
doTweenAngle('rockangle2', 'rock', 0.5, 2.5, 'sineInOut')
	end
	if tag == 'rockangle2' then
doTweenAngle('rockangle', 'rock', -0.5, 2.5, 'sineInOut')
	end
	if tag == 'rock2angle' then
doTweenAngle('rock2angle2', 'rock2', 1.2, 6, 'sineInOut')
	end
	if tag == 'rock2angle2' then
doTweenAngle('rock2angle', 'rock2', -2, 6, 'sineInOut')
	end
	if tag == 'rock3angle' then
doTweenAngle('rock3angle2', 'rock3', 0, 6, 'sineInOut')
	end
	if tag == 'rock3angle2' then
doTweenAngle('rock3angle', 'rock3', 360, 6, 'sineInOut')
	end
	if tag == 'wtfangle' then
doTweenAngle('wtfangle2', 'wtf', -2, 5, 'sineInOut')
	end
	if tag == 'wtfangle2' then
doTweenAngle('wtfangle', 'wtf', 2, 5, 'sineInOut')
	end
end