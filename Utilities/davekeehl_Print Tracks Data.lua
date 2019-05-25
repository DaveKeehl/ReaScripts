--[[
    * Author: davekeehl
    * Description: This script allows to go to the previous top-level track
--]]

function main()

  reaper.ClearConsole()

  currentProject = 0
  -- Get last touched track
  track = reaper.GetLastTouchedTrack()
  -- Get parent track
  parent = reaper.GetParentTrack(track)
  -- Get total number of tracks
  tracks = reaper.CountTracks(currentProject)
  -- Get number of selected tracks
  selected_tracks = reaper.CountSelectedTracks(currentProject)

  if tracks == 0 then
      reaper.ShowConsoleMsg("This script needs tracks to work with. Create a few first.")
  end

  if selected_tracks == 0 then
      reaper.ShowConsoleMsg("You need to select one track.")
  elseif selected_tracks > 1 then
      reaper.ShowConsoleMsg("Please select only one track.")
  else
      -- Check if track has parent
      if parent == nil then
          -- No parent --> Top level track
          -- Go to next track
          reaper.Main_OnCommandEx(40286, 0, currentProject)
          track = reaper.GetLastTouchedTrack()
          -- Get parent track
          parent = reaper.GetParentTrack(track)
          -- Check if this track is a child
          -- If it is, iterate through all the children
          while (parent ~= nil) do
              -- Go to next track
              reaper.Main_OnCommandEx(40286, 0, currentProject)
              track = reaper.GetLastTouchedTrack()
              parent = reaper.GetParentTrack(track)
          end
      -- Has parent --> Not top level track
      else
          while (parent ~= nil) do
              -- Go to next track
              reaper.Main_OnCommandEx(40286, 0, currentProject)
              track = reaper.GetLastTouchedTrack()
              parent = reaper.GetParentTrack(track)
          end
      end
  end

end

main()