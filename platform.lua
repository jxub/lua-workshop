platform = {}

function platform:new(x, y, width, height, color)
  local pl = {
      x = x,
      y = y,     
      width = width or love.graphics.getWidth(),
      height = height or love.graphics.getHeight(),
      color = color or {255, 255, 255} --blanco por defecto
  }
  setmetatable(pl, {__index = platform})
  return pl
end

function platform:draw()
  love.graphics.setColor(self.color[1], self.color[2], self.color[3])
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function platform:surface()
  return self.y  -- returns the upper edge y coord
end