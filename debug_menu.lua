local debug = {}

local debugMode = false
local seleccion = 0
local menus = {
  {"","","",""},
  {"","","",""},
  {"","","",""}
}

function debug.enable()
  debugMode = true
end

function debug.isEnable()
  return debugMode
end

function debug.disable()
  debugMode = false
end

function debug.draw()
  if debugMode then
    love.graphics.setColor(0,0,100/255)
    love.graphics.rectangle("fill",50,50,250,400)
    love.graphics.setColor(1,1,1)
  end
end

return debug