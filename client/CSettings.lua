-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: Main				##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {}		-- Local Functions 
local cSetting = {}		-- Local Settings

aesx, aesy = 1600, 900;

sx, sy = guiGetScreenSize();

-- EVENT HANDLER --

--[[
_dxDrawImage = dxDrawImage

function dxDrawImage(x, y, w, h, ...)
	x = x/aesx*sx
	y = y/aesy*sy
	w = w/aesx*sx
	h = h/aesy*sy
	return _dxDrawImage(x, y, w, h, ...)
end

_dxDrawText = dxDrawText

function dxDrawText(text, x, y, w, h, color, size, ...)
	x = x/aesx*sx
	y = y/aesy*sy
	w = w/aesx*sx
	h = h/aesy*sy
	size = size/(aesx+aesy)*(sx+sy)
	return _dxDrawText(text, x, y, w, h, color, size, ...)
end

_dxDrawRectangle = dxDrawRectangle

function dxDrawRectangle(x, y, w, h, ...)
	x = x/aesx*sx
	y = y/aesy*sy
	w = w/aesx*sx
	h = h/aesy*sy
	return _dxDrawRectangle(x, y, w, h, ...)
end]]


showCursor(true, false);

setTimer(function()
	if(isMainMenuActive ()) then
		setCursorAlpha(255)
	else
		setCursorAlpha(0)
	end
end, 1000, -1)



--[[
function getCursorMoveOn()
    if ( isCursorShowing() ) then
	left = "left"
	right = "right"
	up = "up"
	down = "down"
    zero = "nil"
	if getElementData(localPlayer,"movew") == right then
	return right
	elseif getElementData(localPlayer,"movew") == left then
	return left
	elseif getElementData(localPlayer,"movew") == up then
	return up
	elseif getElementData(localPlayer,"movew") == down then
	return down
	elseif getElementData(localPlayer,"movew") == zero then
	return false
	end
	end
end
 
function executeMoveOn(cursorX,cursorY)
    if ( isCursorShowing() ) then
	setElementData(localPlayer,"moveX",cursorX)
	setElementData(localPlayer,"moveY",cursorY)
	if(cursorX and cX) then
     if cursorX > cX then
         setElementData(localPlayer,"movew",right, false)
	     elseif cursorX < cX then
	     setElementData(localPlayer,"movew",left, false)
	     elseif cursorY > cY then
	     setElementData(localPlayer,"movew",down, false)
	     elseif cursorY < cY then
	     setElementData(localPlayer,"movew",up, false)
	     end
    end
    end
end
addEventHandler("onClientCursorMove",root,executeMoveOn)
 
setTimer(
function()
    if ( isCursorShowing() ) then
	local curX = getElementData(localPlayer,"moveX")
	local curY = getElementData(localPlayer,"moveY")
		 if cursorX == cX then
		 setElementData(localPlayer,"movew",zero, false)
		 elseif cursorY == cY then
		 setElementData(localPlayer,"movew",zero, false)
		 end
	end
end
,50,0)
 
function previousM()
   if ( isCursorShowing() ) then
    cX = getElementData(localPlayer,"moveX")
	cY = getElementData(localPlayer,"moveY")
   end
end
setTimer(previousM,50,0)]]

function formNumberToMoneyString ( value )

	if tonumber ( value ) then
		value = tostring ( value )
		if string.sub ( value, 1, 1 ) == "-" then
			return "-"..setDotsInNumber ( string.sub ( value, 2, #value ) ).." $"
		else
			return setDotsInNumber ( value ).." $"
		end
	end
	return false
end

function setDotsInNumber ( value )

	if #value > 3 then
		return setDotsInNumber ( string.sub ( value, 1, #value - 3 ) ).."."..string.sub ( value, #value - 2, #value )
	else
		return value
	end
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end


		
		
		
addEventHandler("onClientPedDamage", localPlayer, cancelEvent);