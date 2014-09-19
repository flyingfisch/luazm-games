cursor=0
local substring={}
--text drawing stuff
function printText(string, colorfg, colorbg)
	--if string extends past screen end
	if #string>32 then
		--split string into screen width sized portions
		for i=1, math.floor(#string/32)+1, 1 do
			substring[i] = string.sub(string, i, i+32)
		end
	end
	--display
	for i=1, #substring, 1 do
		cursor=i*12-12+cursor
		zmg.drawText(cursor, 0, substring[i], colorfg, colorbg)
	end
	--refresh
	zmg.fastCopy()
end

printText("test", zmg.makeColor("blue"), zmg.makeColor("black"))
print("test")
printText("test2", zmg.makeColor("blue"), zmg.makeColor("black"))
print("test2")
printText("a test string with more than 32 chars a test string with more than 32 chars", zmg.makeColor("blue"), zmg.makeColor("black"))
print("lasttest")

zmg.keyMenu()
