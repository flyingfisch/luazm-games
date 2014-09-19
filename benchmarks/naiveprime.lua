local start = zmg.ticks()
n=100
for k=3,n do
	for j=2,k-1 do
		if k%j==0 then j=k-1 end
	end
end

print('n=100: ' .. (zmg.ticks()-start)/128 .. 'sec')

local start = zmg.ticks()
n=1000
for k=3,n do
	for j=2,k-1 do
		if k%j==0 then j=k-1 end
	end
end

print('n=1000: ' .. (zmg.ticks()-start)/128 .. 'sec')