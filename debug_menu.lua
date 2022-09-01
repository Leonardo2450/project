local debug = {}
local seleccion = {1,1} --Menu | opcion
local debugOptions = {
  debugMode = false,
  debugMessages = false,
  debugMapTiles = false,
  debugGrid = false
}

local menu = {
  x = 50,
  y = 50,
  w = 250,
  h = 400,
  entries = {
    {{txt = "GOTO MAP/CAMERA MENU", func = function() debug.nextMenu(2) end},{txt = "GOTO ENTITIES MENU", func = function() debug.nextMenu(3) end},{txt = "ENABLE DEBUG MESSAGES", func = function() debug.changeState("debugMessages") end}},
    {{txt = "SHOW GRID", func = function() debug.changeState("debugGrid") end},{txt = "SHOW TILE ATTRIBUTES"},{txt = "CREATE A NEW MAP"},{txt = "EDIT MAP"},{txt = "LOAD MAP"},{txt = "SAVE MAP"}},
    {{txt = "SHOW COORDS"},{txt = "SHOW LIFE"},{txt = "SHOW ATTRIBUTES"}},
  },
  maintext = {"DEBUG - MAIN MENU","DEBUG - MAP/CAMERA","DEBUG - ENTITIES"}
}

function debug.message(text)
  if debug.FeatureIsEnable("debugMessages") then
    print("[DEBUG]"..text)
  end
end

function debug.nextSelection(opt)
  if debug.isEnable() then
    debug.message("Seleccion actual: "..seleccion[2])
    if opt == "+" and seleccion[2] ~= 1 then
      seleccion[2] = seleccion[2] - 1
    elseif opt == "-" and seleccion[2] ~= #menu.entries[ seleccion[1] ] then
      seleccion[2] = seleccion[2] + 1
    end
  end
end

function debug.nextMenu(menu)
  debug.message("Pasando al sub-menu: "..seleccion[2])
  seleccion[1] = menu
end

--Llama a la funciones de las entradas del menu
function debug.execEntryFunc()
  if menu.entries[ seleccion[1] ][ seleccion[2] ].func then
    menu.entries[ seleccion[1] ][ seleccion[2] ].func()
    debug.message("Se ha activado/desactivado la funcion: "..menu.entries[ seleccion[1] ][ seleccion[2] ].txt)
  else
    debug.message("[ERROR]NO existe la funciona que desea activar/desactivar")
  end
  
end

--Activa o desactiva el modo debug
function debug.enable()
  debugOptions.debugMode = true
  debug.nextMenu(1)
end

function debug.disable()
  debugOptions.debugMode = false
end

--Activa o desactiva opciones de debug
function debug.changeState(option)
  if debugOptions[option] == true then
    debugOptions[option] = false
  else
    debugOptions[option] = true
  end
end

--Verifica si el debug mode esta activo
function debug.isEnable()
  return debugOptions.debugMode
end

--Verifica las opciones de debug
function debug.FeatureIsEnable(option)
  return debugOptions[option]
end

--Dibuja el menu de debug
function debug.draw()
  
  local function drawmenu()
    love.graphics.setColor(0,0,100/255)
    love.graphics.rectangle("fill",50,50,250,400)
    love.graphics.setColor(1,1,1)
    love.graphics.print(menu.maintext[ seleccion[1] ],menu.x,menu.y,0,2,2)
    for i=1,#menu.entries[ seleccion[1] ] do
      if i == seleccion[2] then
        love.graphics.print("[ "..menu.entries[ seleccion[1] ][ i ].txt.." ]",menu.x,menu.y+25*i)
      else
        love.graphics.print(menu.entries[ seleccion[1] ][ i ].txt,menu.x,menu.y+25*i)
      end
    end
  end
  
  if debug.isEnable() then
    drawmenu()
  end
end

return debug