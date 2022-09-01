local camera = {}
--Credit: Michael Ebens

camera.x = 0
camera.y = 0
camera.zoom = 1
camera.rotacion = 0

function camera:set()
  love.graphics.push()
  love.graphics.scale(1 / self.zoom, 1 / self.zoom)
  love.graphics.translate(-self.x, -self.y)
end

function camera:unset()
  love.graphics.pop()
end

function camera:move(x,y)
  self.x = self.x + x
  self.y = self.y + x
end

function camera:setPosition(x, y)
  self.x = x
  self.y = y
end

return camera