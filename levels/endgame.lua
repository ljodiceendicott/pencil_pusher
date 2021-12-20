

local H = love.graphics.getHeight()
local W = love.graphics.getWidth()
local T = {}



function T.load()
end

function T.draw()
  love.graphics.print("Time Survive: "..timealive, 20,20)
end

function T.update(dt)
   if love.keyboard.isDown("escape") then
     state = 1
   end
end

return T
