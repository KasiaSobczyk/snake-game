require('game')

function love.load()
    interval = 18
    set_point()
end


function love.draw()
    draw_game()
    if mode == status.game_over then
        love.graphics.print("GAME OVER", 130, 220, 0, 5, 5)
        love.graphics.print("Press space to restart ", 180, 350, 0, 2, 2)
    end
end


function love.update()
    if mode == status.run then
        interval = interval - 1
        if interval < 0 then
            update_move()
            if snake_length <= 3 then
                interval = 18
            elseif snake_length > 3 and snake_length <= 8 then
                interval = 15
            elseif snake_length > 8 and snake_length <= 12 then
                interval = 10
            elseif snake_length > 12 and snake_length <= 16 then
                interval = 7    
            else 
                interval = 4    
            end
        end   
    end
end


function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'up' and mode == status.run then
        up, right, down, left = true, false, false, false    
    elseif key == 'right' and mode == status.run then
        up, right, down, left = false, true, false, false
    elseif key == 'down' and mode == status.run then
        up, right, down, left = false, false, true, false    
    elseif key == 'left' and mode == status.run then
        up, right, down, left = false, false, false, true 
    elseif key == 'p' then
        if mode == status.run then
            mode = status.stop
        else 
            mode = status.run
        end
    elseif key == 'space' and mode == status.game_over then
        restart_game()   
    end
end