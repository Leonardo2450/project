local player = {}
player.x = 0
player.y = 0
player.h = 32
player.w = 32
player.spr = love.graphics.newImage("spr/player.png")
player.view = "up"

function player:draw()
  love.graphics.draw(self.spr,self.x,self.y,0,2,2)
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
end

return player