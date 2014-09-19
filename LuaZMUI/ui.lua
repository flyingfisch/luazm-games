--function variables
local drawRectFill = zmg.drawRectFill
local drawRect = zmg.drawRect
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
local key = {f1=79,f2=69,f3=59,f4=49,f5=39,f6=29,shift=78,optn=68,vars=58,menu=48,alpha=77,x2=67,pwr=57,exit=47, up=28,down=37,left=38,right=27,xot=76,log=66,ln=56,sin=46,cos=36,tan=26,abc=75,f2d=65,n1=72,n2=62,n3=52,n4=73,n5=63,n6=53,n7=74,n8=64,n9=54,exe=31}

-- functions

local function drawButton(x,y,width,height,string,theme,selected)
	-- draw button
	drawRectFill(x,y,width,height,theme.bg[selected])
	-- draw border
	drawRect(x,y,width,height,theme.fg[selected])
	-- draw text
	drawText(x+((width/2)-10),y+((height/2)-10),string,theme.fg)
end


