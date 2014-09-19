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
local key = {F1=79, F2=69, F5=39, F6=29, Up=28, Down=37, Alpha=77, Exit=47, Optn=68}
local player = {y=floor(SCREEN_HEIGHT/ 2)}
local difficulty = 40
local oldy = (SCREEN_HEIGHT/2) - 20
local tunnel = {{difficulty, oldy}} -- {{gap_height, gaptop_y}}
local color = {fg=makeColor('black'), bg=makeColor('white')}
local exit = 0
local resolution = {x=8, y}

-- functions
local function getkey()
	keyDirectPoll()

	if keyDirect(key.Exit)>0 then
		exit = 1
	end

	keyDirectPoll()
end

local function engine()
	-- create new tunnel section
	tunnel[#tunnel + 1] = {difficulty, oldy + random(-1, 1)}
	oldy = tunnel[#tunnel][2]
end

local function display()
	-- clear screen
	drawRectFill(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, color.bg)

	-- draw tunnel
	local linex
	for i = 1, #tunnel, resolution.x do
		linex = SCREEN_WIDTH - #tunnel + i
		-- draw ceiling
		drawRectFill(linex, 0, resolution.x, tunnel[i][2], color.fg)
		-- draw floor
		drawRectFill(linex, tunnel[i][2] + tunnel[i][1], resolution.x, SCREEN_HEIGHT - (tunnel[i][2] + tunnel[i][1]), color.fg)
	end

	-- draw VRAM to screen
	fastCopy()
end

-- get poll
keyDirectPoll()

-- game loop
while exit ~= 1 do
	-- getkey
	getkey()

	-- tunnel generation, etc.
	engine()

	-- display thread
	display()
end