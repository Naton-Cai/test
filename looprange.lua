local dfpwm    = require("cc.audio.dfpwm")
local decoder  = dfpwm.make_decoder()
local speakers = {peripheral.find("speaker")}
local arg1 = "back"

if not fs.exists(arg1)

then
	return
	
else
while isPlayersInRange(1000) do
	for chunk in io.lines(arg1, 16 * 1024) do
			local buffer = decoder(chunk)
		local play_functions = {}
		for _, speaker in pairs(speakers) do
			table.insert(play_functions, function()
					while not speaker.playAudio(buffer) do
						os.pullEvent("speaker_audio_empty")
					end
			end)
		end
		parallel.waitForAll(table.unpack(play_functions))
	end
end
end