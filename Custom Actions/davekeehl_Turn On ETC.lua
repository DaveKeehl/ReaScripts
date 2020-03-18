--[[
	-- @author davekeehl
	-- @description Turn on external timecode synchronization
	-- @about This script allows to always turn on the external timecode synchronization
	-- @version 1.0
--]]

function main()
	
	currentProject = 0

	if reaper.GetToggleCommandState(40620) ~= 1 then
		reaper.Main_OnCommandEx(40620, 0, currentProject)
	end
	
end

main()