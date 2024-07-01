local dfpwm    = require("cc.audio.dfpwm")
local decoder  = dfpwm.make_decoder()
local speakers = {peripheral.find("speaker")}
while true do
	for chunk in io.lines("data/example.dfpwm", 16 * 1024) do
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