-- base functions
local clear = zmg.clear
local drawCircle = zmg.drawCircle
local drawLine = zmg.drawLine
local drawPoint = zmg.drawPoint
local drawRectFill = zmg.drawRectFill
local drawText = zmg.drawText
local floor = math.floor
local fastCopy = zmg.fastCopy
local keyMenuFast = zmg.keyMenuFast
local keyDirectPoll = zmg.keyDirectPoll
local keyDirect = zmg.keyDirect
local makeColor = zmg.makeColor
local random = math.random
local ticks = zmg.ticks

-- screen vars
local SCREEN_WIDTH = 384
local SCREEN_HEIGHT = 216

-- key vars
local key = {F1=79, F2=69, F3=59, F4=49, F5=39, F6=29, Alpha=77, Exit=47, 
Optn=68, Up=28, Down=37, Left=38, Right=27, EXE=31, Shift=78}

-- control vars
local exit=0
local exitAll=0
local continue=0
local version="0.1"

-- main vars
local color = {fg=makeColor("lightpink"), bg=makeColor("darkviolet"), player=makeColor("powderblue"), obstacle=makeColor("powderblue"), powerup=makeColor("plum")}
local colorscheme = 1
local colorschemes = {}
colorschemes[1] = {fg=makeColor("lightpink"), bg=makeColor("darkviolet"), player=makeColor("powderblue"), obstacle=makeColor("powderblue"), powerup=makeColor("plum")}
colorschemes[2] = {fg=makeColor("lightblue"), bg=makeColor("blue"), player=makeColor("powderblue"), obstacle=makeColor("powderblue"), powerup=makeColor("darkblue")}
colorschemes[3] = {fg=makeColor("limegreen"), bg=makeColor("black"), player=makeColor("darkgreen"), obstacle=makeColor("darkgreen"), powerup=makeColor("blue")}


-- vars
local player = {x=SCREEN_WIDTH/2-8, y=0}
local horizon = SCREEN_HEIGHT/2
local counter = {game=0, jump=0, obstacle=1, powerup=1, powerups={zoom=0}}
local obstacles = {}
local powerups = {}
local travelled = 0
local speed = 2
local rand=0
local difficulty=0
local collided=0

-- functions
local function debounce(key)
	while keyDirect(key)>0 do keyDirectPoll() end
end

local function explode()
	for i=16, SCREEN_WIDTH, 5 do
		drawRectFill((SCREEN_WIDTH/2-8)-(i/2), ((horizon-16)-player.y)-(i/2), i, i, color.player)
		fastCopy()
	end
	exit=1
end

local function collision(first, second)
	if first and second then
		if SCREEN_WIDTH-second>first.x and SCREEN_WIDTH-second<first.x+16 and first.y<16 then
			return 1
		end
		
		if first.x>SCREEN_WIDTH-second and first.x<SCREEN_WIDTH-second+16 and first.y<16 then
			return 1
		end
	end
end





-- game loop
keyDirectPoll()
while exitAll~=1 do
	-- menu
	while continue~=1 do
		color = colorschemes[colorscheme]
		keyDirectPoll()
		drawRectFill(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, color.bg)
		drawRectFill(0, horizon, SCREEN_WIDTH, SCREEN_HEIGHT-horizon, color.fg)
		drawText(10,20,"Box Jump  " .. version,color.fg,color.bg)
		drawText(10,40,"F1: Play",color.fg,color.bg)
		drawText(10,60,"F2: Change color scheme",color.fg,color.bg)
		drawRectFill(SCREEN_WIDTH-50, horizon-13, 10, 10, color.powerup)
		drawRectFill(SCREEN_WIDTH-75, horizon-16, 16, 16, color.obstacle)
		if keyDirect(key.F2)>0 and colorscheme<#colorschemes then debounce(key.F2) colorscheme=colorscheme+1
			elseif keyDirect(key.F2)>0 and colorscheme>#colorschemes-1 then debounce(key.F2) colorscheme=1
		end
		if keyDirect(key.F1)>0 then continue=1 end
		if keyDirect(key.Exit)>0 then exitAll=1 break end
		fastCopy()
	end

	if exitAll==1 then break end
	continue=0
	
	-- game
	while exit~=1 do
		-- check for keys
		keyDirectPoll()
		if keyDirect(key.Exit)>0 then exit=1 end
		if keyDirect(key.Shift)>0 and player.y==0 then counter.jump=1 end
		
		-- calculations
		-- jump
		if counter.jump>0 then 
			counter.jump=counter.jump+2
			if counter.jump<40 then
				player.y=player.y+2
				elseif counter.jump<80 or player.y>0 then
					player.y=player.y-2
				elseif player.y<1 then
					counter.jump=0
					player.y = 0
			end
		end
		
		-- obstacles and powerups
		if counter.game>100+rand or travelled==0 then
			if random(1,10)~=1 then
				obstacles[counter.obstacle] = 1
				counter.obstacle=counter.obstacle+1
				else
					powerups[counter.powerup] = 1
					counter.powerup=counter.powerup+1
			end
			counter.game=0
			rand=random(-difficulty,difficulty)
			if difficulty<30 then difficulty = difficulty+2 end
		end
		
		-- move obstacles and check for collisions
		for i=1, #obstacles, 1 do
			obstacles[i] = obstacles[i]+speed
			if collision(player, obstacles[i]) and counter.powerups.zoom<1 then
				explode()
				
				elseif collision(player, obstacles[i]) then
					collided=1
				else
					collided=0
			end
		end
		
		if exit==1 then exit=0 break end
		
		-- move powerups and check for collisions
		for i=1, #powerups, 1 do
			powerups[i] = powerups[i]+speed
			if collision(player, powerups[i]) and counter.powerups.zoom<1 then
				counter.powerups.zoom=1
			end
		end
		
		-- do powerups
		if counter.powerups.zoom>0 then 
			counter.powerups.zoom=counter.powerups.zoom+1 
		end
		
		if counter.powerups.zoom>0 and counter.powerups.zoom<50 then
			speed=100/counter.powerups.zoom
			elseif counter.powerups.zoom>50 and collided~=1 then
				counter.powerups.zoom=0
				speed=2
		end
		
		-- draw background color
		drawRectFill(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, color.bg)
		
		-- draw ground
		drawRectFill(0, horizon, SCREEN_WIDTH, SCREEN_HEIGHT-horizon, color.fg)
		
		-- draw score
		drawText(1,1,"Score:" .. travelled,color.fg,color.bg)
		
		-- draw obstacles
		for i=1, #obstacles, 1 do
			if obstacles[i]<SCREEN_WIDTH+16 then
				drawRectFill(SCREEN_WIDTH-obstacles[i], horizon-16, 16, 16, color.obstacle)
			end
		end
		
		-- draw powerups
		for i=1, #powerups, 1 do
			if powerups[i]<SCREEN_WIDTH+16 then
				drawRectFill(SCREEN_WIDTH-powerups[i]-3, horizon-13, 10, 10, color.powerup)
			end
		end
		
		-- draw player
		drawRectFill(SCREEN_WIDTH/2-8, (horizon-16)-player.y, 16, 16, color.player)
		
		-- fastCopy
		fastCopy()
		counter.game = counter.game+speed
		travelled=floor(travelled+speed)
	end
	exit=0
	travelled=0
end
