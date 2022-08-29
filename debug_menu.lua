local debug = {}
local seleccion = {1,1}
local debugOptions = {
  debugMode = false,
  debugMessages = false,
  debugMapTiles = false
}

local menu = {
  x = 50,
  y = 50,
  w = 250,
  h = 400,
  entries = {
    {{txt = "GOTO MAP/CAMERA MENU", func = function() debug.changeState("debugMessages") end },{txt = "GOTO ENTITIES MENU", func = function() debug.changeState("debugMessages") end},{txt = "ENABLE DEBUG MESSAGES", func = function() debug.changeState("debugMessages") end}},
    {{txt = "/na"},{txt = "na/"},{txt = "n/a"}},
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
    debug.message("SELECCION:: "..seleccion[2])
    if opt == "+" and seleccion[2] ~= 1 then
      seleccion[2] = seleccion[2] - 1
    elseif opt == "-" and seleccion[2] ~= #menu.entries[ seleccion[1] ] then
      seleccion[2] = seleccion[2] + 1
    end
  end
end

--Llama a la funciones de las entradas del menu
function debug.execEntryFunc()
  menu.entries[ seleccion[1] ][ seleccion[2] ].func()
  debug.message("Se ha activado/desactivado la funcion: "..menu.entries[ seleccion[1] ][ seleccion[2] ].txt)
end

--Activa o desactiva el modo debug
function debug.enable()
  debugOptions.debugMode = true
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