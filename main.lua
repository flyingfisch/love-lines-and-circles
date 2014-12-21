-- [[ LÖVE2D CALLBACKS ]]--
function love.load()
	level = 0

	player = {}
	player.x, player.y = 0, 0
	player.speed = 100
	player.color = {200, 50, 50}
	player.size = 10

	objective = {}
	objective.x, objective.y = 75, 75
	objective.color = {50, 50, 200}
	objective.size = 10

	-- lines = {{x, y, vertical, direction, color}}
	lines = {{x=100, y=100, vertical=false, direction=1, color={50, 50, 200}}, {x=150, y=150, vertical=true, direction=1, color={50, 50, 200}}}
	lineColor = {50, 50, 200}
	lineLength = 20
	lineWidth = 1
	lineSpeed = 100

	love.graphics.setLineStyle("smooth")
end

function love.update(dt)
	keyHandler(dt)
	updateLines(dt)
	collisionHandler()
end

function love.draw()
	drawPlayer(player.x, player.y)
	drawObjective(objective.x, objective.y)

	drawLines(lines)
end



--[[ FUNCTIONS ]]--

-- key functions
function keyHandler(dt)
	local speed = player.speed * dt

	if love.keyboard.isDown("left") then
		player.x = player.x - speed
	elseif love.keyboard.isDown("right") then
		player.x = player.x + speed
	end

	if love.keyboard.isDown("up") then
		player.y = player.y - speed
	elseif love.keyboard.isDown("down") then
		player.y = player.y + speed
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
				print("collision!")
			end

		else
			if line.x + lineLength > player.x - player.size
				and line.x < player.x + player.size
				and line.y > player.y - player.size
				and line.y < player.y + player.size then
				print("collision!")
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
	level = level + 1

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

	table.insert(lines, {x = vx, y = vy, vertical = true, direction = 1, color = lineColor})
	table.insert(lines, {x = hx, y = hy, vertical = false, direction = 1, color = lineColor})
end

function updateObjective()
	objective.x = math.random(1, love.graphics.getWidth())
	objective.y = math.random(1, love.graphics.getHeight())
end
