--[[
Author: davekeehl
Description: This script returns data for all tracks. Useful for debugging other scripts.
Parameters implemented: 
  1) PROJECT NAME
  2) TRACK NUMBER
  3) TRACK NAME
  4) PARENT TRACK NAME
  5) TRACK DEPTH
  6) IS SOLOED
  7) IS MUTED
  8) PHASE
  9) IS SELECTED
--]]

function main()

  printTrackInfo()

end

function printTrackInfo()

  reaper.ClearConsole()
  
  currentProject = 0

  amount = reaper.CountTracks(currentProject)

  if amount == 0 then

      -- NO TRACKS IN THE PROJECT
      reaper.ShowConsoleMsg("There are no tracks in this project.")

    else

      -- 1) PRINT THE PROJECT NAME
      projectName = reaper.GetProjectName(currentProject, "test")
      reaper.ShowConsoleMsg("-----------------------------------------" .. "\n")
      reaper.ShowConsoleMsg("PROJECT NAME: ")
      if projectName == ""
        then
          reaper.ShowConsoleMsg("[unsaved project]\n")
        else
          reaper.ShowConsoleMsg(projectName .. "\n")
      end
      
      -- 2) PRINT ACTUAL DATA
      for i = 0, amount-1, 1 do
        reaper.ShowConsoleMsg("-----------------------------------------" .. "\n")
        
        -- TRACK NUMEBR
        reaper.ShowConsoleMsg("TRACK " .. i+1 .. "\n")

        -- GET CURRENT TRACK
        track = reaper.GetTrack(currentProject, i)
        
        -- TRACK NAME
        _, name = reaper.GetTrackName(track)
        reaper.ShowConsoleMsg("Name: " .. name .. "\n")
        
        -- PARENT TRACK
        parent = reaper.GetParentTrack(track)
        if parent == nil
          then
            reaper.ShowConsoleMsg("Parent: NONE\n")
          else
            _, parent_name = reaper.GetTrackName(parent)
            reaper.ShowConsoleMsg("Parent: " .. parent_name .. "\n")
        end

        -- TRACK DEPTH
        depth = reaper.GetMediaTrackInfo_Value(track, "I_FOLDERDEPTH")
        reaper.ShowConsoleMsg("Track depth: " .. tostring(depth) .. "\n")
        
        -- IS SELECTED
        isSelected = reaper.GetMediaTrackInfo_Value(track, "I_SELECTED")
        if isSelected == 0
          then
          reaper.ShowConsoleMsg("Selected: No\n")
          else
          reaper.ShowConsoleMsg("Selected: Yes\n")
        end

        -- SOLO
        solo_mode = reaper.GetMediaTrackInfo_Value(track, "I_SOLO")
        if solo_mode == 0
          then
            reaper.ShowConsoleMsg("Solo: OFF\n")
          else
            reaper.ShowConsoleMsg("Solo: ON\n")
        end
        
        -- MUTE
        isMute = reaper.GetMediaTrackInfo_Value(track, "B_MUTE")
        if isMute == 0
          then
            reaper.ShowConsoleMsg("Mute: OFF\n")
          else
            reaper.ShowConsoleMsg("Mute: ON\n")
        end

        -- PHASE
        hasPhaseInverted = reaper.GetMediaTrackInfo_Value(track, "B_PHASE")
        if hasPhaseInverted == 0
          then
          reaper.ShowConsoleMsg("Phase: Normal\n")
          else
          reaper.ShowConsoleMsg("Phase: Inverted\n")
        end

        -- LAST TRACK
        if i == amount-1 then
          reaper.ShowConsoleMsg("-----------------------------------------" .. "\n")
        end
        
      end    
  end

end

main()
