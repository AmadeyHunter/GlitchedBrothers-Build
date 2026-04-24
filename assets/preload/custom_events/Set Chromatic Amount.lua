function onEvent(n,v1,v2)
	if n == "Set Chromatic Amount" then
setShaderFloat('chromFNFobject',"aberration", v1);
	end
end