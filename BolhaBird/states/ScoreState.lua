--[[
    ScoreState Class
    Author: Giovanni Pelloso Gasparetto
    giovanni_pelloso@hotmail.com

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
local medal = "bronze.png"

function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Perdeu! :(', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    medalModel(self.score)
    medalImage = love.graphics.newImage(medal)
    love.graphics.draw(medalImage, VIRTUAL_WIDTH/2 - 16, VIRTUAL_HEIGHT/2 - 24)    

    love.graphics.printf('Aperte Enter para jogar novamente!', 0, 160, VIRTUAL_WIDTH, 'center')
end

function medalModel(score)
    if score >= 10 and score < 20 then
        medal = "silver.png"
    elseif score >= 20 then
        medal = "gold.png"
    end    
end