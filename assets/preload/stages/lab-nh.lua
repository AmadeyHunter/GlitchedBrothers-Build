function onCreate()
makeLuaSprite('place', 'stages/lab-nh/bgnoherofull', -600, -300);
updateHitbox('place');
setProperty('place.antialiasing',true)
addLuaSprite('place', false)

makeLuaSprite('placeog', 'stages/lab-nh/place', -600, -300);
updateHitbox('placeog');
setProperty('placeog.antialiasing',true)
setProperty('placeog.visible',false)
addLuaSprite('placeog', false)
end

function onStepHit()
if curStep == 464 then
setProperty('place.visible',false)
setProperty('placeog.visible',true)
end
if curStep == 592 then
setProperty('placeog.visible',false)
setProperty('place.visible',true)
end
end