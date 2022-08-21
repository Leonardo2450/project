local map_manager = require("map_loader")

love.graphics.setDefaultFilter("nearest","nearest")

function love.load()
  map_manager.loadTileSet("test.png",16, "PRUEB")
  --map_manager.newMap(16)
  --map_manager.saveMap("TABLA.lua")
  map_manager.loadMap("XD")
end

function love.update()
  
end

function love.draw()
  love.graphics.setBackgroundColor(0,0,1)
  map_manager.drawMap()
  --map_manager.TileSets()
end