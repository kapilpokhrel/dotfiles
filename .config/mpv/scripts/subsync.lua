local mp = require 'mp'
local msg = require 'mp.msg'
local utils = require 'mp.utils'

local function get_paths()
    local video_path = mp.get_property("path")
    local sub_path   = mp.get_property("current-tracks/sub/external-filename")
    return video_path, sub_path
end

local function run_alass()
    local video, sub = get_paths()
    if not video then
        mp.osd_message("No video loaded!", 2)
        return
    end
    if not sub then
        mp.osd_message("No external subtitle file!", 2)
        return
    end

    mp.set_property("pause", "yes")
    mp.osd_message("Syncing Subtitle...", 9999)
    msg.info("Running alass...")

    local args = { "alass", video, sub, sub }

    local res = utils.subprocess({
        args = args,
        cancellable = false
    })

    if res.error then
        mp.osd_message("Command failed: " .. res.error, 3)
        msg.error("Command failed: " .. res.error)
    else
        mp.commandv("sub-reload")
        mp.osd_message("Subtitles reloaded!", 2)
        msg.info("Subtitles reloaded successfully")
    end

    mp.set_property("pause", "no")
end

mp.add_key_binding("n", "run-external", run_alass)

