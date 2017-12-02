local Device = require("device")
local logger = require("logger")
local WidgetContainer = require("ui/widget/container/widgetcontainer")
local _ = require("gettext")

if Device:isSDL() then
    Device.enableHwSuspend = function() 
        logger.dbg("called enableHwSuspend()")
    end
    Device.disableHwSuspend = function() 
        logger.dbg("called disableHwSuspend()")
    end
elseif not Device:isPocketBook() then
    return { disabled = true, }
end

local PocketBookInsomnia = WidgetContainer:new{
    name = 'PocketBookInsomnia',
    enabled = true,
}

function PocketBookInsomnia:init()
end

function PocketBookInsomnia:onReaderReady()
	logger.dbg("called onReaderReady()")
	require("ffi/input").setSuspendState(1,2000)
end

function PocketBookInsomnia:onShowConfigMenu()
	logger.dbg("called onShowConfigMenu()")
	require("ffi/input").setSuspendState(0,0)
end

function PocketBookInsomnia:onCloseConfigMenu()
	logger.dbg("called onCloseConfigMenu()")
	require("ffi/input").setSuspendState(1,2000)
end

function PocketBookInsomnia:onShowReaderMenu()
	logger.dbg("called onShowReaderMenu()")
	require("ffi/input").setSuspendState(0,0)
end

function PocketBookInsomnia:onCloseReaderMenu()
	logger.dbg("called onCloseReaderMenu()")
	require("ffi/input").setSuspendState(1,2000)
end

return PocketBookInsomnia
