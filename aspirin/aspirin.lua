--[[
   aspirin.lua
   
   Copyright 2013 flyingfisch (casio.clrhome.org)
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.
   
   
]]--

print("starting aspirin...")
--function variables
local drawRectFill = zmg.drawRectFill
local drawCircle = zmg.drawCircle
local fastCopy = zmg.fastCopy
local makeColor = zmg.makeColor
local drawPoint = zmg.drawPoint
local drawLine = zmg.drawLine
local clear = zmg.clear
local drawText = zmg.drawText
local keyDirectPoll = zmg.keyDirectPoll
local keyDirect = zmg.keyDirect
local floor = math.floor
local random = math.random
local keyMenuFast = zmg.keyMenuFast

--variables
local key = {F1=79, F2=69, F3=59, F4=49, F5=39, F6=29, Alpha=77, Exit=47, Optn=68, Up=28, Down=37, Left=38, Right=27, EXE=31}
local colorscheme= {
{bg=makeColor("black"),fg=makeColor("blue"),fg2=makeColor("red"),line=makeColor("lightblue")},
{bg=makeColor("black"),fg=makeColor("hotpink"),fg2=makeColor("violet"),line=makeColor("magenta")},
{bg=makeColor("black"),fg=makeColor("limegreen"),fg2=makeColor("blue"),line=makeColor("lightblue")},
{bg=makeColor("white"),fg=makeColor("black"),fg2=makeColor("red"),line=makeColor("blue")},
{bg=makeColor("purple"),fg=makeColor("hotpink"),fg2=makeColor("white"),line=makeColor("magenta")}
}
local color = {bg=makeColor("black"),fg=makeColor("blue"),fg2=makeColor("red"),line=makeColor("lightblue")}
--lines={{x1,y1,direction(-1,1),direction(0=horiz,1=vert)},{...}}
local lines={}
local player={x=384/2,y=216/2,size=5,speed=2}
local target={x=384/2,y=216/4,size=10}
local linewidth=20
local linespeed=2
local statbarsize=22
local exit=0
local exitall=0
local menu=1

local score=0
local highscore=0

--vars for menu
local linex=1
local lined=1
local scheme=1

--screen vars
local SCREEN_WIDTH = 384
local SCREEN_HEIGHT = 216

--game loop
keyDirectPoll()
while exitall~=1 do
	--menu
	while menu==1 do
		exit=0
		--clear screen
		drawRectFill(0,0,SCREEN_WIDTH,SCREEN_HEIGHT,color.bg)
		
		keyDirectPoll()
		
		drawText(1,1,"Aspirin, by flyingfisch",color.fg2,color.bg)
		drawText(1,40,"OPTN to change color scheme",color.fg2,color.bg)
		drawText(1,60,"EXE to start game",color.fg2,color.bg)

		--draw sample game elements
		drawCircle(50,100,player.size,color.fg)
		drawCircle(170,150,target.size,color.fg2)
		drawLine(linex,120,linex+linewidth,120,color.line)
		
		--reverse movement if hit side of screen
		if linex>SCREEN_WIDTH-linewidth then
			lined=-1 
			elseif linex<0 then 
			lined=1 
		end
		
		--move line
		linex = linex+lined*linespeed
		
		--colorscheme
		if keyDirect(key.Optn)>0 then 
			if scheme<#colorscheme then 
				scheme=scheme+1
				else 
				scheme=1
			end 
			color=colorscheme[scheme]
			--kill two birds with one stone: debounce, and make the pseudo-random numbers more random.
			while keyDirect(key.Optn)>0 do
				math.random()
				keyDirectPoll()
			end
		end
		
		--keys
		if keyDirect(key.EXE)>0 then menu=0 end
		if keyDirect(key.Exit)>0 then menu=0 exitall=1 end
		
		--refresh screen
		fastCopy()
	end
	
	--game loop
	while exit~=1 do
		
		--workaround to allow screenshots
		if keyDirect(key.Optn)>0 then zmg.keyMenu() end
		
		--clear screen
		drawRectFill(0,0,SCREEN_WIDTH,SCREEN_HEIGHT,color.bg)
		
		
		--keys
		if keyDirect(key.Left)>0 and player.x>0 then player.x=player.x-player.speed 
			elseif keyDirect(key.Right)>0 and player.x<SCREEN_WIDTH then player.x=player.x+player.speed
		end
		if keyDirect(key.Up)>0 and player.y>statbarsize then player.y=player.y-player.speed
			elseif keyDirect(key.Down)>0 and player.y<SCREEN_HEIGHT then player.y=player.y+player.speed
		end
		
		--calculations
		--check collision with target
		if player.x-player.size<target.x+target.size and player.x+player.size>target.x-target.size
			and player.y-player.size<target.y+target.size and player.y+player.size>target.y-target.size then
			target.x=random(statbarsize,SCREEN_WIDTH)
			target.y=random(statbarsize,SCREEN_HEIGHT)
			score=score+100
			-- create lines
			if player.y>SCREEN_HEIGHT/2 then
				lines[#lines+1]={random(0,SCREEN_WIDTH/2),random(statbarsize+1,SCREEN_HEIGHT/2-player.size),1,0}
				else
				lines[#lines+1]={random(0,SCREEN_WIDTH/2),random(SCREEN_HEIGHT/2+player.size,SCREEN_HEIGHT),1,0}
			end
			
			if player.x>SCREEN_WIDTH/2 then
				lines[#lines+1]={random(0,SCREEN_WIDTH/2-player.size),random(statbarsize+1,SCREEN_HEIGHT/2),1,1}
				else
				lines[#lines+1]={random(SCREEN_WIDTH/2+player.size,SCREEN_WIDTH),random(statbarsize,SCREEN_HEIGHT/2),1,1}
				fastCopy()
			end
			
			--workaround to improve framerate
			if player.speed<6 then
				linespeed = math.floor(#lines/20+2)
				player.speed = math.floor(#lines/20+2)
			end
		end
		
		--lines
		for i=1,#lines,1 do
			--if horizontal
			if lines[i][4]==0 then
				--reverse direction if hit edge
				if lines[i][1]>SCREEN_WIDTH-linewidth or lines[i][1]<0 then
					lines[i][3]=lines[i][3]*-1
				end
				--check collisions
				if lines[i][1]+linewidth>player.x-player.size and lines[i][1]<player.x+player.size
					and lines[i][2]>player.y-player.size and lines[i][2]<player.y+player.size then
					exit=1
				end
				--move it along
				lines[i][1]=lines[i][1]+linespeed*lines[i][3]
				--draw it
				drawLine(lines[i][1],lines[i][2],lines[i][1]+linewidth,lines[i][2],color.line)
			end
			
			--if vertical
			if lines[i][4]==1 then
				--reverse direction if hit edge
				if lines[i][2]>SCREEN_HEIGHT-linewidth or lines[i][2]<statbarsize then
					lines[i][3]=lines[i][3]*-1
				end
				--check collisions
				if lines[i][2]+linewidth>player.y-player.size and lines[i][2]<player.y+player.size
					and lines[i][1]>player.x-player.size and lines[i][1]<player.x+player.size then
					exit=1
				end
				--move it along
				lines[i][2]=lines[i][2]+linespeed*lines[i][3]
				--draw it
				drawLine(lines[i][1],lines[i][2],lines[i][1],lines[i][2]+linewidth,color.line)
			end
		end
		
		keyDirectPoll()
		
		--display
		drawCircle(player.x,player.y,player.size,color.fg)
		drawCircle(target.x,target.y,target.size,color.fg2)
		--display statbar
		drawRectFill(0,0,SCREEN_WIDTH,statbarsize,color.bg)
		drawLine(0,statbarsize,SCREEN_WIDTH,statbarsize,color.fg)
		--display score
		drawText(1,1,"SCORE: " .. score,color.fg2,color.bg)
		fastCopy()
		
		keyDirectPoll()
	end
	
	--[[ death screen ]]--
	keyDirectPoll()
	--clear screen
	drawRectFill(0,0,SCREEN_WIDTH,SCREEN_HEIGHT,color.bg)
	
	--high scores
	if score>highscore then highscore=score end
	--draw text
	drawText(1,1,"GAME OVER",color.fg2,color.bg)
	drawText(1,20,"SCORE: " .. score,color.fg2,color.bg)
	drawText(1,40,"SESSION HIGH SCORE: " .. highscore,color.fg2,color.bg)
	drawText(1,60,"ALL-TIME HIGH SCORE: COMING SOON",color.fg2,color.bg)
	drawText(1,80,"F1: Play again",color.fg2,color.bg)
	drawText(1,100,"F6: Exit",color.fg2,color.bg)
	
	fastCopy()
	
	if keyDirect(key.F1)>0 then 
		--reset stuff
		exit=0
		lines={}
		player={x=384/2,y=216/2,size=5,speed=2}
		target={x=384/2,y=216/4,size=10}
		linewidth=20
		linespeed=2
		score=0
		
		elseif keyDirect(key.F6)>0 or keyDirect(key.Exit)>0 then exitall=1
	end
end
print("quitting")
