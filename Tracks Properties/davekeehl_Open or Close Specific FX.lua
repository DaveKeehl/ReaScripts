--[[
	-- @author davekeehl
	-- @description Open/Close Specific FX
	-- @about This script allows to open and close a specific FX in the same fashion as with ReaEQ
	-- @version 1.0
--]]

function main()

	reaper.ClearConsole()

	currentProject = 0

	-- Get last touched track
	track = reaper.GetLastTouchedTrack()

	-- Get total number of tracks
	tracks = reaper.CountTracks(currentProject)

	fxname = "Saturation"

	test = reaper.TrackFX_AddByName(track, fxname, false, 1)

	reaper.ShowConsoleMsg(test)


end

main()