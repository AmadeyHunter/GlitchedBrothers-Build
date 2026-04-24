hehTag = {'tnhTxt', 'sickTxt', 'goodTxt', 'badTxt', 'shitTxt', 'missTxt'}
hehPre = {'', 'Total Notes Hit', 'Sicks', 'Goods', 'Bads', 'Shits', 'Misses'}

function onCreate()
	for n = 0, 7 do -- about 7 years
		makeLuaText(hehTag[n+1], hehPre[n+1]..(hehPre[n+1] == '' and 'ERROR%' or ': ERROR'), 35, 2, 290+20*n)
	end
end