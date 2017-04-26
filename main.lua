require "player"
require "platform"

-- definimos constantes globales
WINDOW_HEIGHT = love.graphics.getHeight()
WINDOW_WIDTH = love.graphics.getWidth()

-- creamos los objetos del juego
function love.load()
  -- cargamos la imagen del fondo
  background = love.graphics.newImage('sprites/background.png')
  -- creamos el jugador y la plataforma
  player = player:new(WINDOW_WIDTH/2, WINDOW_HEIGHT/2 - 40)
  platform = platform:new(0, WINDOW_HEIGHT/2)
end

-- lógica interna del juego, que cambia con cada frame dt
function love.update(dt)

  -- se sale del juego con ESC
  if love.keyboard.isDown('escape') then
    love.event.quit()
  end
  
  -- actualizamos la lógica del jugador
  player:update(dt)
  
  -- comprobamos las colisiones con la plataforma
  io.write("platform 1 surface: "..platform:surface().."\n")
  io.write("player bottom: "..player:bottom().."\n")
    if platform:surface() <= player:bottom() then
      player.grounded = true
      io.write("player grounded\n")
    else
      player.grounded = false
    end
end

function love.draw()
  -- dibujamos primero el fondo, para que esté detrás, escalado al tamaño de pantalla
  for i = 0, WINDOW_WIDTH / background:getWidth() do
    for j = 0, WINDOW_HEIGHT / background:getHeight() do
      love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
    end
  end
  -- dibujamos la plataforma
  platform:draw()
  -- dibujamos al jugador y su posición
  player:draw()
  player:log()
end