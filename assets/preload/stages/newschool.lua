function onCreate()
makeLuaSprite('background', 'stages/newschool/Ilustracion_sin_titulo-1', 0, 0);
setGraphicSize('background',getProperty('background.width') * 1.3)
setProperty('background.antialiasing',true)
setScrollFactor('background', 1, 1);
updateHitbox('background');
addLuaSprite('background', false);

makeLuaSprite('wall', 'stages/newschool/Ilustracion_sin_titulo-2', -200, 200);
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
        daGloop.frames = Paths.getSparrowAtlas('stages/newschool/topgoop');
        daGloop.animation.addByPrefix('topey', 'gooey', 24, false);
        if(ClientPrefs.shaders) daGloop.shader = pixel;

        daGloop2 = new FlxSprite();
        daGloop2.x = 1450;
        daGloop2.y = 110;
        daGloop2.scale.set(1.5, 1.5);
        daGloop2.frames = Paths.getSparrowAtlas('stages/newschool/secondtopgoop');
        daGloop2.animation.addByPrefix('topey2', 'gooey', 24, false);
        if(ClientPrefs.shaders) daGloop2.shader = pixel;

        daGloop4 = new FlxSprite();
        daGloop4.x = 910;
        daGloop4.y = 300;
        daGloop4.scale.set(1.7, 1.7);
        daGloop4.frames = Paths.getSparrowAtlas('stages/newschool/droplet');
        daGloop4.animation.addByPrefix('dropey', 'gooey', 24, false);
        if(ClientPrefs.shaders) daGloop4.shader = pixel;

        daGloop5 = new FlxSprite();
        daGloop5.x = 715;
        daGloop5.y = 595;
        daGloop5.scale.set(1.7, 1.7);
        daGloop5.frames = Paths.getSparrowAtlas('stages/newschool/sinkgoop');
        daGloop5.animation.addByPrefix('sinkey', 'gooey', 24, false);
        if(ClientPrefs.shaders) daGloop5.shader = pixel;

        penny = new FlxSprite();
        penny.x = 800;
        penny.y = 220;
        penny.scale.set(1.3, 1.3);
        penny.frames = Paths.getSparrowAtlas('stages/newschool/penny');
        penny.animation.addByPrefix('idle', 'idle', 6, true);

    if (!ClientPrefs.lowQuality) game.add(daGloop);
    if (!ClientPrefs.lowQuality) game.add(daGloop2);

    if (!ClientPrefs.lowQuality) daGloop.alpha = 0.0001;
    if (!ClientPrefs.lowQuality) daGloop2.alpha = 0.0001;

game.variables.set('daGloop',daGloop);
game.variables.set('daGloop2',daGloop2);
game.variables.set('daGloop5',daGloop5);
game.variables.set('daGloop4',daGloop4);
game.variables.set('penny',penny);
]])

makeLuaSprite('light', 'stages/newschool/light', -500, 50);
setGraphicSize('light',getProperty('light.width') * 1)
setProperty('light.antialiasing',true)
setScrollFactor('light', 1, 1);
updateHitbox('light');

makeLuaSprite('vignette', 'stages/newschool/Ilustracion_sin_titulo-3', 0, 0);
setGraphicSize('vignette',getProperty('vignette.width') * 1.3)
setProperty('vignette.antialiasing',true)
setScrollFactor('vignette', 1, 1);
updateHitbox('vignette');

makeLuaSprite('vignette2', 'stages/newschool/188_sin_titulo11_20230523094718', 0, 0);
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

function onCreatePost()
setProperty('cameraSpeed',50)
end

local didit = false;
local dadit = false;
local bfit = false;

function onUpdate()
if getProperty('dad.curCharacter') == 'gumball' then
setProperty('dad.x',250)
setProperty('dad.y',450)
else
setProperty('dad.x',300)
setProperty('dad.y',550)
end
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

function onCountdownTick(tick)
if tick == 0 then
setProperty('cameraSpeed',1)
end
end

function onSongStart()
setProperty('camZooming',true)
end

function onStepHit()
if curStep == 392 then
    runHaxeCode([[
                if (!ClientPrefs.lowQuality) game.addBehindGF(daGloop5);
                if (!ClientPrefs.lowQuality) game.addBehindGF(daGloop4);
                if (!ClientPrefs.lowQuality) game.addBehindGF(penny);
                if (!ClientPrefs.lowQuality) daGloop.alpha = 1;
                if (!ClientPrefs.lowQuality) daGloop2.alpha = 1;
]])
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