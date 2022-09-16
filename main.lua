love.graphics.setDefaultFilter("nearest","nearest")
local map_manager = require("map_loader")
local debug = require("debug_menu")
local player = require("player")
local controls = require("controls")
local camera = require("camera")
local rs = require("resolution_solution")

--Inicia Resolution solution
rs.setGame(800, 600)
rs.scaleMode = 1

function love.load()
  map_manager.loadTileSet("test.png",16, "PRUEB")
  --map_manager.newMap(16)
  --map_manager.saveMap("TABLA.lua")
  map_manager.loadMap("XD")
end

function love.update(dt)
  player:update_spr(dt)
  local x,y = player:getSprCoords()
  local w,h = rs.getGame()
  x = x -(w/2) +16
  y = y - (h/2) +16
  
  map_manager.update()
  rs.update()
  camera:setPosition(x,y)
end

function love.draw()
  rs.start()
  camera:set()
  love.graphics.setBackgroundColor(0,0,1)
  map_manager.drawMap()
  player:draw()
  camera:unset()
  debug.draw()
  rs.stop()
  --map_manager.TileSets()
end