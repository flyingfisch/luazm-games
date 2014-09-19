-- port of this checkers game for nspire: http://www.ticalc.org/pub/nspire/lua/games/checkers.zip

local a = 400
local init = false
local init2 = false
local textc = class()
local dots = {}
local mode = 1



local function AIchoose(diff,piece)
	if gameover.num == false then
		possmoves = {}
		original = {}
		for i=1,8 do
			for j=1,8 do
				if string.lower(board[i][j]) == piece then
					if whereToMove(i,j) ~= false then
						table.insert(original,{i,j})
						table.insert(possmoves,whereToMove(i,j))
					end
				end
			end
		end	

		if diff == "easy" then
			ab = math.random(#possmoves)
			selec1 = possmoves[ab]
			ac = math.random(#selec1)
			selecorig = original[ab]
			selec2 = selec1[ac]
		end

		jumpers = {}
		kingers = {}
		if diff == "normal" then
			for l,m in ipairs(possmoves) do
				for n,o in ipairs(m) do
					if o[3] == 1 then
						table.insert(jumpers,o)
						table.insert(jumpers,l)
					end
					if o[2] == 1 and board[original[l][1]][original[l][2]] ~= "O" then
						table.insert(kingers,o)
						table.insert(kingers,l)
					end
				end
			end
			if #kingers > 0 then
				q = math.random(#kingers/2)
				selec1 = {kingers[2*q-1],kingers[2*q]}
				selecorig = original[selec1[2]]
				selec2 = selec1[1]
			elseif #jumpers > 0 then
				q1 = math.random(#jumpers/2)
				selec1 = {jumpers[2*q1-1],jumpers[2*q1]}
				selecorig = original[selec1[2]]
				selec2 = selec1[1]
			else
				ab = math.random(#possmoves)
				selec1 = possmoves[ab]
				ac = math.random(#selec1)
				selecorig = original[ab]
				selec2 = selec1[ac]
			end
		end
		movePiece(selecorig[1],selecorig[2],selec2[1],selec2[2],selec2[3])
	end
end

local function whereToMove(xstart, ystart)
	tile = board[xstart][ystart]
	if tile ~= " " then
		PTM = {}
		othertile = oppside(tile)
		
		if tile == "X" or tile == "O" then
			moves = {{1,1},{1,-1},{-1,-1},{-1,1}}
		elseif tile == "x" then
			moves = {{1,1},{-1,1}}
		elseif tile == "o" then
			moves = {{1,-1},{-1,-1}}
		end
		
		for a, move in ipairs(moves) do
			x = xstart
			y = ystart

			cx, cy  = move[1], move[2]
			
			x = x + cx
			y = y + cy

			if isOnBoard(x,y) and isEmpty(x,y) then
				table.insert(PTM,{x,y,0})
			elseif isOnBoard(x,y) and string.lower(board[x][y]) == othertile then
				x = x + cx
				y = y + cy
				if isOnBoard(x,y) and isEmpty(x,y) then
					table.insert(PTM,{x,y,1})
				end
			end
		end
		if #PTM == 0 then
			return false
		else
			return PTM
		end
	end
end

local function movePiece(xbegin,ybegin,xend,yend,jump)
	--Moving
	board[xbegin][ybegin], board[xend][yend] = " ",board[xbegin][ybegin]
	--Kinging
	if board[xend][yend] == "x" and yend == 8 then
		board[xend][yend] = "X"
	elseif board[xend][yend] == "o" and yend == 1 then
		board[xend][yend] = "O"
	end
	--Capturing a Piece
	if jump == 1 then
		board[(xbegin+xend)/2][(ybegin+yend)/2] = " "
		piecestaken[turn] = piecestaken[turn] + 1
		if piecestaken[turn] >= 12 then
			gameovera(turn)
		end
	end
	--Change turn
	turn = oppside(turn)
	currentturn = turn == "x" and turns[1] or turns[2]
	--Check stale
	if checkstale(turn) == 12 - piecestaken[oppside(turn)] then
		gameovera(oppside(turn))
	end	

	if currentturn == 1 then
		aion = false
	elseif currentturn > 1 then
		aion = true
		if currentturn == 2 then
			AIchoose("easy","o")
		elseif currentturn == 3 then
			AIchoose("normal","o")
		elseif currentturn == 4 then
			AIchoose("hard","o")
		end
	end
	on.escapeKey()
end

--[[ MAIN LOOP ]]--
while not exit do
	if mode == 2 then
		--X is black, on top. O is white, on bottom.
		if not init then
			reset()
		end
		drawBoard(gc)
		drawPieces(board,gc)
		if platform.isColorDisplay() then
			gc:setColorRGB(100,100,100)
		else
			gc:setColorRGB(0,0,0)
		end
		gc:fillPolygon({55+20*point.x,20*point.y,75+20*point.x,20*point.y,65+20*point.x,7+20*point.y,55+20*point.x,20*point.y})
		gc:setPen("thick","smooth")
		gc:setColorRGB(0,0,255)
		gc:drawRect(55+20*highlight.x,20*highlight.y,20,20)
		for j, dot in ipairs(dots) do
			gc:fillRect(62+20*dot.x,7+20*dot.y,5,5)
		end
		gc:setColorRGB(150,150,150)
		gc:setColorRGB(0,0,0)
		gc:setFont("serif","b",18)
		gc:drawString(gameover.val,gameover.x,gameover.y)
		gc:setColorRGB(150,150,150)
		if turn == "x" then
			gc:fillRect(0,0,350,15)
		elseif turn == "o" then
			gc:fillRect(0,197,350,15)
		end
	--	gc:drawString(teststr,10,50)
	--	gc:drawString(tostring(piecestaken["x"]),260,50)
	--	gc:drawString(tostring(piecestaken["o"]),260,75)
	end

	if mode ~= 2 then
		gc:setColorRGB(255,211,155)
		gc:fillRect(0,0,320,220)
	end
	
	if mode == 1 then
		if not init2 then
			selector = textc(95, 123, 1)
			ai = textc(a,a,"2 Player",1)
		end
		gc:setColorRGB(255,255,255)
		gc:fillRect(0,0,330,115)
		gc:setColorRGB(0,0,0)
		gc:fillRect(0,115,330,5)
		gc:setFont("sansserif","b",12)
		gc:drawString("Uber-Checkers",10,30,"top")
		gc:setFont("serif","r",10)
		gc:drawString("Play",100,120,"top")
		gc:drawString("About",100,135,"top")
		gc:drawString("Instructions",100,150,"top")
		gc:drawRect(selector.x,selector.y,80,15)
		
		if selector.val == 1 then
			shift(ai,190,120)
			gc:drawString(ai.val,ai.x,ai.y,"top")
			gc:fillPolygon({185,124,185,136,180,130,185,124})
			gc:fillPolygon({245,124,245,136,250,130,245,124})
		end	
		gc:drawImage(checkericon,200,10)
	end
end