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
local floor = math.floor
local random = math.random

--screen vars
local LCD_SCREEN_WIDTH = 384
local LCD_SCREEN_HEIGHT = 216

--game variables
local key = {F1=79, F2=69, F3=59, F4=49, F5=39, F6=29, Alpha=77, Exit=47, 
Optn=68, Up=28, Down=37, Left=38, Right=27}
local menu = {"begin", "entry1", "entry2", "entry3", "end"}

local function waitForKey(key)
	while keyDirect(key) == 0 do
		keyDirectPoll()
	end
end

local function menu1(list, functions)
	for i=1, #menu, 1 do
		drawText
	end
end
