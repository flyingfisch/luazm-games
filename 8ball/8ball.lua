print("Hi, I'm the magic 8 ball!")
--function variables
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

--screen vars
local LCD_SCREEN_WIDTH = 384
local LCD_SCREEN_HEIGHT = 216
local exit = 0

--game variables
local key = {F1=79, F2=69, F3=59, F4=49, F5=39, F6=29, Alpha=77, Exit=47, Optn=68, Up=28, Down=37, Left=38, Right=27}
print("Contacting my sources.")
local answers = {"It is certain","It is decidedly so","Without a doubt","Yes - Definitely","You may rely on it","As I see it, yes","Most likely","Outlook good","Yes","Signs point to yes","Reply hazy, try again","Ask again later","Better not tell you now","Cannot predict now","Concentrate and ask again","Don't count on it","My reply is no","My sources say no","Outlook not so good","Very doubtful"}
local welcome = {"Hey! I'm back, ask a question, press a key, what's bad for you is good for me.","Hey, 'sup? Ask a question, press a key.","Hmm... You look weird. Ask a question, press a key.","Ask a key, press a question. Oh, swap those will ya?","Ask any question, press any key. NOW!"}

--8ball
print("Hi. Ask a question and press a key.")
while exit~=1 do
	--wait for key
	while keyMenuFast()>0 do end
	while not keyMenuFast()>0 do end
	print(answers[math.random(1,20)])
	print("again? (F1: yes, any other key: no)")
	
	while keyMenuFast()>0 do end
	while not keyMenuFast()>0 do key1=keyMenuFast() end
	
	if key1==key.F1 
		then exit=0 
		else exit=1
		print(welcome[random(1,5)]) 
	end
end
print("By TakeFlight Productions (flyingfisch). Bye :-)")




