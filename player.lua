require("projectile")
require("main")

local dimensions = {}
dimensions.H = love.graphics.getHeight()
dimensions.W = love.graphics.getWidth()

local firetimer = {}
firetimer.trigger = .25
firetimer.time = 0

local animationtimer = {}
animationtimer.frameNum = 1
animationtimer.currframe = 1
animationtimer.fps = .2
animationtimer.time = 0



local player={}
function player.load()
player.id = "player"
player.w = 15
player.h = 20
player.x = dimensions.W/2
player.y = dimensions.H/2
player.dx = 0
player.dy = 0
player.direction = 1
player.lives = 3
player.firespeed =15
player.iswalking = true
player.animation = {}

-- table.insert(player.animation, love.graphics.newImage("assets/player_animations/no_anim_0.png"))
for i = 1, 4 do
table.insert(player.animation, love.graphics.newImage("assets/player_animations/run_".. i-1 ..".png"))
end

table.insert(player.animation, love.graphics.newImage("assets/player_animations/no_anim_0.png"))
--in player.animation, 2-5 are idle  are running

end
function player.draw()
  love.graphics.setColor({1,1,1,1})

  love.graphics.draw(player.animation[animationtimer.currframe], player.x, player.y+player.h/2,0,player.direction*2,2,player.w/2,player.h/2)
end

local function firerate(dt)
firetimer.time = firetimer.time + dt
if(firetimer.time>firetimer.trigger) then
  firetimer.time = firetimer.time - firetimer.trigger
  return true;
else
  return false
end
end

function player.update(dt)
--animations
if player.iswalking then
  animationtimer.time = animationtimer.time + dt
    if animationtimer.time>animationtimer.fps then
      animationtimer.time = animationtimer.time- animationtimer.fps
      if animationtimer.currframe >= 4 then
        animationtimer.currframe =1
      else
        animationtimer.currframe = animationtimer.currframe + 1
      end
    end
  end
  if  not love.keyboard.isDown("w") and not love.keyboard.isDown("a") and not love.keyboard.isDown("s") and not love.keyboard.isDown("d") then
    player.iswalking = false
    animationtimer.currframe = 5
  else
    player.iswalking = true
  end

  --Movement
  --  LEFT KEY
    if (love.keyboard.isDown("a")) then
        player.direction = -1
        player.iswalking = true
        if (player.x > (W * 0.1)) then
            if (love.keyboard.isDown("w") or love.keyboard.isDown("s")) then
              player.x = player.x - (200 * dt * .59)
            end
            if (not love.keyboard.isDown("w") and not love.keyboard.isDown("s")) then
              player.x = player.x - (200 * dt)
            end
        end
    end
    -- RIGHT PLAYER KEYf
    if (love.keyboard.isDown("d")) then
        player.direction = 1
        player.iswalking = true
        if (player.x < (W * 0.9)) then
            if (love.keyboard.isDown("w") or love.keyboard.isDown("s")) then
               player.x = player.x + (200 * dt * .59)
            end
            if (not love.keyboard.isDown("w") and not love.keyboard.isDown("s")) then
                player.x = player.x + (200 * dt)
            end
        end
    end
    if (love.keyboard.isDown("w")) then
        player.iswalking = true
        if player.y > (H *.1) then
        if (love.keyboard.isDown("a") or love.keyboard.isDown("d")) then
            player.y = player.y - (200 * dt * .59)
        end
        if (not love.keyboard.isDown("a") and not love.keyboard.isDown("d")) then
            player.y = player.y - (200 * dt)
        end
      end
    end
    if (love.keyboard.isDown("s")) then
        player.iswalking = true
        if player.y < (H *.9) then
        if (love.keyboard.isDown("a") or love.keyboard.isDown("d")) then
            player.y = player.y + (200 * dt * .59)
        end
        if (not love.keyboard.isDown("a") and not love.keyboard.isDown("d")) then
            player.y = player.y + (200 * dt)
        end
      end
    end

-- fire Projectile
if firerate(dt) then
    if love.keyboard.isDown("up") then
      makeProj(player.x+(player.w/2)-10,player.y,0,-player.firespeed,true)
    elseif love.keyboard.isDown("down") then
      makeProj(player.x+(player.w/2),player.y+35,0,player.firespeed,true,3.14159)
    elseif love.keyboard.isDown("left") then
      makeProj(player.x+(player.w/2)-10,player.y+25,-player.firespeed,0,true,4.71239)
    elseif love.keyboard.isDown("right") then
      makeProj(player.x+20,player.y+25,player.firespeed,0,true,1.5708)
    end
  end
end
return player
