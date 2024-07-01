local speakers = table.pack(peripheral.find("speaker"))

while true do
	for i = 1, speakers.n do
	  speakers[i].playSound(speakers[i].playAudio(frog))
end