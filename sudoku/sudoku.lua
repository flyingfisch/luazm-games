--function variables
local drawRectFill = zmg.drawRectFill
local fastCopy = zmg.fastCopy
local makeColor = zmg.makeColor
local drawPoint = zmg.drawPoint
local drawLine = zmg.drawLine
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

--major variables
local key = {f1=79,f2=69,f3=59,f4=49,f5=39,f6=29,shift=78,optn=68,vars=58,menu=48,alpha=77,x2=67,pwr=57,exit=47, up=28,down=37,left=38,right=27,xot=76,log=66,ln=56,sin=46,cos=36,tan=26,abc=75,f2d=65,n1=72,n2=62,n3=52,n4=73,n5=63,n6=53,n7=74,n8=64,n9=54,exe=31}
local color = {fg=makeColor("blue"), bg2=makeColor("gray"), bg=makeColor("white")}
local exit = 0

--game vars
local board =  {{},{},{},{},{},{},{},{},{}}
-- make a blank board
for i=1,9,1 do
	for j=1,9,1 do
		board[i][j]=0
	end
end


-- draw board
local function drawBoard(x,y)
	--numbers
	for i=1,9,1 do
		for j=1,9,1 do
			drawText(x+(i*20)-15, y+(j*20)-17, board[i][j], color.fg, color.bg)
		end
	end
	--lines
	drawLine(x, y, x, y+180, color.bg2)
	drawLine(x, y, x+180, y, color.bg2)
	for i=1,9,1 do
		drawLine(x+(i*20), y, x+(i*20), y+180, color.bg2)
		drawLine(x, y+(i*20), x+180, y+(i*20), color.bg2)
		if i==3 or i==6 then
			drawLine((x-1)+(i*20), y, (x-1)+(i*20), y+180, color.bg2)
			drawLine((x+1)+(i*20), y, (x+1)+(i*20), y+180, color.bg2)
			drawLine(x, (y-1)+(i*20), x+180, (y-1)+(i*20), color.bg2)
			drawLine(x, (y+1)+(i*20), x+180, (y+1)+(i*20), color.bg2)
		end
	end
end

-- loop
keyDirectPoll()
while exit~=1 do
	keyDirectPoll()
	clear()
	
	drawBoard(5,5)
	
	fastCopy()
	if keyDirect(key.exit)>0 then exit = 1 end
end
