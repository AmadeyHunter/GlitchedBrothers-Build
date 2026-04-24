local shaderName = 'distort_shader'
function onCreatePost()
initLuaShader(shaderName)
makeLuaSprite('doritos')
makeGraphic('doritos', screenWidth, screenHeight)
runHaxeCode([[
var shader0 = game.createRuntimeShader(']]..shaderName..[[');
game.getLuaObject('doritos').shader = shader0;
shader0.setFloat("negativity", 0.0);
shader0.setFloat("binaryIntensity", 1000.0);
]])
end
function onUpdatePost(elapsed)
setShaderFloat('doritos',"binaryIntensity", distortIntensity);
runHaxeCode([[
for (i in 0...game.opponentStrums.length) {
game.opponentStrums.members[i].shader = game.getLuaObject('doritos').shader;
}
]])
end

function onStepHit()
distortIntensity = getRandomFloat(4)
end