--[[--
by flyingfisch, 2012
Licensed with CC Share and share alike license.
http://creativecommons.org/licenses/by-sa/3.0/

Have Fun!

Isten, aldd meg a Magyart!
--]]--


--function variables
local drawRectFill = zmg.drawRectFill
local fastCopy = zmg.fastCopy
local makeColor = zmg.makeColor
local drawPoint = zmg.drawPoint
local keyMenuFast = zmg.keyMenuFast
local clear = zmg.clear
local drawText = zmg.drawText
local keyDirectPoll = zmg.keyDirectPoll
local keyDirect = zmg.keyDirect

--key variables
local key = {F1=79, F2=69, F5=39, F6=29, Alpha=77, Exit=47, Optn=68}
local point = {x=1, y=1, color=makeColor(25,25,25)}

--other variables
local LCD_SCREEN_WIDTH = 384
local LCD_SCREEN_HEIGHT = 216
local erase = 1
local testVar1 = 255
local bgColor = makeColor(150, 255, 150)
local fgColor = point.color
local helpMe=1

--functions
function help()
	drawText(1 ,1 ,"TakeFlight Productions Presents:", fgColor, bgColor)
	drawText(1 ,20 ,"ETCH A SKETCH", fgColor, bgColor)
	drawText(1 ,40 ,"by flyingfisch, 2012", fgColor, bgColor)
	drawText(1 ,80 ,"Controls:", fgColor, bgColor)
	drawText(1 ,100 ,"[F1]/[F2] :: Up/Down", fgColor, bgColor)
	drawText(1 ,120 ,"[F5]/[F6] :: Right/Left", fgColor, bgColor)
	drawText(1 ,140 ,"[ALPHA] :: Clear", fgColor, bgColor)
	drawText(1 ,160 ,"[OPTN] :: This help message", fgColor, bgColor)
end


--main loop

keyDirectPoll()

while keyMenuFast() ~= key.Exit do
	
	keyDirectPoll()
	if erase == 1 
		then drawRectFill(0, 0, LCD_SCREEN_WIDTH, LCD_SCREEN_HEIGHT, bgColor)
		erase = 0
	end
	
	if helpMe == 1
		then help()
		helpMe = 0
	end
	
	drawPoint(point.x, point.y, point.color)
	
	if keyDirect(key.F1) > 0 and point.y > 0 then point.y = point.y-1
		elseif keyDirect(key.F2) > 0 and point.y < LCD_SCREEN_HEIGHT then point.y = point.y+1
	end
	
	if keyDirect(key.F5) > 0 and point.x > 0 then point.x = point.x-1
		elseif keyDirect(key.F6) > 0 and point.x < LCD_SCREEN_WIDTH then point.x = point.x+1
	end
	
	if keyDirect(key.Alpha) > 0 then erase = 1
		elseif keyDirect(key.Optn) > 0 then helpMe=1
	end
	
	
	
	fastCopy()
end


