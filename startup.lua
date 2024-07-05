local dfpwm    = require("cc.audio.dfpwm")
local decoder  = dfpwm.make_decoder()
local speakers = {peripheral.find("speaker")}
local arg1 = "back"
local detector = peripheral.find("playerDetector")

if detector == nil then 
    error("playerDetector not in range")
	return 
end 

if not fs.exists(arg1)
	then
		return
	
else
	while true do
		if detector.isPlayersInRange(1000) then
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
end