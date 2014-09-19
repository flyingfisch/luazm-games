--function variables
local clear         = zmg.clear
local drawLine      = zmg.drawLine
local drawPoint     = zmg.drawPoint
local drawRect      = zmg.drawRect
local drawRectFill  = zmg.drawRectFill
local drawText      = zmg.drawText
local fastCopy      = zmg.fastCopy
local keyDirectPoll = zmg.keyDirectPoll
local keyDirect     = zmg.keyDirect
local keyMenuFast   = zmg.keyMenuFast
local keyMenu       = zmg.keyMenu
local makeColor     = zmg.makeColor
local floor         = math.floor
local random        = math.random

--screen vars
local SCREEN_WIDTH  = 384
local SCREEN_HEIGHT = 216

--game variables
local key = {f1=79,f2=69,f3=59,f4=49,f5=39,f6=29,shift=78,optn=68,vars=58,menu=48,alpha=77,x2=67,pwr=57,exit=47, up=28,down=37,left=38,right=27,xot=76,log=66,ln=56,sin=46,cos=36,tan=26,abc=75,f2d=65,n1=72,n2=62,n3=52,n4=73,n5=63,n6=53,n7=74,n8=64,n9=54,exe=31}
local color = {fg=makeColor("white"), bg=makeColor("black")}
local speed = 2
local ball = {{10,10,1,1} --[[ {x,y,dirx,diry} ]]}
local div = {pos=0, size=40}


local function drawBG()
	drawRectFill(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, color.bg)
end

local function drawDiv(pos, size)
	drawRectFill((SCREEN_WIDTH/2) - 2, 0, 4, (SCREEN_HEIGHT/2) - (size/2) + pos, color.fg)
	drawRectFill((SCREEN_WIDTH/2) - 2, (SCREEN_HEIGHT/2) + (size/2) + pos, 4, SCREEN_HEIGHT - ((SCREEN_HEIGHT/2) + (size/2) + pos), color.fg)
end

local function drawCircles(data)
	for i=1, #data do
		--blah
	end
end

local function onKey()
	keyDirectPoll()

	if keyDirect(key.exit) > 0 then
		exit = 1
	end

	if keyDirect(key.up) > 0 then
		div.pos = div.pos - speed
	end

	if keyDirect(key.down) > 0 then
		div.pos = div.pos + speed
	end
end

local function drawCircleFill(centerx, centery, radius, color)
	f = 1 - radius
	ddF_x = 1
	ddF_y = -2 * radius
	x = 0
	y = radius

	drawLine(centerx, centery + radius, centerx, centery - radius, color)
	drawLine(centerx + radius, centery, centerx - radius, centery, color)

	while x < y do
		if f >= 0 then
			y = y - 1
			ddF_y = ddF_y + 2
			f = f + ddF_y
		end

		x = x + 1
		ddF_x = ddF_x + 2
		
		drawLine(centerx + x, centery + y, centerx - x, centery + y, color)
		drawLine(centerx + x, centery - y, centerx - x, centery - y, color)
		drawLine(centerx + y, centery + x, centerx - y, centery + x, color)
		drawLine(centerx + y, centery - x, centerx - y, centery - x, color)
	end
end

--[[ MAIN LOOP ]]
keyDirectPoll()
while not exit do
	onKey()
	drawBG()
	drawDiv(div.pos, div.size)
	drawCircleFill(50,50,10,color.fg)
	fastCopy()
end