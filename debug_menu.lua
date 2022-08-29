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
    {{txt = "GOTO MAP/CAMERA MENU"},{txt = "GOTO ENTITIES MENU"},{txt = "ENABLE DEBUG MESSAGES"}},
    {{txt = "/na"},{txt = "na/"},{txt = "n/a"}},
  },
  maintext = {"DEBUG - MAIN MENU","DEBUG - MAP/CAMERA","DEBUG - ENTITIES"}
}

function debug.message(text)
  if debug.MessagesAreEnable() then
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

--Disable or enable debug mode
function debug.enable()
  debugOptions.debugMode = true
end

function debug.disable()
  debugOptions.debugMode = false
end

--Checks for debug options
function debug.isEnable()
  return debugOptions.debugMode
end

function debug.MessagesAreEnable()
  return debugOptions.debugMessages
end

function debug.MapTilesIsEnable()
  return debugOptions.debugMapTiles
end

--Draw the debug menu
function debug.draw()
  if debug.isEnable() then
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
end

return debug