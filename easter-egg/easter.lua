--libs
run([[lib\ffgfx.lua]])
run([[lib\b2b.lua]])

--[[ SETUP ]]--
--function variables
local drawRectFill = zmg.drawRectFill
local fastCopy = zmg.fastCopy
local makeColor = zmg.makeColor
local drawPoint = zmg.drawPoint
local drawLine = zmg.drawLine
local clear = zmg.clear
local drawText = zmg.drawText
local keyMenuFast = zmg.keyMenuFast
local keyMenu = zmg.keyMenu
local drawSpritePalette = ffgfx.drawSpritePalette

--debug
local locate = b2b.locate

--screen variables
local SCREEN_WIDTH = 384
local SCREEN_HEIGHT = 216

--main variables
local key = {F1=79, F2=69, F3=59, F4=49, F5=39, F6=29, Alpha=77, Exit=47, Optn=68, Up=28, Down=37, Left=38, Right=27, EXE=31}

--sprites
local color = {lgreen=makeColor(15,255,15),green=makeColor("green"),brown=makeColor(150,50,50),slate=makeColor(115,115,115),lmgreen=makeColor("limegreen"),lblue=makeColor("lightcyan"),lpink=makeColor("lightpink")}
local sprite = {}
local palette = {}
sprite.grass = "00000000100100100010010111111111"
palette.grass = {color.lgreen,color.green,color.brown,color.slate}
sprite.egg = "0001100000111100011111100222222002222220022222200111111000111100"
palette.egg = {0,color.lmgreen,color.lpink}

--game variables
local player = {x=SCREEN_WIDTH/2, y=0}

--functions
local function drawPlayer(x,y)
	drawSpritePalette(sprite.egg, (x-1)*4, SCREEN_HEIGHT-(y*4), 8, 8, palette.egg, 4)
end





--[[ MAIN GAME CHUNK ]]--

while keyMenuFast()~=key.Exit do

	--keys
	if keyMenuFast()==key.Up then
		player.y=player.y+1
		elseif keyMenuFast()==key.Down then
			player.y=player.y-1
	end

	--draw sky
	drawRectFill(0,0,SCREEN_WIDTH,SCREEN_HEIGHT,color.lblue)

	--draw ground
	for i=1,48 do 
		drawSpritePalette(sprite.grass, (i-1)*8*4, SCREEN_HEIGHT-(4*4), 8, 4, palette.grass, 4)
	end

	--draw player
	drawPlayer(player.x, player.y)

	--debug
	locate(1,1,"player.y=" .. player.y)

	fastCopy()
end