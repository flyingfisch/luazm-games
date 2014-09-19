print("starting...")

print("defining functions")
--function variables
local drawLine = zmg.drawLine
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

print("setting vars")
--screen vars
local LCD_SCREEN_WIDTH = 384
local LCD_SCREEN_HEIGHT = 216

--game variables
local key = {F1=79, F2=69, F3=59, F4=49, F5=39, F6=29, Alpha=77, Exit=47, Optn=68, Up=28, Down=37, Left=38, Right=27}
local color = {makeColor("limegreen"),makeColor("black"), makeColor("limegreen")}
local powerUpColor = {makeColor("snow")}
local powerUpActive = {0,0,0,0,0,0}
local ball = {x=20, y=20, width=8, height=8}
local dir = {x=1, y=1}
local speed = {x=2, y=2}
local paddle = {player=40, width=8, height=30, speed=4}
local wall = {width=8}
local credits = 0
local fKeyButtonCoords = {22, 92, 158, 219, 285, 352}

--debug
local testVar = 50

print("creating custom functions")
local drawPowerUpIcons = function(fKey, active)
	if active==0 then drawRectFill(fKeyButtonCoords[fKey], LCD_SCREEN_HEIGHT - 10, 8, 8, color[3])
		elseif active==1 then drawRectFill(fKeyButtonCoords[fKey], LCD_SCREEN_HEIGHT - 10, 8, 8, powerUpColor[fKey])
			drawText(1, 1, "Freeze powerup now available! (F1 to use)", powerUpColor[fKey], color[1])
		elseif active==2 then drawRectFill(fKeyButtonCoords[fKey], LCD_SCREEN_HEIGHT - 10, 8, 8, powerUpColor[fKey])
	end
end


print("entering game loop")
----game loop----
while keyMenuFast() ~= key.Exit do
	----DRAW----
	--draw background
	drawRectFill(0,0,LCD_SCREEN_WIDTH,LCD_SCREEN_HEIGHT,color[2])
	
	--draw powerups icons
	drawRectFill(0, LCD_SCREEN_HEIGHT - 12, LCD_SCREEN_WIDTH, 12, color[3])
	
	for i=1, 6, 1 do
		drawPowerUpIcons(i, powerUpActive[i])
	end
	
	--draw ball
	drawRectFill(ball.x, ball.y, ball.width, ball.height, color[1])
	
	--draw player paddle
	drawRectFill(0, paddle.player, paddle.width, paddle.height, color[1])
	
	--draw wall
	drawRectFill(LCD_SCREEN_WIDTH-wall.width, 0, wall.width, LCD_SCREEN_HEIGHT, color[1])
	
	----POWERUPS----
	if credits==2 then powerUpActive[1] = 1
		elseif credits==3 then powerUpActive[1] = 2
	end
	
	
	
	----CONTROLS----
	--control paddle
	if keyMenuFast()==key.Up and paddle.player>0 then paddle.player = paddle.player - paddle.speed
		elseif keyMenuFast()==key.Down and paddle.player<LCD_SCREEN_HEIGHT - paddle.height - 12 then paddle.player = paddle.player + paddle.speed
	end
	
	--control powerups
	if keyMenuFast()==key.F1 and powerUpActive[1]>0 and powerUpActive[1]<3 
		then credits=credits-2 powerUpActive[1]=3
	end
	
	
	----COLLISIONS----
	--check for collisions
	
	if ball.x < 0 + paddle.width and ball.y > paddle.player and ball.y < paddle.player + paddle.height then ball.x = 0 + paddle.width dir.x=1 credits = credits+1
		elseif ball.x < 0 then print("Game Over") break
	end
	
	if ball.x>LCD_SCREEN_WIDTH - ball.width - wall.width 
		then ball.x = LCD_SCREEN_WIDTH - ball.width - wall.width dir.x=-1 credits = credits+1
	end
	
	if ball.y<0 then ball.y=0 dir.y=1
		elseif ball.y>LCD_SCREEN_HEIGHT - ball.height - 13 then ball.y = LCD_SCREEN_HEIGHT - ball.height - 12 dir.y=-1
	end
	
	
	----ETC----
	--make new vars
	ball.x = ball.x + (dir.x * speed.x)
	ball.y = ball.y + (dir.y * speed.y)
	
	--refresh screen
	fastCopy()
	
	--[[-- 
	--debug
	print("ball.y:" .. ball.y)
	print("ball.x:" .. ball.x)
	
	
	if keyMenuFast()==key.Left and testVar>0 then testVar = testVar - 1
		elseif keyMenuFast()==key.Right then testVar = testVar+1
	end
	--]]--
	
end
print("exiting./n")


