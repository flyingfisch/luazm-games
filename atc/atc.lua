-- Copyright (C) 2013  flyingfisch

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program. If not, see <http://www.gnu.org/licenses/>.


local startTime = zmg.ticks()

--[[ VARIABLES ]]--
--function variables
local drawLine = zmg.drawLine
local drawRectFill = zmg.drawRectFill
local drawCircle = zmg.drawCircle
local fastCopy = zmg.fastCopy
local makeColor = zmg.makeColor
local drawPoint = zmg.drawPoint
local keyMenu = zmg.keyMenu
local keyMenuFast = zmg.keyMenuFast
local clear = zmg.clear
local drawText = zmg.drawText
local keyDirectPoll = zmg.keyDirectPoll
local keyDirect = zmg.keyDirect
local floor = math.floor
local random = math.random
local ticks = zmg.ticks
local cos = math.cos
local sin = math.sin
local rad = math.rad
local sqrt = math.sqrt
local abs = math.abs
local remove = table.remove
local insert = table.insert

--screen vars
local SCREEN_WIDTH = 384
local SCREEN_HEIGHT = 216

--game variables
local exit = 0
local key = {f1=79,f2=69,f3=59,f4=49,f5=39,f6=29,shift=78,optn=68,vars=58,menu=48,alpha=77,x2=67,pwr=57,exit=47, up=28,down=37,left=38,right=27,xot=76,log=66,ln=56,sin=46,cos=36,tan=26,abc=75,f2d=65,n1=72,n2=62,n3=52,n4=73,n5=63,n6=53,n7=74,n8=64,n9=54,exe=31}
local color = {bg=makeColor("black"),fg=makeColor("limegreen"),fg2=makeColor(0,100,0),selected=makeColor("white")}
-- speeds in MPH
local classnames = {"prop","bjet","aline"}
local classes = {prop={5,20,170,70,13000},bjet={4,80,600,110,50000},aline={3,40,600,180,40000} --[[ {turnrate, climbrate(fps), topspeed, minspeed, ceiling} ]]}
local aircraft = { --[[ {x, y, angle, speed, altitude, class="class", dest=dest, id=id ]] }
local commands = { --[[ {head, alt, speed} ]]}
local exits = {{"l",54},{"r",54},{"t",108}}
local entries = {{"l",162},{"r",162}}
local airport = {108,108,270}
local selected = 1
local counter = 0
local maxAircraft = 4
local losstypes={"Aircraft too close","Did not exit airspace properly"}
local losstype=0
local game = {version="1.0"}
local laststartpos = 1
local difficulty = 15

--[[ FUNCTIONS ]]--
local function timeElapsedSeconds()
	return floor((ticks()-startTime)/128)
end

local function resetTimer()
	startTime = ticks()
end

local function a2v(a, m)
	a = rad(a)
	m = m or 1
	local y = cos(a)*m
	local x = sin(a)*m
	return x, y
end

local function locate(x, y, string, colorfg, colorbg)
	x = x*12-12
	y = y*18-18
	colorfg = colorfg or color.fg
	colorbg = colorbg or color.bg
	drawText(x, y, string, colorfg, colorbg)
end

local function printText(string, colorfg, colorbg)
	colorfg = colorfg or color.fg
	colorbg = colorbg or color.bg
	local substring={}
	local k=1
	--if string extends past screen end (x)
	if #string>31 then
		--split string into screen width sized portions
		for i=1, math.floor(#string/31)+1, 1 do
			substring[i] = string.sub(string, i*31-30, i*31)
		end
	end
	--display
	for j=1, math.floor(#substring/11)+1, 1 do
		k=1
		--clear screen
		zmg.drawRectFill(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, colorbg)
		for i=j*11-10, j*11, 1 do
			if substring[i] then zmg.drawText(1, k*18-18, substring[i], colorfg, colorbg) end
			k=k+1
		end
		zmg.drawText(1, 198, "Press a key (Page " .. j .. "/" .. math.floor(#substring/11)+1 .. ")", colorbg, colorfg)
		--refresh
		fastCopy()
		--wait
		zmg.keyMenu()
	end
end

local function dispGrid()

	for i=0,17 do
		for j=0,12 do
			drawText(i*12, j*18, ".", color.fg2, color.bg)
		end
	end

	drawText(airport[1],airport[2],"A",color.fg,color.bg)

	for i, j in ipairs(exits) do
		if j[1]=="t" then drawText(j[2],1,"O", color.bg, color.fg2)
			elseif j[1]=="b" then drawText(j[2],204,"O", color.bg, color.fg2)
			elseif j[1]=="l" then drawText(1,j[2],"O", color.bg, color.fg2)
			elseif j[1]=="r" then drawText(204,j[2],"O", color.bg, color.fg2)
		end
	end

	for i, j in ipairs(entries) do
		if j[1]=="t" then drawText(j[2],1,"I", color.bg, color.fg2)
			elseif j[1]=="b" then drawText(j[2],204,"I", color.bg, color.fg2)
			elseif j[1]=="l" then drawText(1,j[2],"I", color.bg, color.fg2)
			elseif j[1]=="r" then drawText(204,j[2],"I", color.bg, color.fg2)
		end
	end

	locate(1,12,counter,color.bg,color.fg)
end

local function dispData(selected)
	locate(20, 1, "ID: " .. aircraft[selected]["id"], color.bg, color.fg)
	locate(20, 2, "Class: " .. aircraft[selected]["class"], color.bg, color.fg)

	locate(20, 3, "Head: " .. commands[selected][1] .. "deg")
	locate(20, 4, "Alt: " .. commands[selected][2] .. "ft")
	locate(20, 5, "Speed: " .. commands[selected][3] .. "mph")

	locate(20, 6, "aHd: " .. aircraft[selected][3] .. "deg")
	locate(20, 7, "aAl: " .. aircraft[selected][5] .. "ft")
	locate(20, 8, "aSp: " .. aircraft[selected][4] .. "mph")

	locate(20, 10, "F1,F2: Head")
	locate(20, 11, "F3,F4: Alt")
	locate(20, 12, "F5,F6: Speed")
end

local function movePlane(plane, num)
	x = plane[1]
	y = plane[2]
	angle = plane[3] % 360
	speed = plane[4]
	alt = plane[5]
	class = plane.class

	if angle~=commands[num][1] then
		if (angle<180 and commands[num][1]>angle and commands[num][1]<(angle+180)) or
		(angle>180 and (commands[num][1]>angle or commands[num][1]<(angle+180)%360)) then
			angle=angle+classes[class][1]
			else
				angle=angle-classes[class][1]
		end
	end

	if abs(angle-commands[num][1])<10 then angle = commands[num][1] end

	if alt~=commands[num][2] then
		if alt > commands[num][2] then
			alt=alt-(classes[class][2]*2)
		elseif alt < commands[num][2] then
			alt=alt+classes[class][2]
		end
	end

	if abs(alt-commands[num][2])<100 then alt = commands[num][2] end

	if speed~=commands[num][3] then
		if speed > commands[num][3] then
			speed=speed-5
		elseif speed < commands[num][3] then
			speed=speed+5
		end
	end

	if abs(speed-commands[num][3])<10 then speed = commands[num][3] end

	dx,dy = a2v(angle, (speed/3600)*12)
	x = x+dx
	y = y-dy

	aircraft[num][1],aircraft[num][2],aircraft[num][3],aircraft[num][4],aircraft[num][5],aircraft[num]["class"] = x,y,angle,speed,alt,class
end

local function dispPlane(plane, colorfg)
	local colorfg = colorfg or color.fg
	local dest = plane.dest
	local x1 = plane[1]
	local y1 = plane[2]
	local angle = plane[3]
	local x2,y2 = a2v(angle, 10)
	x2 = x1+x2
	y2 = y1-y2

	if dest=="a" then dx=airport[1] dy=airport[2]
		elseif exits[dest][1]=="t" then dy=1 dx=exits[dest][2]
		elseif exits[dest][1]=="b" then dy=216 dx=exits[dest][2]
		elseif exits[dest][1]=="l" then dx=1 dy=exits[dest][2]
		elseif exits[dest][1]=="r" then dx=216 dy=exits[dest][2]
	end

	drawLine(x1, y1, dx+8, dy+8, color.fg2)
	drawRectFill(x1-2, y1-2, 4, 4, colorfg)
	drawLine(x1, y1, x2, y2, colorfg)

	drawCircle(x1,y1,36,color.fg2)

	-- clear data screen
	drawRectFill(220, 0, 216, SCREEN_HEIGHT, color.bg)
end

local function detectCollision(plane1, plane2) 
	local r
	x1 = plane1[1]
	y1 = plane1[2]
	alt1 = plane1[5]

	x2 = plane2[1]
	y2 = plane2[2]
	alt2 = plane2[5]

	-- distance in pixels for simplicity. 12px == 1mi
	if sqrt( abs( ((y1-y2)^2) + ((x1-x2)^2) ) ) < 36 and abs(alt1-alt2) < 1000 then
		r = 1
		else r = nil
	end

	return r
end

local function leaveAirspace(planeindex)
	local ok=0
	local dest=exits[ aircraft[planeindex]["dest"] ]
	if (dest[1]=="t" and sqrt(abs(((1-aircraft[planeindex][2])^2)+((dest[2]-aircraft[planeindex][1])^2)))<36) or
		(dest[1]=="b" and sqrt(abs(((204-aircraft[planeindex][2])^2)+((dest[2]-aircraft[planeindex][1])^2)))<36) or
		(dest[1]=="l" and sqrt(abs(((dest[2]-aircraft[planeindex][2])^2)+((1-aircraft[planeindex][1])^2)))<36) or
		(dest[1]=="r" and sqrt(abs(((dest[2]-aircraft[planeindex][2])^2)+((204-aircraft[planeindex][1])^2)))<36)
		then
			ok=1
	end

	if aircraft[planeindex][5]<5000 then ok=0 end

	if ok==1 then remove(aircraft,planeindex) remove(commands,planeindex) end

	selected=1

	if ok==0 then losstype=2 end
end

local function checkLanding(plane,planeindex)
	airport[5]=0
	if detectCollision(plane,airport) and plane.dest=="a" and plane[4]<200 then
		remove(aircraft,planeindex) remove(commands,planeindex)
		selected=1
	end
end

local function generateAircraft()
	if counter % (60-difficulty)==0 then
		local class = classnames[random(1,#classnames)]
		local start
		local startx,starty,startd
		local id = "N" .. random(0,9) .. random(0,9) .. random(0,9) .. random(0,9)
		local alt = 7000
		local speed = classes[class][3]
		local dest = random(1,#exits)

		while 1 do
			start = random(1,#entries)
			if start~=laststartpos then break end
		end

		if entries[start][1]=="t" then starty=1 startx=entries[start][2] startd=180
			elseif entries[start][1]=="b" then starty=216 startx=entries[start][2] startd=0
			elseif entries[start][1]=="l" then startx=1 starty=entries[start][2] startd=90
			elseif entries[start][1]=="r" then startx=216 starty=entries[start][2] startd=270
		end

		while 1 do
			dest = random(1,#exits)
			if entries[start][1]~=exits[dest][1] then break end
		end

		if random(1,2)==1 and laststartpos~="a" then start="a" startx=airport[1] starty=airport[2] alt=400 speed=classes[class][3]/2 startd=airport[3] end
		
		if random(1,2)==1 and start~="a" then dest="a" end

		aircraft[#aircraft+1] = {startx,starty,startd,speed,alt,class=class,dest=dest,id=id}
		commands[#aircraft] = {}
		commands[#aircraft][1],commands[#aircraft][2],commands[#aircraft][3] = aircraft[#aircraft][3],aircraft[#aircraft][5],aircraft[#aircraft][4]
		
		laststartpos = start
	end
end

local function userInput()
	local selectedclass = aircraft[selected]["class"]
	-- selection
	if keyDirect(key.right)>0 then
		selected = selected+1
		if selected>#aircraft then selected = 1 end
		-- debounce
		while keyDirect(key.right)>0 do keyDirectPoll() end
		dispPlane(aircraft[selected], color.selected)
	end

	if keyDirect(key.left)>0 then
		selected = selected-1
		if selected<1 then selected = #aircraft end
		-- debounce
		while keyDirect(key.left)>0 do keyDirectPoll() end
		dispPlane(aircraft[selected], color.selected)
	end

	-- commands
	if keyDirect(key.f2)>0 and commands[selected][1] then commands[selected][1]=commands[selected][1]+10
		elseif keyDirect(key.f1)>0 and commands[selected][1] then commands[selected][1]=commands[selected][1]-10
	end

	commands[selected][1]=commands[selected][1] % 360

	if keyDirect(key.f4)>0 and commands[selected][2]<classes[selectedclass][5] then commands[selected][2]=commands[selected][2]+100
		elseif keyDirect(key.f3)>0 and commands[selected][2]>400 then commands[selected][2]=commands[selected][2]-100
	end

	if keyDirect(key.f6)>0 and commands[selected][3]<classes[selectedclass][3] then commands[selected][3]=commands[selected][3]+10
		elseif keyDirect(key.f5)>0 and commands[selected][3]>classes[selectedclass][4] then commands[selected][3]=commands[selected][3]-10
	end

	-- exit
	if keyDirect(key.exit)>0 then exit=1 end
end

local function help()
	local helptext = "Nerves of Steel                [Keys]                         F1: Turn left                  F2: Turn right                 F3: Alt-                       F4: Alt+                       F5: Speed-                     F6: Speed+                     Arrows: Select plane           [Rules]                        All planes must reach their    destination without leaving theairspace.                      All planes must stay 1000ft and3mi away from each other.      Exiting planes must leave      airspace at more than 5000ft   Landing planes must fly into   airport's airspace at less than200mph and 1000ft. Airport ATC will take over at that point.  There is no winning state, justtry to outlast your previous   attempt.                       [Credits]                      flyingfisch                    TakeFlight Prod.               "
	printText(helptext)
end

local function menu()
	local continue=0
	while continue~=1 do
		drawRectFill(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, color.bg)
		locate(1,1,"Nerves of Steel")
		locate(1,3,"F1: Play")
		locate(1,4,"F2: Help")

		locate(1,6,"Difficulty:")
		locate(1,8,"Easy")
		locate(27,8,"Hard")

		drawLine(10,110,10,120,color.fg2)
		drawLine(SCREEN_WIDTH-10,110,SCREEN_WIDTH-10,120,color.fg2)
		drawLine(10,115,SCREEN_WIDTH-10,115,color.fg2)
		drawRectFill(10,112,((SCREEN_WIDTH-20)/30)*difficulty,8,color.fg)

		fastCopy()
	
		if keyMenuFast()==key.f1 then continue=1 end
		if keyMenuFast()==key.f2 then help() end
		if keyMenuFast()==key.left and difficulty>0 then difficulty=difficulty-1 end
		if keyMenuFast()==key.right and difficulty<30 then difficulty=difficulty+1 end
		random() --randomize the pseudo random generator
	end
end

--[[ MAIN LOOP ]]--
while exit~=1 do
	-- display menu
	menu()

	while exit~=1 do
		keyDirectPoll()
		-- clear screen
		drawRectFill(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, color.bg)

		-- display grid
		dispGrid()

		-- generate planes
		generateAircraft()

		-- aircraft stuff
		for i, j in ipairs(aircraft) do
			-- move
			movePlane(j,i)
			-- check for collisions
			for k, l in ipairs(aircraft) do
				if k~=i then
					if detectCollision(j, l) == 1 then
						losstype=1
						-- display the planes that have collided
						color.fg = makeColor("red")
						dispPlane(j)
						dispPlane(l)
						color.fg = makeColor("limegreen")
						break
					end
				end
			end
			-- display
			if selected==i then dispPlane(j,color.selected)
				else dispPlane(j)
			end
			-- if plane has left airspace, remove it
			if j[1] > 216 or j[1] < 0 then leaveAirspace(i) end
			if j[2] > 216 or j[2] < 0 then leaveAirspace(i) end
			-- if plane is landing, let ground takeover
			checkLanding(j,i)
		end

		-- get user input
		keyDirectPoll()
		userInput()

		-- display data for selected plane
		dispData(selected)

		-- refresh screen
		fastCopy()

		-- wait until 1 second is up
		while timeElapsedSeconds()<1 do
			-- clear data screen
			drawRectFill(220, 0, 216, SCREEN_HEIGHT, color.bg)

			keyMenuFast()

			-- get user input
			keyDirectPoll()
			userInput()

			-- display data for selected plane
			dispData(selected)

			-- refresh screen
			fastCopy()
		end

		-- reset timer
		resetTimer()
		counter = counter+1
		keyMenuFast()

		if losstype>0 then exit=1 end
	end
end
if losstype>0 then 
	color.fg = makeColor("red")
	locate(1,1,losstypes[losstype],color.bg,color.fg)
	exit=1
	fastCopy()
	while timeElapsedSeconds()<3 do
		keyMenuFast()
	end
end

