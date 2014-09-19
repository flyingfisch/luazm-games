zmg.keyDirectPoll()
for i=1,100000000000 do
	zmg.keyDirectPoll()
	if zmg.keyDirect(10)>0 then print(i) break end
end