zmg.clear()

iter=100
esclim=2.0
ulx=-2.0
uly=1.0
lrx=1.0
lry=-1.0
SCREEN_WIDTH = 384
SCREEN_HEIGHT = 216
width=384
height=216
tilesizey=SCREEN_HEIGHT/height
tilesizex=SCREEN_WIDTH/width

function drawFracLine( line, y )
    for i=1,#line,1 do
        if string.sub(line,i,i)=="#" then 
            zmg.drawRectFill((i*tilesizex)-tilesizex,(y*tilesizey)-tilesizey,tilesizex,tilesizey,zmg.makeColor("black")) 
        end
    end
end

function abs(x,y)
    return math.sqrt(x*x+y*y)
end

function escapeq(cx,cy)
    local zx=0.0
    local zy=0.0
    local i=0

    while i<iter and abs(zx,zy)<esclim do
        tmp=zx*zx-zy*zy
        zy=2.0*zx*zy
        zx=tmp

        zx=zx+cx
        zy=zy+cy
        i=i+1
    end

    return i<iter
end

for y=1,height do
    line=''
    for x=1,width do
        zx=ulx+(lrx-ulx)/width*x;
        zy=uly+(lry-uly)/height*y;
        if escapeq(zx,zy) then
            line=line..'.'
        else
            line=line..'#'
        end
    end
    drawFracLine(line, y)
    --print(line)
end
zmg.fastCopy()
zmg.keyMenu()