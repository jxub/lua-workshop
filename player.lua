player = {}

function player:new(x, y, height, width, speed)
  local p = {
      x = x,
      y = y,
      height = height or 20,
      width = width or 20,
      speed = speed or 200,
      -- now the images... lots of them!
      standingRight = love.graphics.newImage('sprites/mario_standing_right.png'),
      movingRight = love.graphics.newImage('sprites/mario_moving_right.png'),
      rightOther = love.graphics.newImage('sprites/mario_other_right.png'),
      standingLeft = love.graphics.newImage('sprites/mario_standing_left.png'),
      movingLeft = love.graphics.newImage('sprites/mario_moving_left.png'),
      leftOther = love.graphics.newImage('sprites/mario_other_left.png'),
      -- and the movement flags
      left = true,
      right = false,
      grounded = false,
      moving = false,
      -- el pulso lo usamos para animar los sprites
      timer = 0,
      heartbeat = false,
  }
  setmetatable(p, {__index = player})
  return p
end

function player:update(dt)
  -- movimiento del jugador
  -- change up key to only pressed once https://love2d.org/wiki/love.keypressed
  if love.keyboard.isDown('up' or 'w')then
    io.write("key pressed: up\n")
    self.y = self.y - self.speed * dt
  end
  -- solo podemos movernos abajo si no estamos en una plataforma
  if love.keyboard.isDown('down' or 's') and self.grounded == false then
    io.write("key pressed: down\n")
    self.y = self.y + self.speed * dt
  end
  if love.keyboard.isDown('left' or 'a') then
    io.write("key pressed: left\n")
    self.x = self.x - self.speed * dt
    self.left = true
    self.right = false
  end
  if love.keyboard.isDown('right' or 'd') then
    io.write("key pressed: right\n")
    self.x = self.x + self.speed * dt
    self.right = true
    self.left = false
  end
  -- pseudogravedad
  if self.grounded == false then
    -- tenemos que disminuir la gravedad para que los saltos sean dinámicos,
    -- si no hay aceleración
    if love.keyboard.isDown('up' or 'w') then
      self.y = self.y + 30 * dt
    else
      self.y = self.y + 70 * dt
    end
  end
  -- actualizamos el pulso del jugador cada n frames
  self.timer = self.timer + 1
  if self.timer >= 10 then
    self.heartbeat = true
    self.timer = 0
  end
  io.write("self.timer: "..self.timer.." dt: "..dt.."\n")
end

function player:draw()
  -- si está en tierra
  if self.grounded == true then
    if self.heartbeat == true then
      if self.left == true then
        love.graphics.draw(self.standingLeft, self.x, self.y, nil, 0.3, 0.3)
      elseif self.right == true then
        love.graphics.draw(self.standingRight, self.x, self.y, nil, 0.3, 0.3)
      end
    elseif self.heartbeat == false then
      if self.left == true then
        love.graphics.draw(self.leftOther, self.x, self.y, nil, 0.3, 0.3)
      elseif self.right == true then
        love.graphics.draw(self.rightOther, self.x, self.y, nil, 0.3, 0.3)
      end
    else
      io.write("Error!!!\n")
    end
  -- si está en aire
  elseif self.grounded == false then
    if self.left == true then
      love.graphics.draw(self.movingLeft, self.x, self.y, nil, 0.3, 0.3)
    else
      love.graphics.draw(self.movingRight, self.x, self.y, nil, 0.3, 0.3)
    end
  end
end

function player:log()
  io.write("player position is: "..self.x..", "..self.y.."\n")
end

function player:bottom()
  if self.grounded == true then
    if self.left == true then
      return math.floor(self.y - self.standingLeft:getHeight() + 220) -- no tengo ni idea de esto , pero funciona;)
    else
      return math.floor(self.y - self.standingRight:getHeight() + 220)
    end
  else
    if self.left == true then
      return math.floor(self.y - self.movingLeft:getHeight() + 220)
    else
      return math.floor(self.y - self.movingRight:getHeight() + 220)
    end
  end
end
