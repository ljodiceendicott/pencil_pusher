local H = love.graphics.getHeight()
local W = love.graphics.getWidth()
local T = {}



function T.load()
end

function T.draw()
--   love.graphics.setColor({1,1,1,1})
-- love.graphics.rectangle("fill", 0, 0,W,H)
-- love.graphics.setColor({0,0,0,1})
-- love.graphics.print("Width:"..W .. " Height:".. H)
end

function T.update(dt)
   if love.keyboard.isDown("e") then
     state = state + 1
     levelStart()
   end
   if love.keyboard.isDown("escape") then
     state = 1
   end
end

return T
