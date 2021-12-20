H = love.graphics.getHeight()
W = love.graphics.getWidth()
projectile_player = {}
projectile_enemy = {}

local anomtimer = {}
anomtimer.fps = 30
anomtimer.time = 0
anomtimer.frame = 1

function makeProj(x,y,dx,dy,isfriendly,r)
local proj={}
proj.img = love.graphics.newImage("assets/pencil.png")
proj.id = "proj"
proj.w = 9
proj.h = 10
proj.x = x
proj.y = y
proj.dx = dx
proj.dy = dy
proj.isfriendly = isfriendly
proj.r = r


function proj.draw()
love.graphics.draw(proj.img,proj.x,proj.y,proj.r,.75)
-- love.graphics.rectangle("fill", proj.x, proj.y,proj.w, proj.h)
  -- if proj.isfriendly then
  --   love.graphics.setColor({1,1,0,.5})
  -- else
  --   love.graphics.setColor({1,0,0,.5})
  -- end
  -- love.graphics.rectangle("fill", proj.x, proj.y, proj.w, proj.h)
end

function proj.update(dt)
  proj.x = proj.x+proj.dx
  proj.y = proj.y+proj.dy
end

if proj.isfriendly then
table.insert(projectile_player,proj)
else
  table.insert(projectile_enemy,proj)
end
end
