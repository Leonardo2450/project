local debug = require("debug_menu")
local player = require("player")

local controls = {
  key_e = "e", --Unidad siguiente
  key_q = "q", -- Unidad anterior
  key_a = "a", --???
  key_w = "w", --???
  key_s = "s", --???
  key_d = "d", --???
  key_espacio = "space" --Atacar
}

--a futuro cuando tenga un menu :P
--[[function controls:iniciar()
  if love.filesystem.getInfo("controls") == nil then
    print("NO EXISTE. Creando archivo...")
    love.filesystem.write("controls","ga")
  else
    print("Existe. Archivo cargado")
  end
end

function controls:modificar()
  
end]]

--Functions for keybinding in the future
function controls:funcion_key_e()

end

function controls:funcion_key_q()

end

function controls:funcion_key_a()

end

function controls:funcion_key_w()
end

function controls:funcion_key_s()
end

function controls:funcion_key_d()

end

controls.funcion_key_space = function(self)
  if debug.isEnable() then
    debug.execEntryFunc()
  end
end

function love.keypressed(key)
  debug.message("Tecla presiona: "..key)
  
  if not debug.isEnable() then
    player:movement(key)
  end
  if key == "up" then
    debug.nextSelection("+")
  elseif key == "down" then
    debug.nextSelection("-")
  elseif key == controls.key_espacio then
    
    controls:funcion_key_space()
    
  --Activa el menu de debug
  elseif key == "f1" then
    
    if debug.isEnable() then
      debug.disable()
    else
      debug.enable()
    end
    
  --Close the game (temporal)
  elseif key == "escape" then
    love.event.quit()
  end
end

return controls