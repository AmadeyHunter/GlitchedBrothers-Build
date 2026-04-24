function onCreate()
makeLuaSprite('bg', 'stages/lab/bg', 400, 350);
setProperty('bg.antialiasing',true)
setGraphicSize('bg',getProperty('bg.width') * 1.7)
updateHitbox('bg');
setProperty('bg.active',false)
addLuaSprite('bg', false)

makeLuaSprite('bulb', 'stages/lab/bulb', 1120, -475);
setGraphicSize('bulb',getProperty('bulb.width') * 2)
updateHitbox('bulb');
setProperty('bulb.antialiasing',true)
setProperty('bulb.active',false)
setProperty('bulb.origin.x',getProperty('bulb.origin.x'))
setProperty('bulb.origin.y',getProperty('bulb.origin.y')-getProperty('bulb.height')/2)

makeLuaSprite('dark', 'stages/lab/dark', 550, 35);
setGraphicSize('dark',getProperty('dark.width') * 1.7)
updateHitbox('dark');
setProperty('dark.antialiasing',true)
setProperty('dark.active',false)
setProperty('dark.origin.x',getProperty('dark.origin.x'))
setProperty('dark.origin.y',-250)

setProperty('dark.x',getProperty('dark.x')-100)
setProperty('bulb.x',getProperty('bulb.x')-100)

makeLuaSprite('light', 'stages/lab/light', getProperty('dark.x'), getProperty('dark.y'));
setGraphicSize('light',getProperty('light.width') * 1.7)
setProperty('light.alpha',0.8)
updateHitbox('light');
setProperty('light.antialiasing',true)
setProperty('light.active',false)
setProperty('light.origin.x',getProperty('light.origin.x'))
setProperty('light.origin.y',-250)

doTweenAlpha('lightalpha', 'light', 0, 0.25, 'bounceInOut')

addLuaSprite('light', true)
addLuaSprite('dark', true)
addLuaSprite('bulb', true)
end

local didit = false;
local dadit = false;
local bfit = false;

function onUpdate(elapsed)
if mustHitSection == false then
dadit = true;
if dadit and bfit then
didit = false;
bfit = false;
end
if didit == false then
if not getProperty('dad.curCharacter') == 'jake' then
setProperty('defaultCamZoom',0.9)
else
setProperty('defaultCamZoom',1)
end
didit = true;
end
else
bfit = true;
if bfit and dadit then
didit = false;
dadit = false;
end
if didit == false then
setProperty('defaultCamZoom',1.1)
didit = true;
end
end
if not getPropertyFromClass('ClientPrefs','lowQuality') or not getPropertyFromClass('ClientPrefs','flashing') then
a = math.sin((getSongPosition() / 1000) * (curBpm / 60) * 1.0);
setProperty('bg.alpha',getProperty('bg.alpha') - math.sin((getSongPosition() / 1000) * (curBpm / 60) * 1.0) / 1200)
setProperty('light.angle',a * 5)
setProperty('dark.angle',getProperty('light.angle'))
setProperty('bulb.angle',getProperty('light.angle'))
setProperty('dark.x',450 - (a * 45))
setProperty('light.x',450 - (a * 45))
end
end

function onSongStart()
if songName == 'Mindless' then
setProperty('bg.visible',false)
if not getPropertyFromClass('ClientPrefs','lowQuality') or not getPropertyFromClass('ClientPrefs','flashing') then
setProperty('dark.visible',false)
setProperty('light.visible',false)
setProperty('bulb.visible',false)
end
end
end

function onStepHit()
if curStep == 296 then
if songName == 'Mindless' then
setProperty('bg.visible',true)
if not getPropertyFromClass('ClientPrefs','lowQuality') or not getPropertyFromClass('ClientPrefs','flashing') then
setProperty('dark.visible',true)
setProperty('light.visible',true)
setProperty('bulb.visible',true)
end
end
end
if curStep == 2080 then
if songName == 'Suffering Siblings' then
setProperty('bg.visible',false)
if not getPropertyFromClass('ClientPrefs','lowQuality') or not getPropertyFromClass('ClientPrefs','flashing') then
setProperty('dark.visible',false)
setProperty('light.visible',false)
setProperty('bulb.visible',false)
end
end
end
if curStep == 2336 then
if songName == 'Suffering Siblings' then
setProperty('bg.visible',true)
if not getPropertyFromClass('ClientPrefs','lowQuality') or not getPropertyFromClass('ClientPrefs','flashing') then
setProperty('dark.visible',true)
setProperty('light.visible',true)
setProperty('bulb.visible',true)
end
end
end
end

function onTweenCompleted(tag)
	if tag == 'lightalpha' then
doTweenAlpha('lightalpha2', 'light', 0.8, 0.25, 'bounceInOut')
	end
	if tag == 'lightalpha2' then
doTweenAlpha('lightalpha', 'light', 0, 0.25, 'bounceInOut')
	end
end

function onEvent(n,v1,v2)
if n == "Apple Filter" then
if v1 == 'on' then
setProperty('bg.visible',false)
if not getPropertyFromClass('ClientPrefs','lowQuality') or not getPropertyFromClass('ClientPrefs','flashing') then
setProperty('dark.visible',false)
setProperty('light.visible',false)
setProperty('bulb.visible',false)
end
else
setProperty('bg.visible',true)
if not getPropertyFromClass('ClientPrefs','lowQuality') or not getPropertyFromClass('ClientPrefs','flashing') then
setProperty('dark.visible',true)
setProperty('light.visible',true)
setProperty('bulb.visible',true)
end
end
end
end