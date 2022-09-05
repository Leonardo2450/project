local camera = require("camera")
local debug = require("debug_menu")
local player = require("player")

local map_loader = {}

local tilesets = {}
local map = {}
local mapSize = 0
local mapScale = 2
local current_tool = 1

local tools = {"Pincel","Borrador","Propiedades"}

--Carga el mapa
function map_loader.loadMap(archivo)
  map = require(archivo)
  
  --TODO: Lista de tiles especiales. se podria crear una funcion especial
  for i,v in pairs(map) do
    for l,k in pairs(v) do

      --Spawn del jugador
      if k.PlayerSpawn ~= nil then 
        player:teleport(32*l,32*i)
      end
      
      --Verifica si es colisionable
      if k.isColliable ~= nil then

      end
    end
  end
  
end

--Crea un nuevo tileset y lo guarda
function map_loader.loadTileSet(img,size, name)
  local spriteSheet = love.graphics.newImage("tiles/"..img)
  local x = 0
  local y = 0
  local tileSet = {}
  for i=1, spriteSheet:getHeight() /size do
    for k = 1,spriteSheet:getWidth() /size do
      table.insert( tileSet,love.graphics.newQuad(x,y,size,size,spriteSheet:getDimensions()) )
      x = x + size
    end
    y = y + size
    x = 0
  end
  table.insert(tilesets,{tiles = tileSet,tileSheet = spriteSheet,size = size})
end

--Actualiza el mapa
function map_loader.update()
  print(#map)
end

--Crea un nuevo mapa
function map_loader.newMap(size)
  mapSize = size
  local x = {}
  for k=1,size do
    table.insert(x,{spr = 6,size = size})
  end

  for i=1,size do
    table.insert(map,x)
  end
  
  --TODO: añadir opcione en el menu de debug
  for i,v in pairs(map) do
    for l,k in pairs(v) do
      --print(l..": "..k.spr)
      --print(i.."|"..l)
    end
  end
  
end

--Regresa el tile por el cual se esta buscando
local function returnTile(numberTile)
  for i,v in pairs(tilesets) do
    for l,k in pairs(v.tiles) do
      --Si se encuentra devuelve la textura. De lo contrario devolver la última textura, una textura de error
      if (numberTile) == l then
        return v.tileSheet, k
      elseif numberTile > #v.tiles  then
        return v.tileSheet, v.tiles[#v.tiles]
      end
    end
    break
  end
end

--Muestra el mapa
function map_loader.drawMap()
  for i,v in pairs(map) do
    for l,k in pairs(v) do
      local img, quad = returnTile(k.spr)
      if k.owo then
        love.graphics.setColor(1,0,0)
      else
        love.graphics.setColor(1,1,1)
      end
      
      --Textura del tile
      love.graphics.draw(img,quad,0+((k.size*2)*l),0+((k.size*2)*i),0,2,2)
      
      --Muestra la cuadricula
      if debug.FeatureIsEnable("debugGrid") then
        love.graphics.rectangle("line",0+((k.size*2)*l),0+((k.size*2)*i),k.size*2,k.size*2)
        love.graphics.print(l.."|"..i,0+((k.size*2)*l),0+((k.size*2)*i))
      end
    end
  end
end

--Muestra la paleta de tiles
function map_loader.TileSets()
  for i,v in pairs(tilesets) do
    for l,k in pairs(v.tiles) do
      love.graphics.draw(v.tileSheet,k,0+((v.size*2)*(l-1)),0,0,2,2)
    end
  end
end

function  map_loader.editMap( ... )
  if tools[current_tool] == tools[1] then
    print("EDITANDO")
  end
end

--TODO: revisa la lista de objetos en el mapa
function map_loader.readListItems()
  
end

--TODO: revisa la lista de enemigos en el mapa
function map_loader.readEnemyList()
  
end

--TODO: guarda el mapa creado
function map_loader.saveMap(archivo)
  love.filesystem.write(archivo,"")
  love.filesystem.append(archivo,"return {")
  for i,v in pairs(map) do
    love.filesystem.append(archivo,"{")
    for l,k in pairs(v) do
      if l ~= #v then 
        love.filesystem.append(archivo,"{spr = "..k.spr..",size = "..k.size.."},")
      else
        love.filesystem.append(archivo,"{spr = "..k.spr..",size = "..k.size.."}")
      end
    end
    if i ~= #v then 
      love.filesystem.append(archivo,"},\r")
    else
      love.filesystem.append(archivo,"}\r")
    end
  end
  love.filesystem.append(archivo,"}")
end

return map_loader