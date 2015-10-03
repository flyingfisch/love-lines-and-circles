-- [[ LÖVE2D CALLBACKS ]]--
function love.load()
	math.randomseed(os.time() + os.time() ^ 2)
	love.window.setTitle("Lines and Circles")

	score = 0
	showTitle, showLose, showGame = true, false, false
	fullscreen = false

	fonts = {}
	fonts.arvo = {}
	fonts.arvo.path = "Arvo-Regular.ttf"
	fonts.arvo.l = love.graphics.newFont(fonts.arvo.path, 40)
	fonts.arvo.m = love.graphics.newFont(fonts.arvo.path, 20)
	fonts.arvo.s = love.graphics.newFont(fonts.arvo.path, 10)

	player = {}
	player.x, player.y = 200, 200
	player.speed = 100
	player.color = {250, 150, 50}
	player.size = 10

	objective = {}
	objective.x, objective.y = 75, 75
	objective.color = {50, 50, 255}
	objective.size = 10

	-- lines = {{x, y, vertical, direction, color}}
	lines = {{x=100, y=100, vertical=false, direction=1, color={50, 50, 100}}, {x=150, y=150, vertical=true, direction=1, color={50, 50, 200}}}
	lineColor = {50, 50, 200}
	lineLength = 20
	lineWidth = 1
	lineSpeed = 100

	love.graphics.setLineStyle("smooth")
end

function love.update(dt)
	keyHandler(dt)

	if showGame then
		updateLines(dt)
		collisionHandler()
	end
end

function love.draw()
	if showTitle then
		title()
	elseif showLose then
		lose()
	elseif showGame then
		drawPlayer(player.x, player.y)
		drawObjective(objective.x, objective.y)

		drawLines(lines)
		drawUI()
	end
end



--[[ FUNCTIONS ]]--

-- key functions
function keyHandler(dt)
	if showTitle then
		if love.keyboard.isDown("return") then
			showTitle = false
			showGame = true
		end
	elseif showLose then
		if love.keyboard.isDown(" ") then
			love.load()
		end
	elseif showGame then
		local speed = player.speed * dt

		if love.keyboard.isDown("left") and player.x - player.size > 0 then
			player.x = player.x - speed
		elseif love.keyboard.isDown("right") and player.x + player.size < love.graphics.getWidth() then
			player.x = player.x + speed
		end

		if love.keyboard.isDown("up") and player.y - player.size > 0 then
			player.y = player.y - speed
		elseif love.keyboard.isDown("down") and player.y + player.size < love.graphics.getHeight() then
			player.y = player.y + speed
		end
	end

	if love.keyboard.isDown("escape") then
		love.event.quit()
	end
end

-- draw functions
function drawPlayer(x, y)
	love.graphics.setColor(player.color[1], player.color[2], player.color[3])
	love.graphics.circle("fill", x, y, player.size, 25)
end

function drawObjective(x, y)
	love.graphics.setColor(objective.color[1], objective.color[2], objective.color[3])
	love.graphics.circle("fill", objective.x, objective.y, objective.size, 25)
end

function drawLines(lines)
	love.graphics.setLineWidth(lineWidth)
	for key, line in pairs(lines) do
		love.graphics.setColor(line.color[1], line.color[2], line.color[3])

		if line.vertical then
			love.graphics.line(line.x, line.y, line.x, line.y + lineLength)
		else
			love.graphics.line(line.x, line.y, line.x + lineLength, line.y)
		end
	end
end

function drawUI()
	love.graphics.setColor(255, 255, 255)
	love.graphics.setFont(fonts.arvo.m)
	love.graphics.print("Score: " .. score, 10, 10)
end

-- update functions
function updateLines(dt)
	local speed = lineSpeed * dt
	for key, line in pairs(lines) do
		if line.vertical then
			if line.y + lineLength > love.graphics.getHeight() then
				line.direction = -1
			elseif line.y < 0 then
				line.direction = 1
			end

			line.y = line.y + (speed * line.direction)

		else
			if line.x + lineLength > love.graphics.getWidth() then
				line.direction = -1
			elseif line.x < 0 then
				line.direction = 1
			end

			line.x = line.x + (speed * line.direction)
		end
	end
end

function collisionHandler()
	-- lines
	for key, line in pairs(lines) do
		if line.vertical then
			if line.x > player.x - player.size
				and line.x < player.x + player.size
				and line.y + lineLength > player.y - player.size
				and line.y < player.y + player.size then
				print("YOU LOST (V)")
				showLose = true
				showGame = false
			end

		else
			if line.x + lineLength > player.x - player.size
				and line.x < player.x + player.size
				and line.y > player.y - player.size
				and line.y < player.y + player.size then
				print("YOU LOST (H)")
				showLose = true
				showGame = false
			end
		end
	end

	-- objective
	if objective.x + objective.size > player.x - player.size
		and objective.x - objective.size < player.x + player.size
		and objective.y + objective.size > player.y - player.size
		and objective.y - objective.size < player.y + player.size then
		levelUp()
		updateObjective()
	end
end


-- other functions
function levelUp()
	local vy, vx, hy, hx
	score = score + 100

	if player.x > love.graphics.getWidth() / 2 then
		vx, hx = math.random(1, love.graphics.getWidth() / 2 - player.size), math.random(1, love.graphics.getWidth() / 2 - player.size)
	else
		vx, hx = math.random(love.graphics.getWidth() / 2 + player.size, love.graphics.getHeight()), math.random(love.graphics.getWidth() / 2 + player.size, love.graphics.getWidth())
	end

	if player.y > love.graphics.getHeight() / 2 then
		vy, hy = math.random(1, love.graphics.getHeight() / 2 - player.size), math.random(1, love.graphics.getHeight() / 2 - player.size)
	else
		vy, hy = math.random(love.graphics.getHeight() / 2 + player.size, love.graphics.getHeight()), math.random(love.graphics.getHeight() / 2 + player.size, love.graphics.getHeight())
	end

	r1 = math.random(0,255)
	g1 = math.random(0,255)
	b1 = math.random(0,255)

	r2 = math.random(0,255)
	g2 = math.random(0,255)
	b2 = math.random(0,255)

	table.insert(lines, {x = vx, y = vy, vertical = true, direction = 1, color = {r1, g1, b1}})
	table.insert(lines, {x = hx, y = hy, vertical = false, direction = 1, color = {r2, g2, b2}})
end

function updateObjective()
	objective.x = math.random(1, love.graphics.getWidth())
	objective.y = math.random(1, love.graphics.getHeight())
end

function title()
	love.graphics.setColor(255, 255, 255)

	love.graphics.setFont(fonts.arvo.l)
	love.graphics.print("Lines and Circles", 50, 50)
	love.graphics.setFont(fonts.arvo.m)
	love.graphics.print("Press ENTER to play!", 50, 150)
	love.graphics.print("Use arrow keys to move", 50, 190)
	love.graphics.setFont(fonts.arvo.s)
	love.graphics.print("Developed by Mark Fischer, Jr.", 50, 450)
end

function lose()
	love.graphics.setColor(255, 255, 255)

	love.graphics.setFont(fonts.arvo.l)
	love.graphics.print("GAME OVER", 50, 50)
	love.graphics.setFont(fonts.arvo.m)
	love.graphics.print("Your score is: " .. score, 50, 150)
	love.graphics.print("Press SPACE to continue!", 50, 350)
end
