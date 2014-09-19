-- flyingfisch's graphics lib

ffgfx={}

function ffgfx.drawSpritePalette( data, x, y, width, height, palette, res )
	local res=res or 1
	local k=1

	for i=1,height do
		for j=1,width do
			if palette[string.sub(data,k,k)+1]~=0 then
				zmg.drawRectFill(x+(j-1)*res, y+(i-1)*res, res, res, palette[string.sub(data,k,k)+1])
			end
			k=k+1
		end
	end
end