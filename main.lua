-- [[ LÖVE2D CALLBACKS ]]--
function love.load()
	player = {}
	player.x, player.y = 50, 50
	player.speed = 100
	player.color = {200, 50, 50}

	objective = {}
	objective.x, objective.y = 75, 75
	objective.color = {50, 50, 200}

	-- lines = {{x, y, vertical, direction, color}}
	lines = {{x=100, y=100, vertical=false, direction=1, color={50, 50, 200}}, {x=150, y=150, vertical=true, direction=1, color={50, 50, 200}}}
	lineLength = 20
	lineSpeed = 100
end

function love.update(dt)
	keyHandler(dt)
	updateLines(lines, dt)
end

function love.draw()
	drawPlayer(player.x, player.y)
	drawObjective(objective.x, objective.y)

	drawLines(lines)
end



--[[ FUNCTIONS ]]--
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
	love.graphics.circle("fill", x, y, 10, 25)
end

function drawObjective(x, y)
	love.graphics.setColor(objective.color[1], objective.color[2], objective.color[3])
	love.graphics.circle("fill", objective.x, objective.y, 10, 25)
end

function drawLines(lines)
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
function updateLines(lines, dt)
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
			elseif line.y < 0 then
				line.direction = 1
			end

			line.x = line.x + (speed * line.direction)
		end
	end
end
