local dadCamZoom = -1;
local doThunder = false;
local dadCamZoomEnable = false;

function onCreate()
initLuaShader('pixel')
makeLuaSprite('bg', 'stages/treehouse/back', -800, -800);
setProperty('bg.scale.x',1.8)
setProperty('bg.scale.y',1.8)
setProperty('bg.antialiasing',true)
updateHitbox('bg');
setProperty('bg.alpha',0.0001)

makeLuaSprite('treehouse', 'stages/treehouse/tree', -800, -800);
setProperty('treehouse.scale.x',1.8)
setProperty('treehouse.scale.y',1.8)
setProperty('treehouse.antialiasing',true)
updateHitbox('treehouse');
setProperty('treehouse.alpha',0.0001)

if not getPropertyFromClass('ClientPrefs','lowQuality') then
runHaxeCode([[
        thunder = new FlxSprite();
        thunder.x = -550;
        thunder.y = -800;
        thunder.scale.set(1.2, 1,2);
        thunder.frames = Paths.getSparrowAtlas('stages/treehouse/Lighting');
        thunder.animation.addByPrefix('thunder', 'LIGHTNING', 24, false);
        thunder.alpha = 0.0001;
        thunder.scrollFactor.set(1,1);
game.variables.set('thunder',thunder);
]])

makeLuaSprite('backGlitch', 'stages/treehouse/reveal/glitch', 750, 1500);
updateHitbox('backGlitch');
setProperty('backGlitch.scale.x',0.7)
setProperty('backGlitch.scale.y',0.7)
setScrollFactor('backGlitch');

makeLuaSprite('hillShit', 'stages/treehouse/reveal/HillStuff', 750, 1500);
updateHitbox('hillShit');
setProperty('hillShit.scale.x',0.7)
setProperty('hillShit.scale.y',0.7)
setScrollFactor('hillShit', 0.65, 0.65);

makeLuaSprite('particles', 'stages/treehouse/reveal/Particles', 750, 1500);
updateHitbox('particles');
setProperty('particles.scale.x',0.5)
setProperty('particles.scale.y',0.5)
setProperty('particles.alpha',0)

makeLuaSprite('dangling', 'stages/treehouse/reveal/Dangling', 750, 1500);
updateHitbox('dangling');
setProperty('dangling.scale.x',0.7)
setProperty('dangling.scale.y',0.7)
setScrollFactor('dangling', 0.85, 0.85);

makeLuaSprite('corruption', 'stages/treehouse/reveal/Corruption', 750, 1500);
updateHitbox('corruption');
setProperty('corruption.scale.x',0.7)
setProperty('corruption.scale.y',0.7)
setProperty('corruption.alpha',0)

runHaxeCode([[
var pixel = game.createRuntimeShader('pixel');
pixel.setFloat("size", 10);
game.getLuaObject('pixelobject').shader = pixel;
game.getLuaObject('corruption').shader = pixel;
]])
end
makeLuaSprite('revealBackground', 'stages/treehouse/reveal/realBackground', 750, 1500);

makeLuaSprite('outside', 'stages/treehouse/intro/IMG_8337', 1150, 1450);
updateHitbox('outside');
setProperty('outside.scale.x',0.7)
setProperty('outside.scale.y',0.7)

makeLuaSprite('outside2', 'stages/treehouse/intro/IMG_8337', 1150, 1450);
updateHitbox('outside2');
setProperty('outside2.scale.x',0.65)
setProperty('outside2.scale.y',0.65)

makeLuaSprite('idkWhatAreThatThings', 'stages/treehouse/intro/Ilustracion_sin_titulo-2', 1090, 1500);
updateHitbox('idkWhatAreThatThings');
setProperty('idkWhatAreThatThings.scale.x',0.6)
setProperty('idkWhatAreThatThings.scale.y',0.6)

makeLuaSprite('coolGradient', 'stages/treehouse/intro/Ilustracion_sin_titulo-3', 1150, 1450);
updateHitbox('coolGradient');

setProperty('revealBackground.y',getProperty('revealBackground.y')+475)
setProperty('revealBackground.x',getProperty('revealBackground.x')+675)

if not getPropertyFromClass('ClientPrefs','lowQuality') then
setProperty('backGlitch.y',getProperty('backGlitch.y')-1910)
setProperty('hillShit.y',getProperty('hillShit.y')-425)
setProperty('particles.y',getProperty('particles.y')+270)
setProperty('dangling.y',getProperty('dangling.y')-110)
setProperty('corruption.y',getProperty('corruption.y')+270)

setProperty('backGlitch.x',getProperty('backGlitch.x')-1580)
setProperty('hillShit.x',getProperty('hillShit.x')-490)
setProperty('particles.x',getProperty('particles.x')+130)
setProperty('dangling.x',getProperty('dangling.x')-210)
setProperty('corruption.x',getProperty('corruption.x')+150)
end

addLuaSprite('bg', false)
    runHaxeCode([[
game.addBehindGF(thunder);
]])

addLuaSprite('treehouse', false)
    runHaxeCode([[
game.addBehindGF(thunder);
]])

if not getPropertyFromClass('ClientPrefs','lowQuality') then
addLuaSprite('backGlitch', false)
addLuaSprite('hillShit', false)
addLuaSprite('particles', true)
addLuaSprite('dangling', false)
addLuaSprite('corruption', true)
addLuaSprite('revealBackground', false)
end

addLuaSprite('outside', false)
addLuaSprite('outside2', false)
addLuaSprite('coolGradient', false)
addLuaSprite('idkWhatAreThatThings', false)
end

function onStepHit()
if curStep == 1535 then
setProperty('outside.alpha',1)
setProperty('outside2.alpha',1)
setProperty('coolGradient.alpha',1)
setProperty('idkWhatAreThatThings.alpha',1)
if not getPropertyFromClass('ClientPrefs','lowQuality') then
setProperty('thunder.alpha',0)
end
setProperty('treehouse.alpha',0)
setProperty('bg.alpha',0)
doThunder = false;
dadCamZoom = 0.9;
elseif curStep == 1648 then
setProperty('outside.alpha',0)
setProperty('outside2.alpha',0)
setProperty('coolGradient.alpha',0)
setProperty('idkWhatAreThatThings.alpha',0)

if not getPropertyFromClass('ClientPrefs','lowQuality') then
setProperty('backGlitch.alpha',1)
setProperty('hillShit.alpha',1)
setProperty('particles.alpha',1)
setProperty('dangling.alpha',1)
setProperty('corruption.alpha',1)
end

dadCamZoom = 0.85;

if not getPropertyFromClass('ClientPrefs','lowQuality') then
setProperty('revealBackground.alpha',1)
end
elseif curStep == 628 then
setProperty('outside.alpha',0)
setProperty('outside2.alpha',0)
setProperty('coolGradient.alpha',0)
setProperty('idkWhatAreThatThings.alpha',0)
if not getPropertyFromClass('ClientPrefs','lowQuality') then
doTweenAlpha('corruptionalpha', 'corruption', 1, 3, 'linear')
end

if not getPropertyFromClass('ClientPrefs','lowQuality') then
setProperty('thunder.alpha',1)
end
setProperty('treehouse.alpha',1)
setProperty('bg.alpha',0)
doThunder = true;
dadCamZoom = 0.85
dadCamZoomEnable = true;
elseif curStep == 896 then
dadCamZoom = 0.6;

if not getPropertyFromClass('ClientPrefs','lowQuality') then
setProperty('revealBackground.alpha',0)
setProperty('backGlitch.alpha',0)
setProperty('hillShit.alpha',0)
setProperty('particles.alpha',0)
setProperty('dangling.alpha',0)
setProperty('corruption.alpha',0)
end

setProperty('bg.alpha',1)
elseif curStep == 1536 then
dadCamZoom = 0.8;
elseif curStep == 1664 then
dadCamZoom = 0.6;
if not getPropertyFromClass('ClientPrefs','lowQuality') then
setProperty('revealBackground.alpha',0)
setProperty('backGlitch.alpha',0)
setProperty('hillShit.alpha',0)
setProperty('particles.alpha',0)
setProperty('dangling.alpha',0)
setProperty('corruption.alpha',0)
end

if not getPropertyFromClass('ClientPrefs','lowQuality') then
setProperty('thunder.alpha',1)
end
setProperty('treehouse.alpha',1)
setProperty('bg.alpha',1)
doThunder = true;
end
end

local didit = false;
local dadit = false;
local bfit = false;

function onUpdate()
if dadCamZoomEnable then
if mustHitSection == false then
dadit = true;
if dadit and bfit then
didit = false;
bfit = false;
end
if didit == false then
setProperty('defaultCamZoom',dadCamZoom)
didit = true;
end
else
bfit = true;
if bfit and dadit then
didit = false;
dadit = false;
end
if didit == false then
setProperty('defaultCamZoom',dadCamZoom + 0.2)
didit = true;
end
end
end
end

function onBeatHit()
if curBeat % 8 == 0 and doThunder then
if not getPropertyFromClass('ClientPrefs','lowQuality') then
setProperty('thunder.alpha',1)
playAnim('thunder','thunder')
if getProperty('thunder.animation.curAnim.curFrame') == 33 then
setProperty('thunder.alpha',0.0001)
end
end
end

setShaderFloat('pixelobject',"size", getRandomInt(5, 15));
end