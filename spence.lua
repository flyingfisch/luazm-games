a = 1
level = 1
levelreached = 1
moves = 0
totalmoves = 0
game = false
finished = false
	alpha = 384
	levelreached = 1
	scroll = 90
	alpha = 384
	leftscroll = false
	rightscroll = false
	--tile = {0,4,5,10,20,6,14,0}
	tile = {0,84,6,94,21,92,15,82}
	tilechange = {0,84,6,94,21,92,15,82}
	tilesel = {0,42,3,47,10,46,7,41}
	tilechangesel = {0,42,3,47,10,46,7,41}
floormap = {
	--level 1
	{{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{1,1,1,0,0,0,0,0,0,0,0,0,0,0,0},
	{1,1,1,1,1,1,0,0,0,0,0,0,0,0,0},
	{1,1,1,1,1,1,1,1,1,0,0,0,0,0,0},
	{0,1,1,1,1,1,1,1,1,1,0,0,0,0,0},
	{0,0,0,0,0,1,1,2,1,1,0,0,0,0,0},
	{0,0,0,0,0,0,1,1,1,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{8,7},1,{1,1,1,1,1,1,1},{2,4,2,4}},
	--level 2
	{{0,0,0,0,0,0,1,1,1,1,0,0,1,1,1},
	{1,1,1,1,0,0,1,1,4,1,0,0,1,2,1},
	{1,1,3,1,0,0,1,1,1,1,0,0,1,1,1},
	{1,1,1,1,0,0,1,1,1,1,0,0,1,1,1},
	{1,1,1,1,0,0,1,1,1,1,0,0,1,1,1},
	{1,1,1,1,0,0,1,1,1,1,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{14,2},2,{3,3,2,5,5,5,6,1},{9,2,2,5,11,5,12,1},{2,5,2,5}},
	--level 3
	{{0,0,0,0,0,0,1,1,1,1,1,1,1,0,0},
	{1,1,1,1,0,0,1,1,1,0,0,1,1,0,0},
	{1,1,1,1,1,1,1,1,1,0,0,1,1,1,1},
	{1,1,1,1,0,0,0,0,0,0,0,1,1,2,1},
	{1,1,1,1,0,0,0,0,0,0,0,1,1,1,1},
	{0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{14,4},1,{1,1,1,1,1,1,1,1},{2,4,2,4}},
	--level 4
	{{0,0,0,5,5,5,5,5,5,5,0,0,0,0,0},
	{0,0,0,5,5,5,5,5,5,5,0,0,0,0,0},
	{1,1,1,1,0,0,0,0,0,1,1,1,0,0,0},
	{1,1,1,0,0,0,0,0,0,0,1,1,0,0,0},
	{1,1,1,0,0,0,0,0,0,0,1,1,0,0,0},
	{1,1,1,0,0,1,1,1,1,5,5,5,5,5,0},
	{1,1,1,0,0,1,1,1,1,5,5,5,5,5,0},
	{0,0,0,0,0,1,2,1,0,0,5,5,1,5,0},
	{0,0,0,0,0,1,1,1,0,0,5,5,5,5,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{7,8},1,{1,1,1,1,1,1,1,1},{2,6,2,6}},
	--level 5
	{{0,0,0,0,0,0,0,0,0,0,0,1,1,1,1},
	{0,1,1,1,1,1,1,1,3,1,1,1,1,1,1},
	{0,1,1,1,1,0,0,0,0,0,0,0,1,1,1},
	{0,1,1,3,1,0,0,0,0,0,0,0,0,0,0},
	{0,1,1,1,1,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,1,1,1,3,1,1,1,1,1,1,0,0},
	{0,0,0,0,0,0,0,0,0,0,1,1,1,1,3},
	{1,1,1,0,0,0,0,0,0,0,1,1,1,1,1},
	{1,2,1,1,1,1,1,1,1,1,1,1,1,0,0},
	{1,1,1,1,0,0,0,0,0,0,0,0,0,0,0},
	{2,9},4,{9,2,2,2,6,2,7,2},{4,4,2,9,6,9,7,1},{7,6,2,9,6,9,7,0},{15,7,2,9,6,9,7,2},{14,2,14,2}},
	--level 6
	{{0,0,0,0,0,1,1,1,1,1,1,0,0,0,0},
	{0,0,0,0,0,1,0,0,1,1,1,0,0,0,0},
	{0,0,0,0,0,1,0,0,1,1,1,1,1,0,0},
	{1,1,1,1,1,1,0,0,0,0,0,1,1,1,1},
	{0,0,0,0,1,1,1,0,0,0,0,1,1,2,1},
	{0,0,0,0,1,1,1,0,0,0,0,0,1,1,1},
	{0,0,0,0,0,0,1,0,0,1,1,0,0,0,0},
	{0,0,0,0,0,0,1,1,1,1,1,0,0,0,0},
	{0,0,0,0,0,0,1,1,1,1,1,0,0,0,0},
	{0,0,0,0,0,0,0,1,1,1,0,0,0,0,0},
	{14,5},1,{1,1,1,1,1,1,1,1},{1,4,1,4}},
	--level 7
	{{0,0,0,0,0,0,0,0,1,1,1,1,0,0,0},
	{0,0,0,0,0,0,0,0,1,1,1,1,0,0,0},
	{1,1,1,0,0,0,0,0,1,0,0,1,1,1,1},
	{1,1,1,1,1,1,1,1,1,0,0,0,1,2,1},
	{1,1,1,0,0,0,0,1,1,4,0,0,1,1,1},
	{1,1,1,0,0,0,0,1,1,1,0,0,1,1,1},
	{0,1,1,0,0,0,0,1,0,0,0,0,0,0,0},
	{0,0,1,1,1,1,1,1,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{14,4},1,{10,5,1,7,4,1},{2,4,2,4}},
	--level 8
	{{0,0,1,1,1,1,0,0,0,0,0,0,0,0,0},
	{0,0,1,2,1,1,0,0,0,0,0,0,0,0,0},
	{0,0,1,1,1,0,0,0,0,0,0,0,0,0,0},
	{0,0,1,0,0,0,1,1,1,1,1,1,0,0,0},
	{0,0,1,0,0,0,1,1,0,0,1,1,0,0,0},
	{0,1,1,1,1,1,1,1,0,0,1,1,1,0,0},
	{0,0,0,0,0,0,1,3,0,0,0,0,1,0,0},
	{0,0,0,0,0,0,1,1,1,1,0,0,1,0,0},
	{0,0,0,0,0,0,1,1,1,1,1,1,1,0,0},
	{0,0,0,0,0,0,0,0,0,1,1,1,0,0,0},
	{4,2},1,{8,7,2,1,6,2,6,0},{2,6,2,6}},
	--level 9
	{{0,0,0,0,0,0,0,0,0,0,0,0,0,4,0},
	{0,0,0,0,0,0,1,1,1,0,0,1,1,1,0},
	{0,0,0,0,0,0,1,4,1,1,1,1,1,0,0},
	{0,0,0,0,1,1,1,1,1,0,0,1,1,0,0},
	{0,0,0,0,1,2,1,0,0,0,0,1,1,0,0},
	{0,1,1,1,1,1,1,0,0,0,1,1,1,1,0},
	{0,1,1,1,1,0,0,0,0,0,1,1,1,1,0},
	{0,1,1,1,1,0,0,1,1,1,1,1,0,0,0},
	{0,0,0,0,0,0,1,1,1,0,0,0,0,0,0},
	{0,0,0,0,0,0,1,1,1,0,0,0,0,0,0},
	{6,5},2,{14,1,1,5,8,1,2},{8,3,1,3,14,1,2},{4,7,4,7}},
	--level 10
	{{1,1,1,5,1,1,1,1,5,1,1,1,1,0,0},
	{1,1,0,0,0,0,0,0,0,0,1,1,1,0,0},
	{1,1,0,0,0,0,0,0,0,0,0,1,1,1,0},
	{1,1,1,0,0,0,1,1,1,0,0,1,1,1,0},
	{1,1,1,5,5,5,1,2,1,0,0,1,1,1,0},
	{1,1,1,0,0,5,1,1,1,0,0,1,1,1,0},
	{0,0,1,0,0,5,5,5,5,5,1,1,0,0,0},
	{0,0,1,1,1,5,5,1,5,5,5,0,0,0,0},
	{0,0,0,1,1,5,5,5,5,5,5,0,0,0,0},
	{0,0,0,1,1,1,0,0,1,1,0,0,0,0,0},
	{8,5},1,{1,1,1,1,1,1},{13,4,13,4}},
	--level 11
	{{0,0,0,0,0,0,0,0,1,1,1,0,0,0,0},
	{0,0,0,1,1,1,0,0,1,1,1,0,0,0,0},
	{1,0,0,1,1,1,1,1,1,1,1,1,1,1,0},
	{1,0,0,1,1,1,0,0,0,0,0,0,4,1,0},
	{1,0,0,0,0,0,0,0,0,0,0,0,1,1,0},
	{1,0,0,0,0,0,0,0,0,0,0,0,1,1,0},
	{1,0,0,0,0,0,0,0,1,1,1,1,1,1,0},
	{1,1,1,1,1,0,0,0,1,1,1,0,0,0,0},
	{0,1,1,2,1,0,0,0,1,1,1,0,0,0,0},
	{0,0,1,1,1,0,0,0,1,1,1,1,1,4,0},
	{4,9},2,{13,4,2,3,2,3,3,2},{14,10,2,4,2,4,3,2},{5,3,5,3}},
	--level 12
	{{1,1,1,0,0,0,0,0,0,0,0,0,0,0,0},
	{1,1,1,1,1,1,1,1,1,0,0,0,1,1,1},
	{1,1,1,0,0,0,0,0,1,1,1,1,1,2,1},
	{1,1,1,0,0,0,0,0,0,0,0,0,4,4,1},
	{1,1,1,0,0,0,0,0,0,0,0,0,0,0,0},
	{1,1,1,0,0,0,0,0,0,0,0,0,0,0,0},
	{1,1,1,0,0,0,0,1,1,1,1,1,4,0,0},
	{1,1,1,1,1,1,1,1,0,0,0,1,1,0,0},
	{1,3,1,0,0,0,0,0,0,0,0,1,1,0,0},
	{1,1,1,0,0,0,0,0,0,0,0,1,4,0,0},
	{14,3},5,{13,4,1,7,7,0},{14,4,1,7,7,1},{13,7,1,3,8,1},{2,9,1,8,9,2},{13,10,2,2,10,8,10,2},{2,2,2,2}},
	--level 13
	{{0,0,0,0,0,0,0,3,0,0,0,0,0,0,0},
	{1,1,3,1,0,0,0,1,0,0,0,0,0,0,0},
	{1,1,1,1,1,0,0,1,0,0,0,0,0,0,0},
	{1,3,1,1,1,1,1,1,0,0,1,1,0,0,1},
	{1,1,1,1,1,0,0,0,1,0,0,0,1,0,0},
	{1,1,3,1,0,0,0,0,1,0,0,0,1,0,0},
	{1,0,0,0,0,0,0,0,3,0,0,1,1,1,0},
	{1,0,0,0,0,0,0,0,0,0,1,1,2,1,0},
	{1,0,0,4,0,0,0,0,0,0,1,1,1,1,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{13,8},6,{2,4,2,4,9,4,10,0},{3,6,4,9,2,9,3,4,13,4,14,0},{3,2,4,9,2,9,3,4,13,4,14,0},{8,1,2,4,9,4,10,1},{9,7,4,9,2,9,3,4,13,4,14,1},{4,9,1,5,6,2},{3,4,3,4}},
	--level 14
	{{0,1,1,1,1,1,1,1,1,1,3,1,1,1,1},
	{0,0,0,0,0,1,1,0,0,0,0,0,0,1,1},
	{0,0,0,0,0,1,1,0,0,0,0,0,0,1,1},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
	{1,1,1,0,0,1,1,0,0,1,3,1,1,1,1},
	{1,2,1,0,0,1,1,0,0,0,0,0,0,0,0},
	{1,1,1,0,0,1,1,0,0,0,0,0,0,0,0},
	{0,1,1,0,0,1,1,0,0,0,0,0,0,0,0},
	{0,1,1,1,1,1,1,1,1,1,3,1,1,1,0},
	{2,7},3,{11,1,2,6,8,6,9,2},{11,6,2,10,3,10,4,0},{11,10,2,10,3,10,4,1},{2,1,2,1}},
	--level 15
	{{0,0,0,0,0,0,0,0,1,1,0,0,0,0,0},
	{0,0,0,0,0,0,0,1,1,1,0,0,0,0,0},
	{1,1,0,0,1,1,1,1,1,1,0,0,0,0,0},
	{1,1,1,1,1,1,0,0,1,0,0,0,0,0,0},
	{1,1,1,1,0,0,0,0,1,0,0,0,1,1,1},
	{0,1,1,0,0,0,0,0,4,1,1,1,1,2,1},
	{0,0,1,0,0,0,0,0,4,1,0,0,1,1,1},
	{0,0,1,1,1,0,0,0,1,1,0,0,0,0,0},
	{0,0,0,1,1,1,0,0,1,1,0,0,0,0,0},
	{0,0,0,0,1,1,1,1,1,1,0,0,0,0,0},
	{14,6},2,{9,6,1,10,4,2},{9,7,1,8,6,2},{2,4,2,4}},
	--level 16
	{{0,0,0,0,0,1,1,0,0,0,0,1,1,1,0},
	{0,0,0,1,1,1,1,1,1,0,0,1,2,1,0},
	{1,1,1,1,1,1,3,1,1,1,1,1,1,1,0},
	{1,1,1,1,3,0,0,1,1,1,1,1,0,0,0},
	{1,1,1,0,0,0,0,0,0,1,1,1,0,0,0},
	{0,1,0,0,0,0,0,0,0,0,1,0,0,0,0},
	{0,1,0,0,0,0,0,0,0,0,1,0,0,0,0},
	{0,1,0,0,0,0,0,0,0,1,1,0,0,0,0},
	{0,1,1,0,0,0,0,0,0,1,1,0,0,0,0},
	{0,0,4,0,0,0,0,0,0,4,0,0,0,0,0},
	{13,2},4,{5,4,2,8,3,4,13,0},{7,3,2,8,3,4,13,0},{3,10,1,4,13,2},{10,10,1,8,3,2},{2,4,2,4}}
}

	colormap = {{170,170,170},{194,41,0},{100,100,100},{50,50,50},{194,141,0}}
	--1=0,84,6,94,21,92,15,82, 2=finish, 3=button, 4=hard button, 5=orange (weight)
	--button:x,y hardbutton:y,x orange:x,y finish:x,y
	--floormap{{{0,84,6,94,21,92,15,82s},{finish},nrofbridges,{button1coord,nrof0,84,6,94,21,92,15,82stobridge,bridge1coord,bridge2coord},{butto...},{startcoord,startcoord}}
	blockpos = floormap[level][13+floormap[level][12]]
	blockdir = 1
	--blockdir 1=hor, 2=vert
	up = true
	done = false
	win = false
	falling = false
	button = false
	totalmoves = totalmoves + moves
	moves = 0
	alpha = 384
	m=0
repeat
zmg.clear()
	if levelreached<16 then
		finished = false
	else
		finished = true
	end
function onarrowKey()
	if game then
		if not done then
		if zmg.keyMenuFast()==27 then
			blockpos[1] = blockpos[1] + 1
			blockpos[3] = blockpos[3] + 1
			if up then
				up = false
				blockdir=1
				blockpos[3]=blockpos[1]+1
				blockpos[4]=blockpos[2]
			elseif blockdir==1 then
				up = true
				blockpos[1] = blockpos[1] + 1
				blockpos[3]=blockpos[1]
				blockpos[4]=blockpos[2]
			end
			if floormap[level][blockpos[2]][blockpos[1]]==0 or floormap[level][blockpos[4]][blockpos[3]]==0 or not floormap[level][blockpos[4]][blockpos[3]] or not floormap[level][blockpos[2]][blockpos[1]]then
				done = true
				win = false
			end
		elseif zmg.keyMenuFast()==38 then
			blockpos[1] = blockpos[1] - 1
			blockpos[3]=blockpos[3] - 1
			if up then
				up = false
				blockdir=1
				blockpos[1]=blockpos[1] - 1
				blockpos[3]=blockpos[1] + 1
				blockpos[4]=blockpos[2]
			elseif blockdir==1 then
				up = true
				blockpos[3]=blockpos[1]
				blockpos[4]=blockpos[2]
			end
			if floormap[level][blockpos[2]][blockpos[1]]==0 or floormap[level][blockpos[4]][blockpos[3]]==0 or not floormap[level][blockpos[4]][blockpos[3]] or not floormap[level][blockpos[2]][blockpos[1]] then
				done = true
				win = false
			end
		elseif zmg.keyMenuFast()==28 then
			blockpos[2] = blockpos[2] - 1
			blockpos[4] = blockpos[4] - 1
			if up then
				up = false
				blockdir=2
				blockpos[2] = blockpos[2] - 1
				blockpos[3]=blockpos[1]
				blockpos[4]=blockpos[2]+1
			elseif blockdir==2 then
				up = true
				blockpos[3]=blockpos[1]
				blockpos[4]=blockpos[2]
			end
			if blockpos[1]<16 and blockpos[1]>0 and blockpos[2]<11 and blockpos[2]>0 then
			if floormap[level][blockpos[2]][blockpos[1]]==0 or floormap[level][blockpos[4]][blockpos[3]]==0 or not floormap[level][blockpos[4]][blockpos[3]] or not floormap[level][blockpos[2]][blockpos[1]] then
				done = true
				win = false
			end
			else
				done = true
				win=false
			end
		elseif zmg.keyMenuFast()==37 then
			blockpos[2] = blockpos[2] + 1
			blockpos[4] = blockpos[4] + 1
			if up then
				up = false
				blockdir=2
				blockpos[3]=blockpos[1]
				blockpos[4]=blockpos[2]+1
			elseif blockdir==2 then
				up = true
				blockpos[2] = blockpos[2] + 1
				blockpos[3]=blockpos[1]
				blockpos[4]=blockpos[2]
			end
			if blockpos[2]>10 or blockpos[4]>10 then
				gmeover = true
			else
			if floormap[level][blockpos[2]][blockpos[1]]==0 or floormap[level][blockpos[4]][blockpos[3]]==0 or not floormap[level][blockpos[4]][blockpos[3]] or not floormap[level][blockpos[2]][blockpos[1]] then
				done = true
				win = false
				falling = true
			end
			end
		end
		if blockpos[1]<16 and blockpos[1]>0 and blockpos[2]<11 and blockpos[2]>0 then
		for m=0,floormap[level][12]-1 do
			if floormap[level][floormap[level][13+m][2]][floormap[level][13+m][1]]==3 then
				if blockpos[1]==floormap[level][13+m][1] and blockpos[2]==floormap[level][13+m][2] or blockpos[3]==floormap[level][13+m][1] and blockpos[4]==floormap[level][13+m][2] then
					button = true
					for l=1,floormap[level][13+m][3] do
						if 	   floormap[level][floormap[level][13+m][3+2*l-1]][floormap[level][13+m][3+2*l]]==0 and floormap[level][13+m][4+2*floormap[level][13+m][3]]==1 then 
							floormap[level][floormap[level][13+m][3+2*l-1]][floormap[level][13+m][3+2*l]]=1
						elseif floormap[level][floormap[level][13+m][3+2*l-1]][floormap[level][13+m][3+2*l]]==0 and floormap[level][13+m][4+2*floormap[level][13+m][3]]==0 then
							floormap[level][floormap[level][13+m][3+2*l-1]][floormap[level][13+m][3+2*l]]=0
						elseif floormap[level][floormap[level][13+m][3+2*l-1]][floormap[level][13+m][3+2*l]]==0 and floormap[level][13+m][4+2*floormap[level][13+m][3]]==2 then
							floormap[level][floormap[level][13+m][3+2*l-1]][floormap[level][13+m][3+2*l]]=1
						elseif floormap[level][floormap[level][13+m][3+2*l-1]][floormap[level][13+m][3+2*l]]==1 and floormap[level][13+m][4+2*floormap[level][13+m][3]]==2 then
							floormap[level][floormap[level][13+m][3+2*l-1]][floormap[level][13+m][3+2*l]]=0
						elseif floormap[level][floormap[level][13+m][3+2*l-1]][floormap[level][13+m][3+2*l]]==1 and floormap[level][13+m][4+2*floormap[level][13+m][3]]==0 then
							floormap[level][floormap[level][13+m][3+2*l-1]][floormap[level][13+m][3+2*l]]=0
						elseif floormap[level][floormap[level][13+m][3+2*l-1]][floormap[level][13+m][3+2*l]]==1 and floormap[level][13+m][4+2*floormap[level][13+m][3]]==1 then
							floormap[level][floormap[level][13+m][3+2*l-1]][floormap[level][13+m][3+2*l]]=1
						elseif floormap[level][floormap[level][13+m][3+2*l-1]][floormap[level][13+m][3+2*l]]==0 and floormap[level][13+m][4+2*floormap[level][13+m][3]]==1 then
							floormap[level][floormap[level][13+m][3+2*l-1]][floormap[level][13+m][3+2*l]]=1
						end
						--veld = 1, knop = 0 ==> veld = 0 OK
						--veld = 1, knop = 1 ==> veld = 1 OK
						--veld = 1, knop = 2 ==> veld = 0 OK
						--veld = 0, knop = 0 ==> veld = 0 OK
						--veld = 0, knop = 1 ==> veld = 1 OK
						--veld = 0, knop = 2 ==> veld = 1 OK
					end
				end
			elseif floormap[level][floormap[level][13+m][2]][floormap[level][13+m][1]]==4 then
				if blockpos[1]==floormap[level][13+m][1] and blockpos[2]==floormap[level][13+m][2] and blockpos[3]==floormap[level][13+m][1] and blockpos[4]==floormap[level][13+m][2] then
					for l=1,floormap[level][13+m][3] do
						if floormap[level][floormap[level][13+m][3+2*l-1]][floormap[level][13+m][3+2*l]]==0 then
							floormap[level][floormap[level][13+m][3+2*l-1]][floormap[level][13+m][3+2*l]]=1
						else
							floormap[level][floormap[level][13+m][3+2*l-1]][floormap[level][13+m][3+2*l]]=0
						end
					end
				end
			end
			if floormap[level][blockpos[2]][blockpos[1]]==5 and floormap[level][blockpos[4]][blockpos[3]]==5 and blockpos[1]==blockpos[3] and blockpos[2]==blockpos[4] then
				done=true
				win=false
				falling=true
			end
		end
		if blockpos[1]==floormap[level][11][1] and blockpos[2]==floormap[level][11][2] and up then
			done=true
			win=true
		end
		else
			done = true
			win = false
		
		moves = moves + 1
		end
	else
		if zmg.keyMenuFast()==38 then
			if not leftscroll then
				leftscroll = true
			elseif level>2 and leftscroll then
				leftscroll = false
			end
		end
		if zmg.keyMenuFast()==27 then
			if not rightscroll then
				rightscroll = true
			elseif level<=14 and rightscroll then
				rightscroll = false
			end
		end
	zmg.fastCopy()
	end
end
end
function ontabKey()
	if game then
		game = false
		zmg.fastCopy()
	else
		level = levelreached
		zmg.fastCopy()
	end
end
function onenterKey()
	if game then
		if done and win then
			level=level+1
			if level>levelreached then
				levelreached = level
				done = false
				win = false
				alpha = 384
				blockpos = floormap[level][13+floormap[level][12]]
			end
			--var.store("levelreached",levelreached)
		end
		if done and not win then
			--var.store("levelreached",levelreached)
		end
		zmg.fastCopy()
	else
		game = true
		zmg.fastCopy()
	end
end
function drawselector()
	-- zmg.drawText(0,0,"levelreached = "..levelreached,0x0000, 0xFFFF)
	zmg.makeColor(0,0,0)
	zmg.drawText(130,5,"Level "..level,0x0000, 0xFFFF)
	for i=1,10 do
		for j=1,15 do
			zmg.makeColor(170,170,170)
			for k=1,7,2 do
				--tilechange[k]=0,84,6,94,21,92,15,82[k]+i*7+j*8-18
				--tilechange[k+1]=0,84,6,94,21,92,15,82[k+1]+i*5-j*1+5
				tilechangesel[k]=tilechangesel[k]+i*3+j*8+scroll
				tilechangesel[k+1]=tilechangesel[k+1]+i*6-j*1+40
			end
			if floormap[level][i][j] == 1 then	
				zmg.drawLine(tilesel[1],tilesel[2],tilesel[3],tilesel[4],0x0000)
				zmg.drawLine(tilesel[3],tilesel[4],tilesel[5],tilesel[6],0x0000)
				zmg.drawLine(tilesel[5],tilesel[6],tilesel[7],tilesel[8],0x0000)
				zmg.drawLine(tilesel[7],tilesel[8],tilesel[1],tilesel[2],0x0000)
			elseif floormap[level][i][j]==2 then
				zmg.makeColor(194,41,0)
				zmg.drawLine(tilesel[1],tilesel[2],tilesel[3],tilesel[4],zmg.makeColor(194,41,0))
				zmg.drawLine(tilesel[3],tilesel[4],tilesel[5],tilesel[6],zmg.makeColor(194,41,0))
				zmg.drawLine(tilesel[5],tilesel[6],tilesel[7],tilesel[8],zmg.makeColor(194,41,0))
				zmg.drawLine(tilesel[7],tilesel[8],tilesel[1],tilesel[2],zmg.makeColor(194,41,0))
				zmg.makeColor(170,170,170)
			elseif floormap[level][i][j]==3 then
				zmg.makeColor(100,100,100)
				zmg.drawLine(tilesel[1],tilesel[2],tilesel[3],tilesel[4],zmg.makeColor(100,100,100))
				zmg.drawLine(tilesel[3],tilesel[4],tilesel[5],tilesel[6],zmg.makeColor(100,100,100))
				zmg.drawLine(tilesel[5],tilesel[6],tilesel[7],tilesel[8],zmg.makeColor(100,100,100))
				zmg.drawLine(tilesel[7],tilesel[8],tilesel[1],tilesel[2],zmg.makeColor(100,100,100))
				zmg.makeColor(170,170,170)
			elseif floormap[level][i][j]==4 then
				zmg.makeColor(50,50,50)
				zmg.drawLine(tilesel[1],tilesel[2],tilesel[3],tilesel[4],zmg.makeColor(50,50,50))
				zmg.drawLine(tilesel[3],tilesel[4],tilesel[5],tilesel[6],zmg.makeColor(50,50,50))
				zmg.drawLine(tilesel[5],tilesel[6],tilesel[7],tilesel[8],zmg.makeColor(50,50,50))
				zmg.drawLine(tilesel[7],tilesel[8],tilesel[1],tilesel[2],zmg.makeColor(50,50,50))
				zmg.makeColor(170,170,170)
			elseif floormap[level][i][j]==5 then
				zmg.makeColor(194,141,0)
				zmg.drawLine(tilesel[1],tilesel[2],tilesel[3],tilesel[4],zmg.makeColor(194,141,0))
				zmg.drawLine(tilesel[3],tilesel[4],tilesel[5],tilesel[6],zmg.makeColor(194,141,0))
				zmg.drawLine(tilesel[5],tilesel[6],tilesel[7],tilesel[8],zmg.makeColor(194,141,0))
				zmg.drawLine(tilesel[7],tilesel[8],tilesel[1],tilesel[2],zmg.makeColor(194,141,0))
				zmg.makeColor(170,170,170)
			end
			--zmg.makeColor(unpack(colormap[floormap[level][i][j]]))
			--zmg.drawLine(0,84,6,94,21,92,15,82)
			tilechangesel = {0,42,3,47,10,46,8,41}
		end
	end
end
function drawgame()
	if finished then
		zmg.drawText(60,25,"Game finished (last level reached)",0x0000, 0xFFFF)
	end
	zmg.drawText(130,5,"Level "..level,0x0000, 0xFFFF)
	-- zmg.drawText(0,0,"levelreached = "..levelreached,0x0000, 0xFFFF)
	zmg.makeColor(170,170,170)
	for i=1,10 do
		for j=1,15 do
			for k=1,7,2 do
				tilechange[k]=tilechange[k]+i*7+j*16-18
				tilechange[k+1]=tilechange[k+1]+i*11-j*2+5
			end
			if floormap[level][i][j]==1 then	
				zmg.drawLine(tilechange[1],tilechange[2],tilechange[3],tilechange[4],0x0000)
				zmg.drawLine(tilechange[3],tilechange[4],tilechange[5],tilechange[6],0x0000)
				zmg.drawLine(tilechange[5],tilechange[6],tilechange[7],tilechange[8],0x0000)
				zmg.drawLine(tilechange[7],tilechange[8],tilechange[1],tilechange[2],0x0000)
			elseif floormap[level][i][j]==2 then
				zmg.makeColor(194,41,0)
				zmg.drawLine(tilechange[1],tilechange[2],tilechange[3],tilechange[4],zmg.makeColor(194,41,0))
				zmg.drawLine(tilechange[3],tilechange[4],tilechange[5],tilechange[6],zmg.makeColor(194,41,0))
				zmg.drawLine(tilechange[5],tilechange[6],tilechange[7],tilechange[8],zmg.makeColor(194,41,0))
				zmg.drawLine(tilechange[7],tilechange[8],tilechange[1],tilechange[2],zmg.makeColor(194,41,0))
				zmg.makeColor(170,170,170)
			elseif floormap[level][i][j]==3 then
				zmg.makeColor(100,100,100)
				zmg.drawLine(tilechange[1],tilechange[2],tilechange[3],tilechange[4],zmg.makeColor(100,100,100))
				zmg.drawLine(tilechange[3],tilechange[4],tilechange[5],tilechange[6],zmg.makeColor(100,100,100))
				zmg.drawLine(tilechange[5],tilechange[6],tilechange[7],tilechange[8],zmg.makeColor(100,100,100))
				zmg.drawLine(tilechange[7],tilechange[8],tilechange[1],tilechange[2],zmg.makeColor(100,100,100))
				zmg.makeColor(170,170,170)
			elseif floormap[level][i][j]==4 then
				zmg.makeColor(50,50,50)
				zmg.drawLine(tilechange[1],tilechange[2],tilechange[3],tilechange[4],zmg.makeColor(50,50,50))
				zmg.drawLine(tilechange[3],tilechange[4],tilechange[5],tilechange[6],zmg.makeColor(50,50,50))
				zmg.drawLine(tilechange[5],tilechange[6],tilechange[7],tilechange[8],zmg.makeColor(50,50,50))
				zmg.drawLine(tilechange[7],tilechange[8],tilechange[1],tilechange[2],zmg.makeColor(50,50,50))
				zmg.makeColor(170,170,170)
			elseif floormap[level][i][j]==5 then
				zmg.makeColor(194,141,0)
				zmg.drawLine(tilechange[1],tilechange[2],tilechange[3],tilechange[4],zmg.makeColor(194,141,0))
				zmg.drawLine(tilechange[3],tilechange[4],tilechange[5],tilechange[6],zmg.makeColor(194,141,0))
				zmg.drawLine(tilechange[5],tilechange[6],tilechange[7],tilechange[8],zmg.makeColor(194,141,0))
				zmg.drawLine(tilechange[7],tilechange[8],tilechange[1],tilechange[2],zmg.makeColor(194,141,0))
				zmg.makeColor(170,170,170)
			end
			--zmg.makeColor(unpack(colormap[floormap[level][i][j]]))
			--zmg.drawLine(0,84,6,94,21,92,15,82)
			tilechange = {0,84,6,94,21,92,15,82}
		end
	end
zmg.fastCopy()
end
	if up then
		blocktop = {5,74,11,84,26,82,20,72}
		blockfront = {11,84,11,108,26,106,26,82}
		blockleft = {5,74,5,98,11,108,11,84}
	elseif blockdir==1 then
		blocktop = {5,84,11,94,42,90,36,80}
		blockfront = {11,84,11,108,42,104,42,90}
		blockleft = {5,84,5,98,11,108,11,84}
	elseif blockdir==2 then
		blocktop = {5,84,18,105,33,103,20,82}
		blockfront = {18,105,18,119,33,117,33,103}
		blockleft = {5,84,5,98,18,119,18,105}
	end

	for k=1,7,2 do
		blocktop[k] = blocktop[k]+(blockpos[2]-1)*7+(blockpos[1]-1)*16
		blocktop[k+1] = blocktop[k+1]+(blockpos[2]-1)*11-(blockpos[1]-1)*2
		blockfront[k] = blockfront[k]+(blockpos[2]-1)*7+(blockpos[1]-1)*16
		blockfront[k+1] = blockfront[k+1]+(blockpos[2]-1)*11-(blockpos[1]-1)*2
		blockleft[k] = blockleft[k]+(blockpos[2]-1)*7+(blockpos[1]-1)*16
		blockleft[k+1] = blockleft[k+1]+(blockpos[2]-1)*11-(blockpos[1]-1)*2
	end
	if done then
		--gc:setAlpha(alpha)
	end
	if alpha <= 0 then
		alpha = 384
		if win then
			level = level + 1
			if level>16 then
				level = 16
				finished = true
			end
			if level>levelreached then
				levelreached = level
			end
			--var.store("levelreached",levelreached)
		end
	end
	
	zmg.drawLine(blocktop[1],blocktop[2],blocktop[3],blocktop[4],zmg.makeColor(80,80,80))
	zmg.drawLine(blocktop[3],blocktop[4],blocktop[5],blocktop[6],zmg.makeColor(80,80,80))
	zmg.drawLine(blocktop[5],blocktop[6],blocktop[7],blocktop[8],zmg.makeColor(80,80,80))
	zmg.drawLine(blocktop[7],blocktop[8],blocktop[1],blocktop[2],zmg.makeColor(80,80,80))
	zmg.drawLine(blockfront[1],blockfront[2],blockfront[3],blockfront[4],zmg.makeColor(0,0,0))
	zmg.drawLine(blockfront[3],blockfront[4],blockfront[5],blockfront[6],zmg.makeColor(0,0,0))
	zmg.drawLine(blockfront[5],blockfront[6],blockfront[7],blockfront[8],zmg.makeColor(0,0,0))
	zmg.drawLine(blockfront[7],blockfront[8],blockfront[1],blockfront[2],zmg.makeColor(0,0,0))
	zmg.drawLine(blockleft[1],blockleft[2],blockleft[3],blockleft[4],zmg.makeColor(40,40,40))
	zmg.drawLine(blockleft[3],blockleft[4],blockleft[5],blockleft[6],zmg.makeColor(40,40,40))
	zmg.drawLine(blockleft[5],blockleft[6],blockleft[7],blockleft[8],zmg.makeColor(40,40,40))
	zmg.drawLine(blockleft[7],blockleft[8],blockleft[1],blockleft[2],zmg.makeColor(40,40,40))
	if done and not win then
	alpha = alpha-1
	zmg.drawLine(alpha, 0, alpha, 216, zmg.makeColor(194,41,0))
	end
	zmg.drawText(0,5,"Moves: "..moves,0x0000, 0xFFFF)	
	zmg.fastCopy()


function onpaint()
	if game then
		drawgame()
	else
		drawselector()
	end
	if zmg.keyMenuFast()==31 then
		onenterKey()
	elseif zmg.keyMenuFast()==68 then
		ontabKey()
	elseif zmg.keyMenuFast()==38 or zmg.keyMenuFast()==37 or zmg.keyMenuFast()==28 or zmg.keyMenuFast()==27 then
		onarrowKey()
	end
end
if a==1 then
	onpaint()
end

zmg.fastCopy()
until zmg.keyMenuFast() == 47