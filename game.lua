local snakeX, snakeY = 12, 12
local snake = {}
local directionX, directionY = 0, 0
local pointX, pointY = 0, 0
local POINT_SIZE = 25

up, right, down, left = false, false, false, false

snake_length = 0
status = { run = 'running', stop = 'pause', game_over = 'game over' }
mode = status.run

function set_point()
    math.randomseed(os.time())
    pointX = math.random(POINT_SIZE-1)
    pointY = math.random(POINT_SIZE-1)
end


function draw_game()
    love.graphics.setColor( 1, 1, 1, 1 )
    love.graphics.print("SCORE: ".. snake_length, 10, 10)

    love.graphics.setColor( .58, .13, .55, 1 )
    love.graphics.rectangle("fill", snakeX*POINT_SIZE, snakeY*POINT_SIZE, 25, 25, 5, 5)
    
    love.graphics.setColor( .72, .29, .62, 1 )
    for _, v in ipairs(snake) do
        love.graphics.rectangle("fill", v[1]*POINT_SIZE, v[2]*POINT_SIZE, 25, 25, 10, 10)
    end

    love.graphics.setColor( .2, .73, .18, 1 )
    love.graphics.rectangle("fill", pointX*POINT_SIZE, pointY*POINT_SIZE, 25, 25, 5, 5)
end


function update_move()
    local prevX = snakeX
    local prevY = snakeY

    if directionY == 0 and up then 
        directionX, directionY = 0, -1
    elseif directionX == 0 and right then
        directionX, directionY = 1, 0
    elseif directionY == 0 and down then
        directionX, directionY = 0, 1
    elseif directionX == 0 and left then
        directionX, directionY = -1, 0
    end
    

    snakeX = snakeX + directionX
    snakeY = snakeY + directionY

    if snakeY < 0 then
        snakeY = POINT_SIZE - 1
    elseif snakeX > POINT_SIZE - 1 then
        snakeX = 0
    elseif snakeX < 0 then
        snakeX = POINT_SIZE - 1
    elseif snakeY > POINT_SIZE-1 then
        snakeY = 0
    end

 
    if pointX == snakeX and pointY == snakeY then
        set_point()
        snake_length = snake_length + 1
        table.insert( snake, {0, 0} )
    end

    
    if snake_length > 0 then
        for _, v in ipairs(snake) do
            local newX, newY = v[1], v[2]
            v[1], v[2] = prevX, prevY
            prevX, prevY = newX, newY
        end
    end

    for _, v in ipairs(snake) do
        if snakeX == v[1] and snakeY == v[2] then
            mode = status.game_over
        end
    end
end


function restart_game()
    directionX, directionY = 0, 0
    snakeX, snakeY = 12, 12
    snake_length = 0
    snake = {}
    up, right, down, left = false, false, false, false
    mode = status.run
    set_point()
end