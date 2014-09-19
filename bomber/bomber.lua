--first keyPoll
zmg.keyDirectPoll()
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
local makeColor = zmg.makeColor

--screen vars
local SCREEN_WIDTH = 384
local SCREEN_HEIGHT = 216

--key vars
local key = {f1=79, f2=69, f3=59, f4=49, f5=39, f6=29, alpha=77, 
exit=47, optn=68, up=28, down=37, left=38, right=27}

--game vars
local game = {exit=0}
local speed = 3
local bomb = {x=1}

-- functions
-- plane drawing function. for now, draws rectangle.
local function drawPlane(x)
	drawRectFill(x,1,100,30,makeColor("green"))
end
-- bomb drawing function
local function drawBomb(start_x_pos,x)
	x=x+start_x_pos
	drawRectFill(x,SCREEN_HEIGHT-(SCREEN_HEIGHT-(9.8*x^2/2)),8,8,makeColor("green"))
end

-- main loop
keyDirectPoll()
while exit~=1 do
	--keyPoll
	keyDirectPoll()
	
	-- refresh the screen
	fastCopy()
	
	--clear screen
	clear()
	-- check for keystrokes
	if keyDirect(key.exit)>0 then exit=1
		elseif keyDirect(key.left)>0 then bomb.x=bomb.x+1
		elseif keyDirect(key.right)>0 then bomb.x=bomb.x-1
	end
	
	drawBomb(5,bomb.x)
	drawText(1,1,bomb.x,makeColor("white"),makeColor("black"))
end


