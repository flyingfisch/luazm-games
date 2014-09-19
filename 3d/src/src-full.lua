local drawLine = zmg.drawLine
local floor = math.floor
local sin = math.sin
local cos = math.cos
local pi = math.pi

local ff3d = {return3dPoint,drawWireframe}

local function d2r(angle)
	return angle*(pi/180)
end

local function ff3d.return3dPoint(point, angle, move, cam, scale, piv, pmode)
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

local function ff3d.drawWireframe(pointData,lineData,colorData)
	for i=1, #lineData, 1 do
		if colorData[i] then Color=colorData[i] else Color=0x0000 end
		drawLine(pointData[lineData[i][1]][1],pointData[lineData[i][1]][2],pointData[lineData[i][2]][1],pointData[lineData[i][2]][2],Color)
	end
end
