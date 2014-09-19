print("starting up...")

--function variables
print("defining function vars as local...")
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

print("Setting first keyDirectPoll point")
keyDirectPoll()

--screen vars
local LCD_SCREEN_WIDTH = 384
local LCD_SCREEN_HEIGHT = 216

--game variables
print("Setting game vars...")
local key = {F1=79, F2=69, F3=59, F4=49, F5=39, F6=29, Alpha=77, Exit=47, Optn=68, Up=28, Down=37, Left=38, Right=27}
local questions = {"How much is 1+1?", "How much is 2+3?"}
local answers = {{"1","2","3","4",2}, {"2","3","4","5",4}}
local level = 1
local speed = 1
local guiColor1 = makeColor("blue")


----Functions----
print("Defining Functions")
function GUI(question)
	drawRectFill(0,0,LCD_SCREEN_WIDTH,20,)
end


----Main Loop----
print("Entering main loop")
while not keyDirect(key.Exit) do
	
end
