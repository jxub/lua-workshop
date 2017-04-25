require "player"
require "platform"

function love.load()
  player = player:new()
  platform = platform:new()
end


function love.update(dt)

end

function love.draw()
  love.graphics.print("Hello", 500, 500)
end