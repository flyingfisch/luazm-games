--function variables
local clear         = zmg.clear
local drawPoint     = zmg.drawPoint
local drawRect      = zmg.drawRect
local drawRectFill  = zmg.drawRectFill
local drawText      = zmg.drawText
local fastCopy      = zmg.fastCopy
local keyDirectPoll = zmg.keyDirectPoll
local keyDirect     = zmg.keyDirect
local keyMenuFast   = zmg.keyMenuFast
local keyMenu       = zmg.keyMenu
local makeColor     = zmg.makeColor
local floor         = math.floor
local random        = math.random

--screen vars
local SCREEN_WIDTH  = 384
local SCREEN_HEIGHT = 216

-- game variables
local key = {f1=79,f2=69,f3=59,f4=49,f5=39,f6=29,shift=78,optn=68,vars=58,menu=48,alpha=77,x2=67,pwr=57,exit=47, up=28,down=37,left=38,right=27,xot=76,log=66,ln=56,sin=46,cos=36,tan=26,abc=75,f2d=65,n1=72,n2=62,n3=52,n4=73,n5=63,n6=53,n7=74,n8=64,n9=54,exe=31}
local color = {fg=makeColor("white"),bg=makeColor("black")}

-- control vars
local exit = false

-- word lists
local wordlist = {
	{"test","sitting","flying","cattle"}
}

-- other vars
local list,word,letters_tried

--[[ FUNCTIONS ]]
local function setup()
	list          = random(1,#wordlist)
	word          = wordlist[list][random(1,#wordlist[list])]
	letters_tried = {}
end

local function dispWord(x,y,letters_tried)
	local string = ""
	local skip   = 0

	for i=1, #word do
		for i, str in ipairs(letters_tried) do
			if word[i]==str then
				string[i]=str
				skip=1
			end
		end

		if skip==0 then
			string[i]="_"
		end
	end

	drawText(x,y,string,color.fg,color.bg)
end


--[[ MAIN PROGRAM ]]
setup()

print(list)
print(word)

while not exit do
	-- clear screen
	drawRectFill(0,0,SCREEN_WIDTH,SCREEN_HEIGHT,color.bg)

	dispWord(1,1,letters_tried)



	-- getkey
	keyMenu()
end