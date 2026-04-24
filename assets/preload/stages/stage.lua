function onCreate()
makeLuaSprite('bg', 'stages/stage/stageback', -600, -200);
setProperty('bg.antialiasing',true)
setScrollFactor('bg', 0.9, 0.9);
setProperty('bg.active',false)
addLuaSprite('bg', false);

makeLuaSprite('stageFront', 'stages/stage/stagefront', -650, 600);
setGraphicSize('stageFront',getProperty('stageFront.width') * 1.1)
updateHitbox('stageFront');
setProperty('stageFront.antialiasing',true)
setScrollFactor('stageFront', 0.9, 0.9);
setProperty('stageFront.active',false)
addLuaSprite('stageFront', false);

makeLuaSprite('stageCurtains', 'stages/stage/stagecurtains', -500, -300);
setGraphicSize('stageCurtains',getProperty('stageCurtains.width') * 0.9)
updateHitbox('stageCurtains');
setProperty('stageCurtains.antialiasing',true)
setScrollFactor('stageCurtains', 1.3, 1.3);
setProperty('stageCurtains.active',false)
addLuaSprite('stageCurtains', false);
end