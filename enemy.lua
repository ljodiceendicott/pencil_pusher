local player = require("player")

local movetimer= {}
movetimer.fps = 0.01
movetimer.time = 0

local animationtimer = {}
animationtimer.fps = .6
animationtimer.time = 0
animationtimer.currframe= 2

local firetimer ={}
firetimer.time = 0
firetimer.rate = 2

local const = {}
const.speed = .65

function makeenemy(x,y,w,h,type)
local enemy = {}
enemy.id = "enemy"
enemy.x = x+ 4
enemy.y = y
enemy.w =w/2+4
enemy.h =h
enemy.direction = 1

enemy.midx = enemy.x+(enemy.w/2)
enemy.midy = enemy.y+(enemy.h/2)

enemy.respawntimes= 18
enemy.respawndist = -25
enemy.projectile ={}
enemy.speed = const.speed
enemy.type = type
enemy.isdead = false
enemy.health = 3
enemy.animation= {}

for i = 1, 4 do
table.insert(enemy.animation, love.graphics.newImage("assets/enemy_animations/run_".. i-1 ..".png"))
end

function enemy.draw()
  --replace with an "enemy"
  love.graphics.setColor({1,1,1,1})
  love.graphics.draw(enemy.animation[animationtimer.currframe], enemy.x, enemy.y, 0,2,2)
end


function enemy.update(dt)
  movetimer.time = movetimer.time + dt
  if(movetimer.time>movetimer.fps) then
    movetimer.time = movetimer.time - movetimer.fps
    if enemy.type == "melee" then
    if enemy.x> player.x+(player.w/2) then
      enemy.x= enemy.x-const.speed
    end
    if enemy.x< player.x+(player.w/2) then
      enemy.x = enemy.x+const.speed
    end

    if enemy.y> player.y+ (player.h/2) then
      enemy.y= enemy.y-const.speed
    end
    if enemy.y< player.y+ (player.h/2) then
      enemy.y = enemy.y+const.speed
    end
  end

  animationtimer.time = animationtimer.time + dt
  if(animationtimer.time>animationtimer.fps) then
    animationtimer.time = animationtimer.time - animationtimer.fps
    if animationtimer.currframe == 4 then
      animationtimer.currframe = 1
    else
      animationtimer.currframe = animationtimer.currframe +1
    end
  end
end
end


return enemy
end
