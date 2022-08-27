love.graphics.setDefaultFilter("nearest","nearest")
local map_manager = require("map_loader")
local debug = require("debug_menu")
local player = require("player")
local controls = require("controls")
local rs = require("resolution_solution")

rs.setGame(800, 600)
rs.scaleMode = 1

function love.load()
  map_manager.loadTileSet("test.png",16, "PRUEB")
  --map_manager.newMap(16)
  --map_manager.saveMap("TABLA.lua")
  map_manager.loadMap("XD")
end

function love.update()
  rs.update()
end

function love.draw()
  rs.start()
  love.graphics.setBackgroundColor(0,0,1)
  map_manager.drawMap()
  debug.draw()
  player:draw()
  rs.stop()
  --map_manager.TileSets()
end