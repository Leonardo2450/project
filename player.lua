local player = {}
player.x = 0
player.y = 0
player.h = 32
player.w = 32
player.velocity = 200
player.sprX = 0
player.sprY = 0
player.spr = love.graphics.newImage("spr/player.png")
player.view = "up"

--Dibuja al jugador
function player:draw()
  love.graphics.draw(self.spr,self.sprX,self.sprY,0,2,2)
end

--Permite interactuar con los tiles del mapa
function player:action( ... )
  
end

function player:getCoords()
  return self.x, self.y
end

function player:getSprCoords()
  return self.sprX, self.sprY
end

--Teletransporta el jugador a las coordenadas
function player:teleport(x,y)
  player.x = x
  player.y = y
  player.sprX = x
  player.sprY = y
end


--Actualiza la posicion del sprite
function player:update_spr(dt)
  if self.sprX ~= self.x then
    if self.x + 5 > self.sprX and self.x - 5 < self.sprX then
      self.sprX = self.x
    elseif self.x > self.sprX then
      self.sprX = self.sprX + (self.velocity * dt)
    elseif player.x < player.sprX then
      self.sprX = self.sprX - (self.velocity * dt)
    end
  end
  
  if self.sprY ~= self.y then
    if self.y + 5 > self.sprY and self.y - 5 < self.sprY then
      self.sprY = self.y
    elseif self.y > self.sprY then
      self.sprY = self.sprY + (self.velocity *dt)
    elseif self.y < self.sprY then
      self.sprY = self.sprY - (self.velocity *dt)
    end
  end
  
end

function player:movement(dir)
  if dir == "right" then
    self.x = self.x + 32 
  elseif dir == "left" then
    self.x = self.x - 32
  elseif dir == "up" then
    self.y = self.y - 32
  elseif dir == "down" then
    self.y = self.y + 32
  end
  self.view = dir
end

return player