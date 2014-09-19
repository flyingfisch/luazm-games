local drawLine = zmg.drawLine
local makeColor = zmg.makeColor
local sin = math.sin
local cos = math.cos
local fastCopy = zmg.fastCopy

local drawCircleFilled = function(x, y, radius, color)
	for i=1, 360, 1 do
		drawLine(x, y, radius*cos(i)*i, radius*sin(i)*i, color)
	end
end

drawCircleFilled(100, 100, 50, makeColor("blue"))
fastCopy()
