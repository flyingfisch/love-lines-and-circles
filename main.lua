function love.load()
	player = {}
	player.x, player.y = 50, 50
	player.speed = 100
	player.color = {200, 50, 50}

	objective = {}
	objective.x, objective.y = 75, 75
	objective.color = {50, 50, 200}
end

function love.update(dt)
	keyHandler(dt)
end

function love.draw()
	drawPlayer(player.x, player.y)
	drawObjective(objective.x, objective.y)
end

-- custom functions
function keyHandler(dt)
	local speed = player.speed * dt

	-- keys
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

function drawPlayer(x, y)
	love.graphics.setColor(player.color[1], player.color[2], player.color[3])
	love.graphics.circle("fill", x, y, 10, 25)
end

function drawObjective(x, y)
	love.graphics.setColor(objective.color[1], objective.color[2], objective.color[3])
	love.graphics.circle("fill", objective.x, objective.y, 10, 25)
end
