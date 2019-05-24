--[[
Author: davekeehl
Description: This script allows to go to the next top-level track
Version: 1.0
--]]

function main()

    reaper.Undo_BeginBlock()

    currentProject = 0

    -- Get last touched track
    track = reaper.GetLastTouchedTrack()
    -- Get parent track
    parent = reaper.GetParentTrack(track)

    -- Check if track has parent
    if parent == nil
        -- No parent --> Top level track
        then
            -- Go to next track
            reaper.Main_OnCommandEx(40285, 0, currentProject)
            track = reaper.GetLastTouchedTrack()
            -- Get parent track
            parent = reaper.GetParentTrack(track)
            -- Check if this track is a child
            -- If it is, iterate through all the children
            while (parent ~= nil)
                do
                    -- Go to next track
                    reaper.Main_OnCommandEx(40285, 0, currentProject)
                    track = reaper.GetLastTouchedTrack()
                    parent = reaper.GetParentTrack(track)
                end
    end

    reaper.Undo_EndBlock("Go to the next top-level track", -1)

end

main()