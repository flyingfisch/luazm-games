print('starting...')
print('setting first key poll point')
zmg.keyDirectPoll()
print('setting start time')
local startTime = zmg.ticks()
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

-- keys
local key = {F1=79, F2=69, F3=59, F4=49, F5=39, F6=29, Alpha=77, Exit=47, 
Optn=68, Up=28, Down=37, Left=38, Right=27, EXE=31, Shift=78}

-- variables
print('setting variables')
local cutscene = 1
local color = {fg=makeColor("blue"),fg2=makeColor(0,0,75),
fg3=makeColor(200,200,200),bg=makeColor("black"),bg2=makeColor(50,50,75),
alert=makeColor("darkviolet"),bgsight=makeColor(0,0,180),
metal=makeColor("steelblue"),logo=makeColor(0,0,255)}
local origin = {x=0, y=0}
local game = {level=1,sight=1,zoom=1,version="0.1b"}
local counter = {gunMotion=0,kick=0,level=0}
local i = {level=1, extra=1}
local exitAll = 0
local continue = 0
local exit = 0
local shotsFired = 0
local survival = {enemy=1,difficulty=300,score=0}
local enemyDown = {}
local hostageDown = {}
local levelData = {}
local levelName={"Training 1","Training 2","Training 3","Truck Kill",
"Protection","Break-in","Assassin","Truck Kill 2","Recon","Sniper Kill"}
levelName[100] = "Survival"
local cutSceneText = {
{'Hello, Rookie. I will be your',
 'instructor over the next couple',
 'of days. The first thing I want',
 'you to do is show me that you',
 'can hit a target.',
 ' ',
 'HINT: Use [shift] to shoot'},
{'Congrats on passing your first',
 'exam. now you will have to pass',
 'a slightly harder test.',
 ' ',
 'Hit the moving target.',
 ' ',
 'HINT: Don\'t fight the muzzle',
 'movement. Instead, use it for',
 'your benifit.' },
{'Ha, you thought this game was',
 'gonna be easy?',
 '',
 'Hit the target within the',
 'second ring, but don\'t ',
 'hit the white hostage.',
 '',
 'HINT: Use [alpha] to switch to',
 'scope view'},
{'Recruit, we need men on the',
 'battlefield, so your training',
 'will continue there.',
 'Good luck.',
 '',
 'Destroy the truck before it gets',
 'away.',
 '',
 'HINT: Vehicles can be stopped',
 'by destroying the engine.'},
{'You are responsible for',
 'protecting the general.',
 '',
 'Don\'t let him get killed.',
 
},
{'We need get through this',
 'gate. You have been chosen',
 'to secure it for us.',
 '',
 'Take out both guards and don\'t',
 'get shot.'
},
{'You have been chosen to',
 'take out the top engineer',
 'on the enemy\'s nuclear',
 'research team.',
 'Intel says he was last seen',
 'in his apartment.'
},
{'A terrorist truck loaded with',
 'explosives has been detected near',
 'your position. Take it out.'
},
{'An entry team is standing by.',
 'They have orders to enter the',
 'building and retrieve secret',
 'information.',
 '',
 'NOTE: The entry team has no',
 'door breaking equipment with',
 'them.'
},
{'The entry team has successfully',
 'retrieved the information.',
 '',
 'Protect them on the way out.'
},
}
cutSceneText[100] = 
{'Shoot the enemies in the',
 'trench before they shoot',
 'you!',
 'Try to survive as long as',
 'you can.',
 }
local sightData = {}
-- sightData syntax:
-- sightData[sight] = {hitPoint={x,y},defaultZoom=<zoom factor>}
sightData[1] = {hitPoint={SCREEN_WIDTH/2,SCREEN_HEIGHT-32},defaultZoom=1}
sightData[2] = {hitPoint={SCREEN_WIDTH/2,SCREEN_HEIGHT/2},defaultZoom=1.5}
-- levelData syntax:
-- levelData[level] = {hitBox={{x1,y1,x2,y2},{<next_target>}},horizon=<where_to_put_horizon>,max={x,y},min={x,y}}
-- we do not have to worry about zoom because that is handled in the fire() function
-- note that you must have a levelData entry for level to be recognized
levelData[1]={
	hitBox={
		{(SCREEN_WIDTH/2)-40,(SCREEN_HEIGHT/2)-40,(SCREEN_WIDTH/2)+40,(SCREEN_HEIGHT/2)+40}
	},
horizon=(SCREEN_HEIGHT/2)+80,
max={1000,1000},
min={-1000,-1000}}

levelData[2]={
	hitBox={
		{(SCREEN_WIDTH/2)-40,(SCREEN_HEIGHT/2)-40,(SCREEN_WIDTH/2)+40,(SCREEN_HEIGHT/2)+40}
	},
horizon=(SCREEN_HEIGHT/2)+80,
max={1000,1000},
min={-1000,-1000}}

levelData[3]={
	hitBox={
		{(SCREEN_WIDTH/2)-40,(SCREEN_HEIGHT/2)-40,(SCREEN_WIDTH/2)+40,(SCREEN_HEIGHT/2)+40}
	},
	hostageBox={
		{(SCREEN_WIDTH/2)-30,(SCREEN_HEIGHT/2)-40,((SCREEN_WIDTH/2)-30)+130,(SCREEN_HEIGHT/2)+150}
	},
horizon=(SCREEN_HEIGHT/2)+80,
max={1000,1000},
min={-1000,-1000}}

levelData[4]={
	hitBox={
		{(SCREEN_WIDTH/2)+160,(SCREEN_HEIGHT/2)+40,((SCREEN_WIDTH/2)+160)+100,(SCREEN_HEIGHT/2)+100}
	},
horizon=(SCREEN_HEIGHT/2)+80,
max={250,1000},
min={-1000,-1000}}

levelData[5]={
	hitBox={
		{(SCREEN_WIDTH/2)-255,((SCREEN_HEIGHT/2)+80)-45,((SCREEN_WIDTH/2)-255)+20,((SCREEN_HEIGHT/2)+80)-45+20}
	},
	hostageBox={
		{(SCREEN_WIDTH/2), ((SCREEN_HEIGHT/2)+30), (SCREEN_WIDTH/2)+20, ((SCREEN_HEIGHT/2)+30)+20}
	},
horizon=(SCREEN_HEIGHT/2)+80,
max={1000,1000},
min={-1000,-1000},
walk={1}}

levelData[6]={
	hitBox={
		{(SCREEN_WIDTH/2)-45,((SCREEN_HEIGHT/2)+80)-45,((SCREEN_WIDTH/2)-45)+20,((SCREEN_HEIGHT/2)+80)-45+20},
		{(SCREEN_WIDTH/2)+155,((SCREEN_HEIGHT/2)+80)-45,((SCREEN_WIDTH/2)+155)+20,((SCREEN_HEIGHT/2)+80)-45+20}
	},
horizon=(SCREEN_HEIGHT/2)+80,
max={1000,1000},
min={-1000,-1000},
stage=1}

levelData[7]={
	hitBox={
		{(SCREEN_WIDTH/2)+50,((SCREEN_HEIGHT/2)+80)-35,((SCREEN_WIDTH/2)+50)+20,((SCREEN_HEIGHT/2)+80)-20}
	},
horizon=(SCREEN_HEIGHT/2)+80,
max={1000,1000},
min={-1000,-1000},
stage=1,
guard=0}

levelData[8]={
	hitBox={
		{(SCREEN_WIDTH/2)+160,(SCREEN_HEIGHT/2)+40,((SCREEN_WIDTH/2)+160)+100,(SCREEN_HEIGHT/2)+100}
	},
horizon=(SCREEN_HEIGHT/2)+80,
max={250,1000},
min={-1000,-1000}}

levelData[9]={
	hitBox={
		{((SCREEN_WIDTH/2)+500),((SCREEN_HEIGHT/2)+80)-60,((SCREEN_WIDTH/2)+500)+20,((SCREEN_HEIGHT/2)+80)-40}
	},
horizon=(SCREEN_HEIGHT/2)+80,
max={1000,1000},
min={-1000,-1000},
stage=1,
guard=0,
walk={1}}

levelData[10]={
	hitBox={
		{(SCREEN_WIDTH/2)+50,((SCREEN_HEIGHT/2)+80)-5,(SCREEN_WIDTH/2)+60,((SCREEN_HEIGHT/2)+80)}
	},
horizon=(SCREEN_HEIGHT/2)+80,
max={1000,1000},
min={-1000,-1000},
walk={1}}

levelData[100]={
	hitBox={
		{1,((SCREEN_HEIGHT/2)+80)-15,3,(SCREEN_HEIGHT/2)+80}
	},
horizon=(SCREEN_HEIGHT/2)+80,
max={1000,1000},
min={-1000,-1000}
}

local movementX = 1
local movementY = -1

-- base routines
local function debounce(key)
	while keyDirect(key)>0 do keyDirectPoll() end
end

local function timeElapsed()
	return floor((ticks()-startTime)/128)
end

local function wait(timeToWait)
	local start = timeElapsed()
	while timeElapsed() - start < timeToWait do end
end

local function waitForKey(Key)
	while keyDirect(Key)==0 and keyDirect(key.Exit)==0 do
		keyDirectPoll()
	end
end

-- drawing routines
-- logo
local function drawLogo(x, y)
	-- draw N
	drawRectFill(x,y,10,50,color.logo)
	drawRectFill(x+10,y+10,10,10,color.logo)
	drawRectFill(x+20,y+20,10,10,color.logo)
	drawRectFill(x+30,y,10,50,color.logo)
	-- draw E
	drawRectFill(x+50,y,10,50,color.logo)
	drawRectFill(x+60,y,20,10,color.logo)
	drawRectFill(x+60,y+20,10,10,color.logo)
	drawRectFill(x+60,y+40,20,10,color.logo)
	-- draw O
	drawRectFill(x+90,y,10,50,color.logo)
	drawRectFill(x+110,y,10,50,color.logo)
	drawRectFill(x+100,y,10,10,color.logo)
	drawRectFill(x+100,y+40,10,10,color.logo)
	-- draw N
	drawRectFill(x+130,y,10,50,color.logo)
	drawRectFill(x+140,y+10,10,10,color.logo)
	drawRectFill(x+150,y+20,10,10,color.logo)
	drawRectFill(x+160,y,10,50,color.logo)
end

-- displays an alert
local function drawAlert(x, y, string)
	drawText(x, y, string, color.alert, color.bg)
	fastCopy()
end

-- garden-variety round target
local function drawTarget(x, y)
	x = x*game.zoom
	y = y*game.zoom
	drawCircle(x, y, 20*game.zoom, color.fg)
	drawCircle(x, y, 40*game.zoom, color.fg)
	drawCircle(x, y, 60*game.zoom, color.fg)
end

-- draw a circle that handles zoom automatically
local function drawCircleZoom(x,y,radius, c)
	x = x*game.zoom
	y = y*game.zoom
	radius = radius*game.zoom
	
	drawCircle(x, y, radius, c)
end

-- draw a rect that handles zoom
local function drawRectZoom(x, y, width, height, color)
	x = x*game.zoom
	y = y*game.zoom
	width = width*game.zoom
	height = height*game.zoom
	
	drawRectFill(x, y, width, height, color)
end

-- draw a line that handles zoom automatically
local function drawLineZoom(x1,y1,x2,y2,color)
	x1 = x1*game.zoom
	y1 = y1*game.zoom
	x2 = x2*game.zoom
	y2 = y2*game.zoom
	
	drawLine(x1, y1, x2, y2, color)
end

--draw target in bg2 color
local function drawTargetBg(x, y)
	x = x*game.zoom
	y = y*game.zoom
	drawCircle(x, y, 20*game.zoom, color.fg)
	drawCircle(x, y, 40*game.zoom, color.bg2)
	drawCircle(x, y, 60*game.zoom, color.bg2)
end

-- draw a box
local function drawBox(x, y, width, height)
	x = x*game.zoom
	y = y*game.zoom
	width = width*game.zoom
	height = height*game.zoom
	
	drawRectFill(x, y, width, height, color.fg2)
end

-- draw box in bg2 color
local function drawBoxBg(x, y, width, height)
	x = x*game.zoom
	y = y*game.zoom
	width = width*game.zoom
	height = height*game.zoom
	
	drawRectFill(x, y, width, height, color.bg2)
end

-- draw white hostage box
local function drawBoxHostage(x, y, width, height)
	x = x*game.zoom
	y = y*game.zoom
	width = width*game.zoom
	height = height*game.zoom
	
	drawRectFill(x, y, width, height, color.fg3)
end

-- draw gun
local function drawGun(x,y)
	drawRectZoom(x, y, 30, 10, color.metal)
	drawRectZoom(x+15, y, 30, 5, color.metal)
end
-- draw a stickman (frame must be <20)
local function drawStickMan(x, y, color, frame)
	-- draw head
	drawCircleZoom(x+10, y+10, 10, color)
	-- draw body
	drawLineZoom(x+10, y+20, x+10, y+40, color)
	-- draw legs
	drawLineZoom(x+10, y+40, x+frame, y+60, color)
	drawLineZoom(x+10, y+40, (x+20)-frame, y+60, color)
end

-- draw prone sniper
local function drawSniper(x, y, color)
	-- draw head
	drawCircleZoom(x, y, 10, color)
	-- draw body and legs
	-- drawLineZoom(x+40, y, x, y, color)
	-- draw gun
	drawGun(x-15, y)
end

-- draw dead stickman (use same x/y as you would for drawStickMan)
local function drawStickManDead(x, y, color)
	-- draw head
	drawCircleZoom(x+50, y+50, 10, color)
	-- draw body
	drawLineZoom(x+40, y+50, x+20, y+60, color)
	-- draw legs
	drawLineZoom(x+20, y+60, x, y+60, color)
	-- draw arm
	drawLineZoom(x+40, y+50, x+30, y+40, color)
	drawLineZoom(x+30, y+40, x+20, y+50, color)
end

-- draw truck w/o trailer
local function drawTruck(x, y)
	-- draw bottom
	drawBox(x,y+100,345,20)
	-- draw cab
	drawBox(x+150,y,90,100)
	-- draw front end
	drawBox(x+240,y+40,100,60)
	-- draw fifth wheel
	drawBox(x+25,y+90,50,10)
	-- draw wheels
	for i=1, 15, 1 do
		drawCircleZoom(x+35,y+115,30-i,color.bg2)
		drawCircleZoom(x+100,y+115,30-i,color.bg2)
		drawCircleZoom(x+310,y+115,30-i,color.bg2)
	end
end

-- sights (draws sight, data is in sightData array)
local function drawSights(sightID)
	if sightID==1 then
		-- normal blade and notch sights: _._
		-- base
		drawRectFill((SCREEN_WIDTH/2)-84, SCREEN_HEIGHT-8, 140, 8, color.bgsight)
		-- left notch
		drawRectFill((SCREEN_WIDTH/2)-84, SCREEN_HEIGHT-32, 60, 32, color.fg)
		-- right notch
		drawRectFill((SCREEN_WIDTH/2)+24, SCREEN_HEIGHT-32, 60, 32, color.fg)
		-- post
		drawRectFill((SCREEN_WIDTH/2)-12, SCREEN_HEIGHT-32, 24, 32, color.fg)
	end
	if sightID==2 then
		-- post and ring scope: (')
		-- ring
		drawCircle(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, (SCREEN_HEIGHT/2)-2, color.fg)
		-- post
		drawRectFill((SCREEN_WIDTH/2)-6, (SCREEN_HEIGHT/2)+10, 13, (SCREEN_HEIGHT/2)-3, color.fg)
		-- point on top of post
		drawLine(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, (SCREEN_WIDTH/2)-6, (SCREEN_HEIGHT/2)+10, color.fg)
		drawLine(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, (SCREEN_WIDTH/2)+6, (SCREEN_HEIGHT/2)+10, color.fg)
	end
end


-- level functions
-- simple transition
local function transition()
	for i=1, (SCREEN_HEIGHT/2)+10, 4 do
		drawRectFill(0,0,SCREEN_WIDTH,i,color.fg)
		drawRectFill(0,SCREEN_HEIGHT-i,SCREEN_WIDTH,i,color.fg)
		fastCopy()
	end 
	drawLogo((SCREEN_WIDTH/2)-85,30)
	drawText((SCREEN_WIDTH/2)-135,90,"FIGHTER - Blue Edition",color.fg3,color.fg)
	fastCopy()
	wait(2)
end
-- last level cutscene
local function gameEnd()
	local gameEndt={
	'Excellent job, sniper.',
	'The information you just',
	'helped retrieve were plans',
	'for a new secret weapon.',
	'When the enemy realized',
	'that we had the plans, they',
	'immediately started peace',
	'negotiations. Until next time.',
	'               Arctic Owl.',
	'',
	'Press EXE'
	}
	drawRectFill(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, color.bg)
	for i=1, #gameEndt, 1 do
		drawText(1,(i*20)-20,gameEndt[i],color.fg,color.bg)
	end
	fastCopy()
	waitForKey(key.EXE)
	game.level=1
end
-- levelUp screen
local function levelUp()
	-- make sure another level exists
	if levelData[game.level+1] then
		game.level = game.level+1
		else gameEnd() exit=1
	end
	counter.level = 0
	origin = {x=0, y=0}
	counter = {gunMotion=0,kick=0,level=0}
	i = {level=1}
	cutscene=1
	enemyDown = {}
	hostageDown = {}
	origin.x = 0
	origin.y = 0
	shotsFired = 0
	i.extra=1
	transition()
end

-- restart level
local function restartLevel()
	-- make sure another level exists
	counter.level = 0
	origin = {x=0, y=0}
	counter = {gunMotion=0,kick=0,level=0}
	i = {level=1}
	cutscene=0
	enemyDown = {}
	hostageDown = {}
	origin.x = 0
	origin.y = 0
	shotsFired = 0
	i.extra=1
	transition()
end

-- end survival mode
local function endSurvival()
	drawText(1,1,"You were killed!",color.fg,color.bg)
	drawText(1,20,"Your score was " .. survival.score,color.fg,color.bg)
	drawText(1,40,"Press EXE",color.fg,color.bg)
	fastCopy()
	waitForKey(key.EXE)
	enemyDown=nil
	survival = {enemy=1,difficulty=300,score=0}
	counter.level = 0
	game.level=1
	origin = {x=0, y=0}
	counter = {gunMotion=0,kick=0,level=0}
	i = {level=1}
	cutscene=0
	enemyDown = {}
	hostageDown = {}
	origin.x = 0
	origin.y = 0
	shotsFired = 0
	i.extra=1
	exit=1
	transition()
end

-- draw level
local function drawLevel(level, x, y)
	-- do cutscene if this is the first draw, see levelUp()
	if cutscene==1 then
		drawRectFill(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, color.bg)
		for i=1, #cutSceneText[game.level], 1 do
			drawText(1,(i*20)-20,cutSceneText[game.level][i],color.fg,color.bg)
		end
		drawText(1,SCREEN_HEIGHT-20,"Press [EXE] to start",color.fg,color.bg)
		fastCopy()
		waitForKey(key.EXE)
		cutscene = 0
		transition()
	end
	-- level 1 (stationary target)
	if level==1 then
		-- draw cardboard that the target is attached to
		drawBox(x+((SCREEN_WIDTH/2)-65), y+((SCREEN_HEIGHT/2)-65), 130, 150)
		-- draw the target
		drawTarget(x+(SCREEN_WIDTH/2), y+(SCREEN_HEIGHT/2))
		
		-- if target1 is down, then level up
		if enemyDown[1] then levelUp() end
		
		-- level 2 (moving target)
		elseif level==2 then
			-- draw cardboard that the target is attached to
			drawBox((x+((SCREEN_WIDTH/2)+counter.level))-65, y+((SCREEN_HEIGHT/2)-65), 130, 150)
			--draw a runner for the moving part to attach to
			drawBoxBg(x+(SCREEN_WIDTH/2)-65, y+((SCREEN_HEIGHT/2)+82), 230, 10)
			-- move the target by adding counter.level to it
			drawTarget(x+((SCREEN_WIDTH/2)+counter.level), y+(SCREEN_HEIGHT/2))
			-- move the hitbox
			levelData[2]["hitBox"][1][1] = ((SCREEN_WIDTH/2)+counter.level)-40
			levelData[2]["hitBox"][1][3] = ((SCREEN_WIDTH/2)+counter.level)+40
			-- set the increment
			if counter.level>100 then i.level = -1
				elseif counter.level<0 then i.level = 1
			end
			
			-- if target1 is down, then level up
			if enemyDown[1] then levelUp() end
		
		-- level 3 (hostage)
		elseif level==3 then
			-- draw cardboard that target1 is attached to
			drawBox(x+((SCREEN_WIDTH/2)-65), y+((SCREEN_HEIGHT/2)-65), 130, 150)
			-- draw target1
			if enemyDown[1] then
				drawTargetBg(x+(SCREEN_WIDTH/2), y+(SCREEN_HEIGHT/2))
				else
					drawTarget(x+(SCREEN_WIDTH/2), y+(SCREEN_HEIGHT/2))
			end
			
			-- draw cardboard that represents a hostage
			drawBoxHostage(x+((SCREEN_WIDTH/2)-30), y+((SCREEN_HEIGHT/2)-65), 130, 150)
			
			-- if both targets are down, then level up, but if hostage down, restart
			if enemyDown[1] and not hostageDown[1] then levelUp()
				elseif hostageDown[1] then
					drawAlert(1,1,"Don't kill the hostage!")
					wait(2)
					-- restart level
					restartLevel()
			end
		-- level 4 (destroy truck before it gets away)
		elseif level==4 then
			-- draw the truck
			drawTruck(x+(SCREEN_HEIGHT/2)+(counter.level*4),y+(SCREEN_HEIGHT/2))
			-- move the hitbox
			levelData[4]["hitBox"][1][1] = ((SCREEN_WIDTH/2)+(counter.level*4))+160
			levelData[4]["hitBox"][1][3] = ((SCREEN_WIDTH/2)+(counter.level*4))+260
			
			-- check if truck is hit
			if enemyDown[1] then levelUp() end
			
			-- check if truck is off map
			if counter.level > 350 then 
				drawAlert(1,1,"The truck got away!")
				wait(2)
				-- restart level
				restartLevel()
			end
		-- level 5 (don't let general die)
		elseif level==5 then
			-- draw buildings
			drawBoxBg(x+((SCREEN_WIDTH/2)-310), y+(levelData[5]["horizon"]-60), 90, 60)
			-- draw windows and doors
			drawBox(x+((SCREEN_WIDTH/2)-260), y+(levelData[5]["horizon"]-50), 30, 30)
			drawBox(x+((SCREEN_WIDTH/2)-300), y+(levelData[5]["horizon"]-50), 30, 50)
			-- draw enemies
			drawSniper(x+((SCREEN_WIDTH/2)-245), y+(levelData[5]["horizon"]-35), color.fg)
			-- draw good guy
			if not hostageDown[1] then 
				drawStickMan(x+(SCREEN_WIDTH/2)+counter.level, y+(levelData[5]["horizon"]-50), color.fg3, levelData[5]["walk"][1])
				else
					i.level = 0
					drawStickManDead(x+(SCREEN_WIDTH/2)+counter.level, y+(levelData[5]["horizon"]-50), color.fg3)
			end
			-- move good guy hit box
			levelData[5]["hostageBox"][1][1]=(SCREEN_WIDTH/2)+counter.level
			levelData[5]["hostageBox"][1][3]=(SCREEN_WIDTH/2)+counter.level+20
			
			-- if badguy shot
			if hostageDown[1] and counter.level>50 then
				drawAlert(1,1,"You were too late!")
				wait(2)
				restartLevel()
			end
			
			--if player shot
			if hostageDown[1] and counter.level<50 then
				drawAlert(1,1,"Heya dimbulb! He's on OUR side!")
				wait(2)
				restartLevel()
			end
			-- check if enemy has shot the hostage
			if not enemyDown[1] and counter.level>50 then
				hostageDown[1] = 1
			end
			
			-- check if enemy is dead
			if enemyDown[1] then levelUp() end
			
			-- take care of walk timer
			if levelData[5]["walk"][1]>20 then levelData[5]["walk"][1] = 1
				else levelData[5]["walk"][1] = levelData[5]["walk"][1]+1
			end
			
		-- level 6 (two guards, kill before being noticed)
		elseif level==6 then
			-- draw buildings
			-- guardhouse 1
			drawBoxBg(x+((SCREEN_WIDTH/2)-100), y+(levelData[5]["horizon"]-60), 90, 60)
			-- guardhouse 2
			drawBoxBg(x+((SCREEN_WIDTH/2)+100), y+(levelData[5]["horizon"]-60), 90, 60)
			-- draw gate
			drawBox(x+(SCREEN_WIDTH/2)-10, y+(levelData[5]["horizon"]-30), 110, 30)
			-- draw windows and doors
			-- guardhouse 1
			drawBox(x+((SCREEN_WIDTH/2)-50), y+(levelData[6]["horizon"]-50), 30, 30)
			drawBox(x+((SCREEN_WIDTH/2)-90), y+(levelData[6]["horizon"]-50), 30, 50)
			-- guardhouse 2
			drawBox(x+((SCREEN_WIDTH/2)+150), y+(levelData[6]["horizon"]-50), 30, 30)
			drawBox(x+((SCREEN_WIDTH/2)+110), y+(levelData[6]["horizon"]-50), 30, 50)
			-- draw enemies
			if not enemyDown[1] then 
				drawSniper(x+((SCREEN_WIDTH/2)-35), y+(levelData[6]["horizon"]-35), color.fg)
			end
			if not enemyDown[2] then 
				drawSniper(x+((SCREEN_WIDTH/2)+165), y+(levelData[6]["horizon"]-35), color.fg)
			end
			
			-- check if both are down
			if enemyDown[1] and enemyDown[2] then levelUp() end
			
			-- take care of stages (1=nothing, 2=heard, 3=saw)
			if shotsFired>0 and levelData[6]["stage"]==1 then
				levelData[6]["stage"] = 2
				counter.level = 0
			end
			if levelData[6]["stage"]==2 and counter.level<10 then
				drawAlert(1,40,"He hears you!")
				elseif counter.level>30 and levelData[6]["stage"]==2 then
					levelData[6]["stage"] = 3
			end
			if levelData[6]["stage"]==3 and counter.level<20 then
				drawAlert(1,40,"He sees you!")
				elseif counter.level>30 and levelData[6]["stage"]==3 then
					levelData[6]["stage"] = 1
					drawAlert(1,1,"You were killed!")
					fastCopy()
					wait(2)
					restartLevel()
			end
			
		-- level 7 (kill enemy inside building)
		elseif level==7 then
			-- draw building
			drawBoxBg(x+SCREEN_WIDTH/2, y+(levelData[7]["horizon"]-60), 100, 60)
			-- draw window
			drawBox(x+((SCREEN_WIDTH/2)+50), y+(levelData[7]["horizon"]-50), 30, 30)
			-- draw guard
			drawCircleZoom(x+(levelData[7]["guard"]+(SCREEN_WIDTH/2)+30), y+(levelData[7]["horizon"]-20), 10, color.bg2)
			
			-- check if hit
			if enemyDown[1]==1 and levelData[7]["guard"]>5 then
				levelUp()
				else enemyDown[1]=0
			end
			
			-- take care of the counter
			if levelData[7]["guard"]>25 then i.extra=-1 
				elseif levelData[7]["guard"]<-5 then i.extra=1
			end
			levelData[7]["guard"] = levelData[7]["guard"]+i.extra
			
		-- level 8 (terrorist truck)
		elseif level==8 then
			-- set speed
			i.level = 5
			-- draw the truck
			drawTruck(x+((SCREEN_HEIGHT/2)+counter.level)-100,y+(SCREEN_HEIGHT/2))
			-- move the hitbox
			levelData[8]["hitBox"][1][1] = ((SCREEN_WIDTH/2)+counter.level)+60
			levelData[8]["hitBox"][1][3] = ((SCREEN_WIDTH/2)+counter.level)+160
			
			-- check if truck is hit
			if enemyDown[1] then levelUp() end
			
			-- check if truck is off map
			if counter.level > 400 then 
				drawAlert(1,1,"The truck got away!")
				wait(2)
				-- restart level
				restartLevel()
			end
		
		-- level 9 (photoID)
		elseif level==9 then
			-- draw bad guy
			drawStickMan(x+(((SCREEN_WIDTH/2)+500)-levelData[9]["guard"]), y+(levelData[9]["horizon"]-60), color.fg3, levelData[9]["walk"][1])
			-- draw building
			drawBoxBg(x+((SCREEN_WIDTH/2)-500), y+(levelData[9]["horizon"]-99), 500, 100)
			-- set hitbox
			levelData[9]["hitBox"][1][1] = (((SCREEN_WIDTH/2)+500)-levelData[9]["guard"])
			levelData[9]["hitBox"][1][3] = (((SCREEN_WIDTH/2)+500)-levelData[9]["guard"])+20
			-- move guy and hitbox
			if levelData[9]["guard"]<500 then
				if  levelData[9]["stage"]==1 then
					levelData[9]["guard"] = levelData[9]["guard"]+4
				end
			end
			
			if levelData[9]["stage"]==3 then
				levelData[9]["guard"] = levelData[9]["guard"]+1
			end
			
			if levelData[9]["guard"]>499 and levelData[9]["stage"]==1 then
				levelData[9]["stage"] = 2
				counter.level = 1
			end
			
			if levelData[9]["stage"]==2 and counter.level>7 then
				levelData[9]["stage"]=3
				counter.level = 1
			end
			
			if levelData[9]["stage"]==3 and counter.level>50 then
				levelData[9]["stage"]=4
			end
			
			if levelData[9]["stage"]==4 then
				drawAlert(1,1,"You were too late.")
				fastCopy()
				wait(3)
				levelData[9]["stage"]=1
				levelData[9]["guard"]=1
				restartLevel()
			end
			
			-- check if guy is dead
			if levelData[9]["stage"]==1 and enemyDown[1] then
				drawAlert(1,1,"The entry team arrived but found")
				drawAlert(1,20,"that the door requires photo")
				drawAlert(1,40,"recognition.")
				fastCopy()
				wait(3)
				levelData[9]["stage"]=1
				levelData[9]["guard"]=1
				restartLevel()
				elseif levelData[9]["stage"]>1 and enemyDown[1] then
					levelUp()
			end
			
			-- walk timer
			if levelData[9]["walk"][1]>20 then levelData[9]["walk"][1] = 1
				elseif levelData[9]["stage"]==1 or levelData[9]["stage"]==3 then
					levelData[9]["walk"][1] = levelData[9]["walk"][1]+4
			end
			
		-- level 10 (protect the entry team)
		elseif level==10 then
			
			-- draw entry team
			for i=1, 3, 1 do
				if hostageDown[i] then
					drawStickManDead(x+(((SCREEN_WIDTH/2)-50)-((i-1)*15)+counter.level),y+(levelData[10]["horizon"]-60),color.fg3)
					else
						drawStickMan(x+(((SCREEN_WIDTH/2)-50)-((i-1)*15)+counter.level),y+(levelData[10]["horizon"]-60),color.fg3,levelData[10]["walk"][1])
				end
			end
			-- draw building
			drawBoxBg(x+((SCREEN_WIDTH/2)-500), y+(levelData[10]["horizon"]-99), 500, 100)
			-- draw enemy sniper
			if counter.level>40 and counter.level<45 then
				drawCircleZoom(x+(SCREEN_WIDTH/2)+50, y+(levelData[10]["horizon"]+5)-(counter.level-40), 5, color.bg2)
				elseif counter.level>45 then
					drawCircleZoom(x+(SCREEN_WIDTH/2)+50, y+levelData[10]["horizon"], 5, color.bg2)
			end
			-- draw box to cover bottom of sniper
			drawRectZoom(x+(SCREEN_WIDTH/2)+43, y+levelData[10]["horizon"]+1, 15, 10, color.bg)
			-- check if entry team is down
			if not enemyDown[1] then
				if counter.level>64 then hostageDown[1]=1 end
				if counter.level>70 then hostageDown[2]=1 end
				if counter.level>85 then hostageDown[3]=1 end
				if counter.level>90 then 
					drawAlert(1,1,"You were too late!")
					wait(2)
					restartLevel()
				end
			end
			-- check if sniper is dead
			if enemyDown[1] and counter.level<65 then
				levelUp()
				elseif enemyDown[1] and counter.level>65 then
					drawAlert(1,1,"You were too late!")
					wait(2)
					restartLevel()
			end
			
			-- walk timer
			if levelData[10]["walk"][1]>20 then levelData[10]["walk"][1] = 1
				else
					levelData[10]["walk"][1] = levelData[10]["walk"][1]+1
			end
		-- survival mode
		elseif level==100 then
			-- check if player is dead
			if counter.level>survival.difficulty and enemyDown[1]~=1 then
				endSurvival()
			end
			-- change guy
			if counter.level<survival.difficulty and enemyDown[1]==1 then
				survival.enemy=random(1,70)
				counter.level=1
				survival.score=survival.score+(600-survival.difficulty)
				enemyDown[1]=0
				if survival.difficulty>100 then
					survival.difficulty = survival.difficulty-10
				end
			end
			-- display score
			drawText(1,20,"Score: " .. survival.score, color.fg, color.bg)
			-- display enemy
			drawCircleZoom(x+survival.enemy,y+levelData[100]["horizon"]-5,5,color.fg)
			-- display trench
			drawRectZoom(x+-50, y+levelData[100]["horizon"]-3, 150, 10, color.bg2)
			-- make hitbox
			levelData[100]["hitBox"][1][1]=survival.enemy-10
			levelData[100]["hitBox"][1][3]=survival.enemy+5
			
		
		-- if last level
		else exit=1
	end
	-- set level counter
	counter.level = counter.level+i.level
end

-- function to switch sights
local function changeSight(sightID)
	-- make sure that another sight exists, if not, select first sight
	if sightID > #sightData then game.sight = 1
		else game.sight = sightID
	end
	
	-- set proper zoom level for sight
	game.zoom = sightData[game.sight]["defaultZoom"]
end

-- function to move barrel (like in real life)
local function gunPhysics()
	--[[ move gun in figure 8 ]]--
	-- handle x coords
	if counter.gunMotion==0 or counter.gunMotion==15 or counter.gunMotion==20 or counter.gunMotion==35
		-- movement is multiplied by zoom
		then movementX = .25*game.zoom
	end
	if counter.gunMotion==5 or counter.gunMotion==10 or counter.gunMotion==25 or counter.gunMotion==30
		then movementX = -.25*game.zoom
	end
	-- handle y coords (top and bottom of figure 8)
	if counter.gunMotion==10 then movementY = .75
		elseif counter.gunMotion==30 then movementY = -.75*game.zoom
	end
	
	--[[ kick gun if shot was just fired ]]--
	--if gun is kicking, erase all figure 8 movement
	if counter.kick>0 then movementY = 0 movementX = 0 end
	-- if the counter is less than 20, then move the gun upwards,
	-- otherwise, move it back down
	if counter.kick>0 and counter.kick<20 then movementY = movementY-4
		elseif counter.kick>20 then movementY = movementY+1
	end
	
	-- reset counters if expired
	if counter.gunMotion>40 then counter.gunMotion = 0 end
	-- if counter.kick is more than 40, then reset it to zero to remove it until next shot
	if counter.kick>40 then counter.kick = 0 
		elseif counter.kick>0 then counter.kick = counter.kick+1
	end
	
	origin.x = origin.x+movementX
	origin.y = origin.y-movementY
	counter.gunMotion = counter.gunMotion+0.25
end

-- shoot function
local function fire()
	-- tell gunPhysics function that the gun should kick
	counter.kick = 1
	-- check if target is hit
	for i=1, #levelData[game.level]["hitBox"], 1 do
		local sightCoords = sightData[game.sight]["hitPoint"]
		local levelBox = levelData[game.level]["hitBox"][i]
		
		-- note that we are multiplying everything that is relative to origin by game.zoom
		-- check x
		if sightCoords[1] > (levelBox[1]+origin.x)*game.zoom and sightCoords[1] < (levelBox[3]+origin.x)*game.zoom
			--check y
			then if sightCoords[2] > (levelBox[2]+origin.y)*game.zoom and sightCoords[2] < (levelBox[4]+origin.y)*game.zoom
				then enemyDown[i] = 1
			end
		end
		
	end
	
	-- check if hostage is hit
	if levelData[game.level]["hostageBox"] then
		for i=1, #levelData[game.level]["hostageBox"], 1 do
			local sightCoords = sightData[game.sight]["hitPoint"]
			local hostageBox = levelData[game.level]["hostageBox"][i]
			
			-- note that we are multiplying everything that is relative to origin by game.zoom
			-- check x
			if sightCoords[1] > (hostageBox[1]+origin.x)*game.zoom and sightCoords[1] < (hostageBox[3]+origin.x)*game.zoom
				--check y
				then if sightCoords[2] > (hostageBox[2]+origin.y)*game.zoom and sightCoords[2] < (hostageBox[4]+origin.y)*game.zoom
					then hostageDown[i] = 1
				end
			end
			
		end
	end
	-- record shot
	shotsFired = shotsFired+1
end

-- user input function
local function userInput()
	-- left and right keys
	if keyDirect(key.Right)>0 then origin.x=origin.x-(8/game.zoom)
		elseif keyDirect(key.Left)>0 then origin.x=origin.x+(8/game.zoom)
	end
	
	-- up and down keys
	if keyDirect(key.Down)>0 then origin.y=origin.y-(8/game.zoom)
		elseif keyDirect(key.Up)>0 then origin.y=origin.y+(8/game.zoom)
	end
	
	-- fire key
	if keyDirect(key.Shift)>0 then debounce(key.Shift)
		fire() end
	
	-- sight/scope toggle
	if keyDirect(key.Alpha)>0 then debounce(key.Alpha)
		changeSight(game.sight+1) end
	
	-- exit
	if keyDirect(key.Exit)>0 then debounce(key.Exit) exit=1 end
	
	-- workaround to allow screenshots
	if zmg.keyDirect(51)>0 then zmg.keyMenu() end 
	
end

-- about screen
local function about()
	local aboutt={
	'Produced for Cemetech',
	'Contest #9 (2012)',
	'Code released under CC',
	'Share-alike license',
	'',
	'by TakeFlight Prod.',
	'(flyingfisch)',
	'',
	'Press EXE'
	}
	drawRectFill(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, color.bg)
	for i=1, #aboutt, 1 do
		drawText(1,(i*20)-20,aboutt[i],color.fg,color.bg)
	end
	fastCopy()
	waitForKey(key.EXE)
	drawRectFill(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, color.bg)
end

-- loop the whole thing
while exitAll~=1 do
	-- menu
	-- draw background (which, incidentally, clears the screen)
	drawRectFill(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, color.bg)
	keyDirectPoll()
	local blue = 255
	local bluei = -1
	while continue~=1 do
		keyDirectPoll()
		-- display
		drawText(SCREEN_WIDTH-((#game.version*20)+5),1,"v." .. game.version, color.fg, color.bg)
		drawLogo((SCREEN_WIDTH/2)-85,30)
		drawText((SCREEN_WIDTH/2)-135,90,"FIGHTER - Blue Edition",color.fg,color.bg)
		drawText(1,SCREEN_HEIGHT-25,"F1:Campaign F2:Survival F3:About",color.fg,color.bg)
		fastCopy()
		-- keys
		if keyDirect(key.F1)>0 then game.level=1 continue=1 end
		if keyDirect(key.F2)>0 then game.level=100 continue=1 end
		if keyDirect(key.F3)>0 then about() end
		if keyDirect(key.Exit)>0 then continue=1 exitAll=1 end
		-- special effect
		if blue>254 then bluei = -1
			elseif blue<150 then bluei=1
		end
		blue = blue+bluei*4
		color.logo = makeColor(0,0,blue)
	end
	color.logo = color.fg3
	continue = 0
	transition()
	if exitAll==1 then break end
	
	-- game loop
	keyDirectPoll()
	while exit~=1 do
		keyDirectPoll()
		-- userinput
		userInput()
		
		if exit==1 then break end
		
		-- move gun barrel
		gunPhysics()
		
		-- check if origin is out-of-bounds
		if origin.x>levelData[game.level]["max"][1] then origin.x=levelData[game.level]["max"][1]
			elseif origin.x<levelData[game.level]["min"][1] then origin.x=levelData[game.level]["min"][1]
			elseif origin.y>levelData[game.level]["max"][2] then origin.y=levelData[game.level]["max"][2]
			elseif origin.y<levelData[game.level]["min"][2] then origin.y=levelData[game.level]["min"][2]
		end
		
		-- draw background (which, incidentally, clears the screen)
		drawRectFill(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, color.bg)
		
		-- draw horizon
		drawLine(0, (origin.y+levelData[game.level]["horizon"])*game.zoom, SCREEN_WIDTH, (origin.y+levelData[game.level]["horizon"])*game.zoom, color.fg)
		
		-- draw targets
		drawLevel(game.level, origin.x, origin.y)
	
		-- draw sights
		drawSights(game.sight)
		
		-- draw debug info
		drawText(1,1,levelName[game.level],color.fg,color.bg)
		--local levelBox = levelData[game.level]["hitBox"][1]
		--[[drawRectFill((levelBox[1]+origin.x)*game.zoom,
		(levelBox[2]+origin.y)*game.zoom,
		((levelBox[3]+origin.x)*game.zoom)-((levelBox[1]+origin.x)*game.zoom),
		((levelBox[4]+origin.x)*game.zoom)-((levelBox[2]+origin.x)*game.zoom),
		color.alert)]]--
		--drawText(0,20,counter.kick,color.fg,color.bg)
		--drawText(0,40,shotsFired,color.fg,color.bg)
		
		-- refresh the screen
		fastCopy()
	end
	exit=0
	cutscene=1
end
print('')
print('Exiting...')
print('')
print('Program by')
print('TakeFlight Productions (flyingfisch)')
print('http://casio.clrhome.org')
print('')
