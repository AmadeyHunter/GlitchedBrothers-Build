local charColors = {'969494', 'BFE5BA'}
local houseColors = {'8f8f8f', '9ADA91'}
local rockColors = {'bababa', 'B8D4B5'}
local coolThingColors = {'c4c0c0', 'C1CEAA'}

function onCreate()
runHaxeCode([[
    void = new FlxSprite(-80, -200);
    void.frames = Paths.getSparrowAtlas('stages/void/void');
    void.animation.addByPrefix('idle', 'idle', 24, true);
    void.animation.play('idle');
    void.setGraphicSize(Std.int(void.width * 1.7));
    void.antialiasing = true;
    void.scrollFactor.set(0.4, 0.4);
    void.updateHitbox();
    game.addBehindGF(void);

    glitch = new FlxSprite();
    glitch.alpha = 0.0001;
    glitch.x = 1000;
    glitch.y = 800;
    glitch.scale.set(5, 5);
    glitch.frames = Paths.getSparrowAtlas('stages/void/gumballglitchbg');
    glitch.animation.addByPrefix('spin', 'spin', 15, false);
    game.addBehindGF(glitch);

game.variables.set('void',void);
game.variables.set('glitch',glitch);
]])

makeLuaSprite('house', 'stages/void/Ilustracion_sin_titulo-2', 0, -0);
setGraphicSize('house',getProperty('house.width') * 2.5)
setProperty('house.antialiasing',true)
setScrollFactor('house', 0.75, 1.06);
updateHitbox('house');
setProperty('house.color',getColorFromHex(houseColors[1]))

makeLuaSprite('rock', 'stages/void/Ilustracion_sin_titulo-3', 0, -200);
setGraphicSize('rock',getProperty('rock.width') * 2.5)
setProperty('rock.antialiasing',true)
setScrollFactor('rock', 1, 1);
updateHitbox('rock');
setProperty('rock.color',getColorFromHex(rockColors[1]))

doTweenAngle('houseangle', 'house', 4, 6, 'sineInOut')

if not getPropertyFromClass('ClientPrefs','lowQuality') then
makeLuaSprite('rock2', 'stages/void/Ilustracion_sin_titulo-4', 0, -200);
setGraphicSize('rock2',getProperty('rock2.width') * 2.5)
setProperty('rock2.antialiasing',true)
setScrollFactor('rock2', 1.3, 0.7);
updateHitbox('rock2');

makeLuaSprite('rock3', 'stages/void/Ilustracion_sin_titulo-5', 0, -200);
setGraphicSize('rock3',getProperty('rock3.width') * 2.5)
setProperty('rock3.antialiasing',true)
setScrollFactor('rock3', 0.9, 0.9);
updateHitbox('rock3');
setProperty('rock3.color',getColorFromHex(houseColors[1]))

makeLuaSprite('rock4', 'stages/void/Ilustracion_sin_titulo-6', 0, -200);
setGraphicSize('rock4',getProperty('rock4.width') * 2.5)
setProperty('rock4.antialiasing',true)
setScrollFactor('rock4', 0.65, 1.08);
updateHitbox('rock4');
setProperty('rock4.color',getColorFromHex(houseColors[1]))

makeLuaSprite('wtf', 'stages/void/Ilustracion_sin_titulo-7', 0, -200);
setGraphicSize('wtf',getProperty('wtf.width') * 2.5)
setProperty('wtf.antialiasing',true)
setScrollFactor('wtf', 1, 1);
updateHitbox('wtf');
setProperty('wtf.color',getColorFromHex(coolThingColors[1]))

doTweenAngle('rock2angle', 'rock2', -2, 2.5, 'sineInOut')
doTweenAngle('rock3angle', 'rock3', 360, 30, 'sineInOut')
doTweenAngle('wtfangle', 'wtf', 2, 5, 'sineInOut')

doTweenAngle('rock4angle', 'rock4', 360, 30, 'sineInOut')

addLuaSprite('rock4', false);
addLuaSprite('rock3', false);
addLuaSprite('rock2', false);
addLuaSprite('wtf', true);
end
addLuaSprite('house', false);
addLuaSprite('rock', false);
end

function onCreatePost()
setProperty('boyfriend.origin.x',0)
setProperty('boyfriend.origin.y',200)
setProperty('gf.origin.x',0)
setProperty('gf.origin.y',200)
end

function onSongStart()
setProperty('boyfriend.color',getColorFromHex(charColors[1]))
setProperty('dad.color',getColorFromHex(charColors[1]))
setProperty('gf.color',getColorFromHex(charColors[1]))

doTweenAngle('boyfriendangle', 'boyfriend', -2.1, 2.5, 'sineInOut')
doTweenAngle('dadangle', 'dad', -2.1, 2.5, 'sineInOut')
doTweenAngle('gfangle', 'gf', -2.1, 2.5, 'sineInOut')
doTweenAngle('rockangle', 'rock', -0.8, 2.5, 'sineInOut')

setProperty('camHUD.angle',-20)
setProperty('camHUD.y',getProperty('camHUD.y')-300)
end

local velocityShitHehe = 1;

function onStepHit()
runHaxeCode([[
    if (glitch != null) {
        glitch.animation.play('spin');
    }
]])

if curStep == 247 then
runHaxeCode([[
FlxTween.tween(game.camHUD, {angle: 0, y: game.camHUD.y + 300}, 2, {ease: FlxEase.expoOut});
]])
end

if curStep == 512 then
runHaxeCode([[
glitch.alpha = 1;
]])
velocityShitHehe = 2;
setProperty('boyfriend.color',getColorFromHex(charColors[2]))
setProperty('dad.color',getColorFromHex(charColors[2]))
setProperty('gf.color',getColorFromHex(charColors[2]))
setProperty('house.color',getColorFromHex(houseColors[2]))
setProperty('rock.color',getColorFromHex(rockColors[2]))
if not getPropertyFromClass('ClientPrefs','lowQuality') then
setProperty('rock3.color',getColorFromHex(rockColors[2]))
setProperty('rock4.color',getColorFromHex(rockColors[2]))
setProperty('wtf.color',getColorFromHex(rockColors[2]))
end
end
if curStep == 768 then
runHaxeCode([[
        FlxTween.tween(glitch, {alpha: 0.0001}, 0.5, {
            ease: FlxEase.quadInOut
        });
FlxTween.color(game.boyfriend, 0.5, 0xFFBFE5BA, 0xff969494, {ease: FlxEase.quadInOut } );
FlxTween.color(game.dad, 0.5, 0xFFBFE5BA, 0xff969494, {ease: FlxEase.quadInOut } );
FlxTween.color(game.gf, 0.5, 0xFFBFE5BA, 0xff969494, {ease: FlxEase.quadInOut } );
FlxTween.color(game.getLuaObject('house'), 0.5, 0xFF9ADA91, 0xFF8f8f8f, {ease: FlxEase.quadInOut } );
FlxTween.color(game.getLuaObject('rock'), 0.5, 0xFFB8D4B5, 0xFFbababa, {ease: FlxEase.quadInOut } );
if (!ClientPrefs.lowQuality)
{
FlxTween.color(game.getLuaObject('rock3'), 0.5, 0xFF9ADA91, 0xFF8f8f8f, {ease: FlxEase.quadInOut } );
FlxTween.color(game.getLuaObject('rock4'), 0.5, 0xFF9ADA91, 0xFF8f8f8f, {ease: FlxEase.quadInOut } );
FlxTween.color(game.getLuaObject('wtf'), 0.5, 0xFFC1CEAA, 0xFFc4c0c0, {ease: FlxEase.quadInOut } );
}
]])
velocityShitHehe = 1;
end
if curStep == 1024 then
runHaxeCode([[
glitch.alpha = 1;
]])
velocityShitHehe = 2;
setProperty('boyfriend.color',getColorFromHex(charColors[2]))
setProperty('dad.color',getColorFromHex(charColors[2]))
setProperty('gf.color',getColorFromHex(charColors[2]))
setProperty('house.color',getColorFromHex(houseColors[2]))
setProperty('rock.color',getColorFromHex(rockColors[2]))
if not getPropertyFromClass('ClientPrefs','lowQuality') then
setProperty('rock3.color',getColorFromHex(rockColors[2]))
setProperty('rock4.color',getColorFromHex(rockColors[2]))
setProperty('wtf.color',getColorFromHex(rockColors[2]))
end
end
if curStep == 1280 then
runHaxeCode([[
glitch.alpha = 0;
]])
velocityShitHehe = 5;
setProperty('boyfriend.color',getColorFromHex(charColors[1]))
setProperty('dad.color',getColorFromHex(charColors[1]))
setProperty('gf.color',getColorFromHex(charColors[1]))
setProperty('house.color',getColorFromHex(houseColors[1]))
setProperty('rock.color',getColorFromHex(rockColors[1]))
if not getPropertyFromClass('ClientPrefs','lowQuality') then
setProperty('rock3.color',getColorFromHex(rockColors[1]))
setProperty('rock4.color',getColorFromHex(rockColors[1]))
setProperty('wtf.color',getColorFromHex(rockColors[1]))
end
end
if curStep == 1536 then
runHaxeCode([[
glitch.alpha = 1;
]])
velocityShitHehe = 10;
setProperty('boyfriend.color',getColorFromHex(charColors[2]))
setProperty('dad.color',getColorFromHex(charColors[2]))
setProperty('gf.color',getColorFromHex(charColors[2]))
setProperty('house.color',getColorFromHex(houseColors[2]))
setProperty('rock.color',getColorFromHex(rockColors[2]))
if not getPropertyFromClass('ClientPrefs','lowQuality') then
setProperty('rock3.color',getColorFromHex(rockColors[2]))
setProperty('rock4.color',getColorFromHex(rockColors[2]))
setProperty('wtf.color',getColorFromHex(rockColors[2]))
end
end
if curStep == 1792 then
runHaxeCode([[
        FlxTween.tween(glitch, {alpha: 0.0001}, 1, {
            ease: FlxEase.quadInOut
        });
FlxTween.color(game.boyfriend, 1, 0xFFBFE5BA, 0xff969494, {ease: FlxEase.quadInOut } );
FlxTween.color(game.dad, 1, 0xFFBFE5BA, 0xff969494, {ease: FlxEase.quadInOut } );
FlxTween.color(game.gf, 1, 0xFFBFE5BA, 0xff969494, {ease: FlxEase.quadInOut } );
FlxTween.color(game.getLuaObject('house'), 1, 0xFF9ADA91, 0xFF8f8f8f, {ease: FlxEase.quadInOut } );
FlxTween.color(game.getLuaObject('rock'), 1, 0xFFB8D4B5, 0xFFbababa, {ease: FlxEase.quadInOut } );
if (!ClientPrefs.lowQuality)
{
FlxTween.color(game.getLuaObject('rock3'), 1, 0xFF9ADA91, 0xFF8f8f8f, {ease: FlxEase.quadInOut } );
FlxTween.color(game.getLuaObject('rock4'), 1, 0xFF9ADA91, 0xFF8f8f8f, {ease: FlxEase.quadInOut } );
FlxTween.color(game.getLuaObject('wtf'), 1, 0xFFC1CEAA, 0xFFc4c0c0, {ease: FlxEase.quadInOut } );
}
]])
velocityShitHehe = 1;
end
if curStep == 1824 then
runHaxeCode([[
glitch.alpha = 1;
]])
velocityShitHehe = 10;
setProperty('boyfriend.color',getColorFromHex(charColors[2]))
setProperty('dad.color',getColorFromHex(charColors[2]))
setProperty('gf.color',getColorFromHex(charColors[2]))
setProperty('house.color',getColorFromHex(houseColors[2]))
setProperty('rock.color',getColorFromHex(rockColors[2]))
if not getPropertyFromClass('ClientPrefs','lowQuality') then
setProperty('rock3.color',getColorFromHex(rockColors[2]))
setProperty('rock4.color',getColorFromHex(rockColors[2]))
setProperty('wtf.color',getColorFromHex(rockColors[2]))
end
end
end

function onTweenCompleted(tag)
	if tag == 'houseangle' then
doTweenAngle('houseangle2', 'house', -4, 6 / velocityShitHehe, 'sineInOut')
	end
	if tag == 'houseangle2' then
doTweenAngle('houseangle', 'house', 4, 6 / velocityShitHehe, 'sineInOut')
	end
	if tag == 'rock2angle' then
doTweenAngle('rock2angle2', 'rock2', 1.2, 6 / velocityShitHehe, 'sineInOut')
	end
	if tag == 'rock2angle2' then
doTweenAngle('rock2angle', 'rock2', -2, 6 / velocityShitHehe, 'sineInOut')
	end
	if tag == 'rock3angle' then
doTweenAngle('rock3angle2', 'rock3', 0, 6 / velocityShitHehe, 'sineInOut')
	end
	if tag == 'rock3angle2' then
doTweenAngle('rock3angle', 'rock3', 360, 6 / velocityShitHehe, 'sineInOut')
	end
	if tag == 'wtfangle' then
doTweenAngle('wtfangle2', 'wtf', -2, 5 / velocityShitHehe, 'sineInOut')
	end
	if tag == 'wtfangle2' then
doTweenAngle('wtfangle', 'wtf', 2, 5 / velocityShitHehe, 'sineInOut')
	end
	if tag == 'boyfriendangle' then
doTweenAngle('boyfriendangle2', 'boyfriend', 2.1, 2.5 / velocityShitHehe, 'sineInOut')
	end
	if tag == 'boyfriendangle2' then
doTweenAngle('boyfriendangle', 'boyfriend', -2.1, 2.5 / velocityShitHehe, 'sineInOut')
	end
	if tag == 'dadangle' then
doTweenAngle('dadangle2', 'dad', 2.1, 2.5 / velocityShitHehe, 'sineInOut')
	end
	if tag == 'dadangle2' then
doTweenAngle('dadangle', 'dad', -2.1, 2.5 / velocityShitHehe, 'sineInOut')
	end
	if tag == 'gfangle' then
doTweenAngle('gfangle2', 'gf', 2.1, 2.5 / velocityShitHehe, 'sineInOut')
	end
	if tag == 'gfangle2' then
doTweenAngle('gfangle', 'gf', -2.1, 2.5 / velocityShitHehe, 'sineInOut')
	end
	if tag == 'rockangle' then
doTweenAngle('rockangle2', 'rock', 0.8, 2.5 / velocityShitHehe, 'sineInOut')
	end
	if tag == 'rockangle2' then
doTweenAngle('rockangle', 'rock', -0.8, 2.5 / velocityShitHehe, 'sineInOut')
	end
end