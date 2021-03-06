--[[
  -- @author davekeehl
  -- @description Print Tracks Data
  -- @about 
  --  # Print Tracks Data
  --  This script returns data for all tracks. Useful for debugging other scripts. This script needs tracks in order to work.
  --  ## Script Modes
  --  This script has 2 modes:
  --  1. MODE 1: All tracks
  --  2. MODE 2: Only selected tracks  
  --  \
  --  If you don't select any tracks, MODE 1 will be engaged automatically. On the other hand, as soon as any number of tracks are selected, MODE 2 will kick in.
  -- @version 1.0
--]]

function main()

  reaper.ClearConsole()
  printTrackInfo()

end

function printTrackInfo()

  currentProject = 0
  tracks = reaper.CountTracks(currentProject)
  selected_tracks = reaper.CountSelectedTracks(currentProject)
  description = "SCRIPT MODE: ALL TRACKS" .. "\n"
  mode = "all"

  if tracks == 0

    then
      -- NO TRACKS IN THE PROJECT
      reaper.ShowConsoleMsg("WARNING: You need tracks in your project in order to run this script.")

    else

      -- PRINT THE PROJECT NAME
      projectName = reaper.GetProjectName(currentProject, "")
      reaper.ShowConsoleMsg("---------------------------------------------------" .. "\n")
      reaper.ShowConsoleMsg("PROJECT NAME: ")
      if projectName == ""
        then
          reaper.ShowConsoleMsg("[unsaved project]\n")
        else
          reaper.ShowConsoleMsg(projectName .. "\n")
      end
      reaper.ShowConsoleMsg("---------------------------------------------------" .. "\n")

      -- CHOOSE SCRIPT MODE
      if selected_tracks > 0 then
        description = "SCRIPT MODE: ONLY SELECTED TRACKS" .. "\n"
        tracks = selected_tracks
        mode = "selected"
      end
      setScriptMode(description, tracks, mode)

  end

end

function setScriptMode(description, tracks, mode)
  
  reaper.ShowConsoleMsg(description)

  for i = 0, tracks-1, 1 do

    reaper.ShowConsoleMsg("---------------------------------------------------" .. "\n")

    -- GET TRACK (DEPENDS ON THE SCRIPT MODE)
    if mode == "all"
      then
        track = reaper.GetTrack(currentProject, i)
      else
        track = reaper.GetSelectedTrack(currentProject, i)
      end
    getTracksInfo(track)

    -- LAST TRACK
    if i == tracks-1 then
      reaper.ShowConsoleMsg("---------------------------------------------------" .. "\n")
    end

  end

end

function getTracksInfo(track)
    
    -- TRACK NUMBER
    track_number = reaper.GetMediaTrackInfo_Value(track, "IP_TRACKNUMBER")
    reaper.ShowConsoleMsg("*** TRACK " .. math.floor(track_number) .. " ***\n")

    -- TRACK NAME
    _, name = reaper.GetTrackName(track)
    reaper.ShowConsoleMsg("- Name: " .. name .. "\n")

    -- PARENT TRACK
    parent = reaper.GetParentTrack(track)
    if parent == nil
      then
        reaper.ShowConsoleMsg("- Parent: None\n")
      else
        _, parent_name = reaper.GetTrackName(parent)
        reaper.ShowConsoleMsg("- Parent: " .. parent_name .. "\n")
    end

    -- TRACK DEPTH
    depth = reaper.GetMediaTrackInfo_Value(track, "I_FOLDERDEPTH")
    reaper.ShowConsoleMsg("- Depth: " .. tostring(math.floor(depth)) .. "\n")
    
    -- IS SELECTED
    isSelected = reaper.GetMediaTrackInfo_Value(track, "I_SELECTED")
    if isSelected == 0
      then
      reaper.ShowConsoleMsg("- Selected: No\n")
      else
      reaper.ShowConsoleMsg("- Selected: Yes\n")
    end

    -- SOLO
    solo_mode = reaper.GetMediaTrackInfo_Value(track, "I_SOLO")
    if solo_mode == 0
      then
        reaper.ShowConsoleMsg("- Solo: OFF\n")
      else
        reaper.ShowConsoleMsg("- Solo: ON\n")
    end
    
    -- MUTE
    isMute = reaper.GetMediaTrackInfo_Value(track, "B_MUTE")
    if isMute == 0
      then
        reaper.ShowConsoleMsg("- Mute: OFF\n")
      else
        reaper.ShowConsoleMsg("- Mute: ON\n")
    end

    -- PHASE
    hasPhaseInverted = reaper.GetMediaTrackInfo_Value(track, "B_PHASE")
    if hasPhaseInverted == 0
      then
      reaper.ShowConsoleMsg("- Phase: Normal\n")
      else
      reaper.ShowConsoleMsg("- Phase: Inverted\n")
    end

end

main()
