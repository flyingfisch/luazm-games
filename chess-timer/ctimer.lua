print("Chess timer starting...")
--function variables
local drawRectFill = zmg.drawRectFill
local drawRect = zmg.drawRect
local fastCopy = zmg.fastCopy
local makeColor = zmg.makeColor
local keyMenuFast = zmg.keyMenuFast
local clear = zmg.clear
local drawText = zmg.drawText
local keyDirectPoll = zmg.keyDirectPoll
local keyDirect = zmg.keyDirect
local floor = math.floor
local ticks = zmg.ticks

--screen vars
local SCREEN_WIDTH = 384
local SCREEN_HEIGHT = 216
local exit = 0

--game variables
local key = {F1=79, F2=69, F3=59, F4=49, F5=39, F6=29, Alpha=77, Exit=47, 
Optn=68, Up=28, Down=37, Left=38, Right=27, EXE=31}
local chesstimer = {timerStart=60, add=0, turn="Black", turnNum=2, selected=1, version="1.1 Beta"}
local color = {bg=makeColor("white"), fg=makeColor("black"), dbfg=makeColor("red"), dbbg=makeColor("black")}
local continue = 0
local intro = 1
local buffer = 0
local timers = {}
local playerColor = {makeColor("white"), makeColor("black")}
local start=0
local timeElapsedSinceTurn = 0

--first poll and first start timer
keyDirectPoll()
local startTime = ticks()

--functions

local function timeElapsed()
	return floor((ticks()-startTime)/128)
end

local function convertTime(t, format)
	min = floor(t/60)
	sec = t-(min*60)
	if format=="m" then return min
		elseif format=="s" then return sec
	end
end

local function wait(timeToWait)
	local start = timeElapsed()
	while timeElapsed() - start < timeToWait do end
end

local function waitForKey(key)
	while keyDirect(key) == 0 do
		keyDirectPoll()
	end
end

local function toggleTurn()
	fastCopy()
	timers[chesstimer.turnNum + 2] = (timers[chesstimer.turnNum + 2] - timeElapsedSinceTurn)
	if timers[chesstimer.turnNum + 2] + chesstimer.add < chesstimer.timerStart then
		timers[chesstimer.turnNum + 2] = timers[chesstimer.turnNum + 2] + chesstimer.add
		else timers[chesstimer.turnNum + 2] = chesstimer.timerStart
	end
	if chesstimer.turn == "White" then chesstimer.turn = "Black" chesstimer.turnNum = 2 chesstimer.selected = 2
		else chesstimer.turn = "White" chesstimer.turnNum = 1 chesstimer.selected = 1
	end
	start = timeElapsed()
end
--[[--
local function outOfTime(message)
	clear()
	drawText(floor(SCREEN_WIDTH/2),floor(SCREEN_HEIGHT/2),message,makeColor("black"), makeColor("red"))
	fastCopy()
	waitForKey(key.Exit)
end
--]]--

local function about()
	clear()
	drawText(1, 1, "Chesstimer v." .. chesstimer.version, color.fg, color.bg)
	drawText(1, 20, "by TakeFlight Productions", color.fg, color.bg)
	drawText(1, 40, "(flyingfisch)", color.fg, color.bg)
	drawText(1, 60, "http://casio.clrhome.org/", color.fg, color.bg)
	drawText(1, 100, "CC License share and share alike", color.fg, color.bg)
	drawText(1, 160, "(Press [exit])", color.fg, color.bg)
	fastCopy()
	waitForKey(key.Exit)
	while keyDirect(key.Exit) > 0 do keyDirectPoll() end
end

local function introScreen()
	while keyDirect(key.Exit) > 0 do keyDirectPoll() end
	while keyDirect(key.EXE) > 0 do keyDirectPoll() end
	clear()
	continue = 0
	drawText(1, 1, "WAIT...", color.fg, color.bg)
	fastCopy()
	min = 1
	add=0
	
	wait(1)
	
	
	
	while continue==0 do
		clear()
		keyDirectPoll()
		if keyDirect(key.Up)>0 and min<15 then 
			while keyDirect(key.Up) > 0 do keyDirectPoll() end
			min = min+1
			elseif keyDirect(key.Down)>0 and min>1 then 
				while keyDirect(key.Down) > 0 do keyDirectPoll() end
				min = min-1
		end
		
		if keyDirect(key.Right)>0 and add<60 then 
			while keyDirect(key.Right) > 0 do keyDirectPoll() end
			add = add+1
			elseif keyDirect(key.Left)>0 and add>0 then 
				while keyDirect(key.Left) > 0 do keyDirectPoll() end
				add = add-1
		end
		
		if keyDirect(key.Optn)>0 then
			while keyDirect(key.Optn)>0 do keyDirectPoll() end
			about()
		end
		
		if keyDirect(key.Exit)>0 then exit = 1 break end
		
		if keyDirect(key.EXE)>0 then continue = 1 end
		
		drawText(1, 1, "Press [EXE] to continue", color.fg, color.bg)
		drawText(1, 20, "Minutes (UP/DN): " .. min, color.fg, color.bg)
		drawText(1, 40, "Sec added after turn (LT/RT): " .. add, color.fg, color.bg)
		drawText(1, 100, "Optn: About", color.fg, color.bg)
		
		fastCopy()
	end
	chesstimer.timerStart = min*60
	timers[1] = chesstimer.timerStart
	timers[2] = chesstimer.timerStart
	timers[3] = chesstimer.timerStart
	timers[4] = chesstimer.timerStart
	chesstimer.add = add
	intro = 0
end

local function chessTimerScreen()
	clear()
	start = timeElapsed()
	while exit ~= 1 do
		--workaround to allow screenshots
		if zmg.keyDirect(51)>0 then zmg.keyMenu() end 
		
		if keyDirect(key.Exit) > 0 then exit = 1 
			elseif keyDirect(key.F1) > 0 then 
				while keyDirect(key.F1) > 0 do keyDirectPoll() end 
				toggleTurn()
		end
			
		if keyDirect(key.Optn) > 0 then
			timers[chesstimer.turnNum + 2] = (timers[chesstimer.turnNum + 2] - timeElapsedSinceTurn)
			
			drawText(50,40,"Press EXE to resume",makeColor("black"), makeColor("red"))
			fastCopy()
			waitForKey(key.EXE)
			start = timeElapsed()
		end
		
		
		
		
		--drawing
		clear()
		
		
		drawRectFill(85, (chesstimer.selected * 20) + 43, 10, 10, makeColor("darkblue"))
		drawText(1, SCREEN_HEIGHT - 20, "Next Player", color.fg, color.bg)
		
		drawText(200, SCREEN_HEIGHT - 20, "[OPTN] Pause", color.fg, color.bg)
		
		drawText(1, 1, "Turn: " .. chesstimer.turn, color.fg, color.bg)
		drawText(100, 60, "White: " .. convertTime(timers[1],"m") .. ":" .. convertTime(timers[1],"s"), color.fg, color.bg)
		drawText(100, 80, "Black: " .. convertTime(timers[2],"m") .. ":" .. convertTime(timers[2],"s"), color.fg, color.bg)
		drawRect(1, 115, SCREEN_WIDTH - 3, 30, color.fg)
		drawRect(1, 150, SCREEN_WIDTH - 3, 30, color.fg)
		drawRect(1, 115, (timers[1]*(SCREEN_WIDTH-3))/chesstimer.timerStart, 30, color.fg)
		drawRectFill(1, 151, (timers[2]*(SCREEN_WIDTH-3))/chesstimer.timerStart, 29, color.fg)
		
		fastCopy()
		
		--math
		timeElapsedSinceTurn = timeElapsed() - start
		timers[chesstimer.turnNum] = timers[chesstimer.turnNum + 2] - timeElapsedSinceTurn
		if timers[chesstimer.turnNum] < 0 then
			drawText(1,1,chesstimer.turn .. " ran out of time!",makeColor("black"), makeColor("red"))
			fastCopy()
			waitForKey(key.Exit) exit = 1 
		end
		
		--[[-- debug
		drawText(1, 70, "DEBUG: " .. timers[1], color.dbfg, color.dbbg)
		--]]--
		
		keyDirectPoll()
	end
	exit = 0
	intro = 1
end


--main loop
while exit~=1 do
	clear()
	
	--intro screen
	if intro == 1 then fastCopy() introScreen() end
	if exit==1 then break end
	
	--wait screen
	clear()
	drawText(1, 1, "Press F1 when ready", color.fg, color.bg)
	drawText(1, SCREEN_HEIGHT - 20, "Next Player", color.fg, color.bg)
	fastCopy()
	
	--wait
	waitForKey(key.F1)
	
	--chesstimer screen
	chessTimerScreen()
	
	--refresh screen
	fastCopy()
	--keypoll
	keyDirectPoll()
end

print("done.")
print("")



