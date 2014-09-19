-- base functions
local clear = zmg.clear
local drawCircle = zmg.drawCircle
local drawLine = zmg.drawLine
local drawPoint = zmg.drawPoint
local drawRectFill = zmg.drawRectFill
local drawText = zmg.drawText
local fastCopy = zmg.fastCopy
local keyMenuFast = zmg.keyMenuFast
local keyDirectPoll = zmg.keyDirectPoll
local keyDirect = zmg.keyDirect
local makeColor = zmg.makeColor
local floor = math.floor
local sin = math.sin
local cos = math.cos
local pi = math.pi

-- screen vars
local SCREEN_WIDTH = 384
local SCREEN_HEIGHT = 216


-- major vars
local key = {f1=79,f2=69,f3=59,f4=49,f5=39,f6=29,alpha=77,exit=47, 
optn=68,up=28,down=37,left=38,right=27,exe=31,shift=78,n1=72,n2=62,n3=52,
n4=73,n5=63,n6=53,n7=74,n8=64,n9=54}
local color = {bg=makeColor("white"), fg=makeColor("gray")}
local exit=0

-- 3d vars
local move = {x=SCREEN_WIDTH/2, y=SCREEN_HEIGHT/2, z=50} 
local piv = {x=0, y=0, z=0}
local ang = {x=180, y=0, z=0}
local roffset = {x=0, y=0, z=0}
local cam = {x=0, y=0, z=300}
local coords = {}
local x = 0
local y = 0
local scale = 1
local pmode = 0
local dmode = 0
local old = {x,y}

-- 3d arrays
local size = 50
--[[
local cube = {x,y,z,lines}
cube.x = {size, size, size, size, -size, -size, -size, -size}
cube.y = {size, size, -size, -size, size, size, -size, -size}
cube.z = {-size, size, -size, size, -size, size, -size, size}
cube.lines = {}
--]]
local red = makeColor("red")
local blue = makeColor("blue")
local triangle = {x,y,z,lines}
triangle.x = {size,0,-size,0,0}
triangle.y = {0,-size,0,size,0}
triangle.z = {0,0,0,0,size}
triangle.lines = {{1,2},{2,3},{3,4},{4,1},{1,5},{2,5},{3,5},{4,5}}
triangle.colors = {red,red,red,red,blue,blue,blue,blue}

-- functions
local function d2r(angle)
	return angle*(pi/180)
end

local function debounce(key)
	while keyDirect(key)>0 do keyDirectPoll() end
end

local function drawCrosshair(x, y, size, color)
	drawLine(x-size, y, x+size, y, color)
	drawLine(x, y-size, x, y+size, color)
end

local function return3dPoint(point, angle, move, cam, scale, piv, pmode)
	xd = point.x-piv.x
	yd = point.y-piv.y
	zd = point.z-piv.z
	
	zx = xd*cos(d2r(angle.z)) - yd*sin(d2r(angle.z)) - xd
	zy = xd*sin(d2r(angle.z)) + yd*cos(d2r(angle.z)) - yd
	
	yx = (xd+zx)*cos(d2r(angle.y)) - zd*sin(d2r(angle.y)) - (xd+zx)
	yz = (yd+zy)*sin(d2r(angle.y)) + zd*cos(d2r(angle.y)) - zd
	
	xy = (yd+zy)*cos(d2r(angle.x)) - (zd+yz)*sin(d2r(angle.x)) - (yd+zy)
	xz = (yd+zy)*sin(d2r(angle.x)) + (zd+yz)*cos(d2r(angle.x)) - (zd+yz)
	
	offset = {}
	
	offset.x = yx+zx
	offset.y = zy+xy
	offset.z = xz+yz
	
	if pmode==0 then
		x = (point.x + offset.x + cam.x) / scale + move.x
		y = (point.y + offset.y + cam.y) / scale + move.y
	else
		z = (point.z + offset.z + cam.z)
		x = (point.x + offset.x + cam.x) / z / scale + move.x
		y = (point.y + offset.y + cam.y) / z / scale + move.y
	end
	
	return {x,y}
end

local function drawWireframe(pointData,lineData,colorData)
	for i=1, #lineData, 1 do
		if colorData[i] then Color=colorData[i] else Color=0x0000 end
		drawLine(pointData[lineData[i][1]][1],pointData[lineData[i][1]][2],pointData[lineData[i][2]][1],pointData[lineData[i][2]][2],Color)
	end
end

-- 3d
while exit~=1 do
	keyDirectPoll()
	clear()
	
	for i=1, #triangle.x, 1 do
		coords[i] = return3dPoint({x=triangle.x[i],y=triangle.y[i],z=triangle.z[i]},ang,move,cam,scale,piv,pmode)
	end
	
	drawWireframe(coords,triangle.lines,triangle.colors)
	
	if keyDirect(key.left)>0 then move.x = move.x-2 end
	if keyDirect(key.right)>0 then move.x = move.x+2 end
	if keyDirect(key.up)>0 then move.y = move.y-2 end
	if keyDirect(key.down)>0 then move.y = move.y+2 end
	if keyDirect(key.f1)>0 then scale = scale*1.02 end
	if keyDirect(key.f2)>0 then scale = scale/1.02 end
	if keyDirect(key.f3)>0 then ang.z = ang.z-4 end
	if keyDirect(key.f4)>0 then ang.z = ang.z+4 end
	if keyDirect(key.f5)>0 then ang.x = ang.x-4 end
	if keyDirect(key.f6)>0 then ang.x = ang.x+4 end
	if keyDirect(key.n4)>0 then cam.x = cam.x-4 end
	if keyDirect(key.n6)>0 then cam.x = cam.x+4 end
	if keyDirect(key.n8)>0 then cam.y = cam.y-4 end
	if keyDirect(key.n2)>0 then cam.y = cam.y+4 end
	
	if keyDirect(key.optn)>0 then debounce(key.optn)
		if pmode==0 then pmode=1 scale=scale/cam.z else pmode=0 scale=scale*cam.z end
	end
	if keyDirect(key.shift)>0 then debounce(key.shift)
		if dmode==0 then dmode=1 else dmode=0 end
	end
	if keyDirect(key.exit)>0 then exit=1 end
	
	
	drawText(1, 1, "ff3d lib demo", color.fg, color.bg)
	
	fastCopy()
end
