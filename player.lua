player = {}

function player:new(x, y, height, width, speed)
  local p = {
      x = x,
      y = y,
      height = height or 20, -- valor por defecto
      width = width or 20,
      speed = speed or 200,
      -- ahora imágenes... muchas!
      standingRight = love.graphics.newImage('sprites/mario_standing_right.png'),
      movingRight = love.graphics.newImage('sprites/mario_moving_right.png'),
      standingLeft = love.graphics.newImage('sprites/mario_standing_left.png'),
      movingLeft = love.graphics.newImage('sprites/mario_moving_left.png'),
      -- and the movement flags
      left = true,
      right = false,
      grounded = false,
  }
  setmetatable(p, {__index = player})
  return p
end

function player:update(dt)
  -- movimiento del jugador
  -- maybe change up key to only pressed once https://love2d.org/wiki/love.keypressed
  if love.keyboard.isDown('up')then
    io.write("key pressed: up\n")
    self.y = self.y - self.speed * dt
  end
  -- solo podemos movernos abajo si no estamos en una plataforma
  if love.keyboard.isDown('down') and self.grounded == false then
    io.write("key pressed: down\n")
    self.y = self.y + self.speed * dt
  end
  if love.keyboard.isDown('left') then
    io.write("key pressed: left\n")
    self.x = self.x - self.speed * dt
    self.left = true
    self.right = false
  end
  if love.keyboard.isDown('right') then
    io.write("key pressed: right\n")
    self.x = self.x + self.speed * dt
    self.right = true
    self.left = false
  end
  -- pseudogravedad
  if self.grounded == false then
    -- tenemos que disminuir la gravedad para que los saltos sean dinámicos,
    -- si no hay aceleración
    if love.keyboard.isDown('up') then
      self.y = self.y + 30 * dt
    else
      self.y = self.y + 70 * dt
    end
  end
end

function player:draw()
  -- si está en tierra
  if self.grounded == true then
    if self.left == true then
      love.graphics.draw(self.standingLeft, self.x, self.y, nil, 0.3, 0.3)
    elseif self.right == true then
      love.graphics.draw(self.standingRight, self.x, self.y, nil, 0.3, 0.3)
    else
      io.write("Error!!!\n")
    end
  -- si está en aire
  elseif self.grounded == false then
    if self.left == true then
      love.graphics.draw(self.movingLeft, self.x, self.y, nil, 0.3, 0.3)
    elseif self.right == true then
      love.graphics.draw(self.movingRight, self.x, self.y, nil, 0.3, 0.3)
    else
      io.write("Error!!!\n")
    end
  end
end

-- función que nos escribe las coordenadas del jugador en la consola
function player:log()
  io.write("player position is: "..self.x..", "..self.y.."\n")
end

-- nos da la coordenada y inferior del jugdor dependiendo de la imagen
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
