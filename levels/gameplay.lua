local gstate = require("gamestate")
local player = require("player")
local projectile = require("projectile")
require("enemy")

local scoretimer = {}
scoretimer.fps = 0.01
scoretimer.time = 0

local test = {}
test.testtext= ""

local T = {}
enemy= {}
function levelStart()
  if #enemy>0 then
    for i =1 ,#enemy do
      table.remove(enemy,i)
    end
  end
  for i = 1, 9 do
    enemy[i]= makeenemy(love.math.random(0,W),20*i,20,20,"melee")
  end
  scoretimer.time = 0
  player.lives = 3
end

function T.load()
bullyhurt = love.audio.newSource("assets/sounds/bullyhurt.wav", "static")
playerhurt = love.audio.newSource("assets/sounds/ouch.wav", "static")
player.load()
levelStart()
-- for i =3, 6 do
--   wave_one[i]= makeenemy(40*i,30,20,20,"range")
-- end
end

function T.draw()
    player.draw()
    for i = 1, #enemy do
      enemy[i].draw()
    end
    if scoretimer.time == 0 then
      player.lives = 3
    end
    seconds = math.floor(scoretimer.time)
    minutes = math.floor(seconds /60)
    if minutes <10 then
      minutes = "0" .. minutes
    end
    seconds = seconds % 60
    if seconds <10 then
      seconds = "0" .. seconds
    end
    love.graphics.setColor(1,1,1,.5)
    love.graphics.draw(img,0,0)
    love.graphics.setColor(0,1,1)
    timealive = minutes .. ":" .. seconds
    love.graphics.print(timealive, W/2,20)
    love.graphics.print("Lives" .. player.lives,W/2, 40)

    love.graphics.setColor({1,1,1,1})
    if #projectile_player > 0 then
      for i=1, #projectile_player do
        projectile_player[i].draw()
      end
    end
    if #projectile_enemy > 0 then
      for i=1, #projectile_enemy do
        projectile_enemy[i].draw()
      end
    end
end

function T.update(dt)
  if player.lives>0 then
    scoretimer.time = scoretimer.time + dt
  end
  player.update(dt)
if player.lives ==0 then
  if love.keyboard.isDown("r") then
    levelStart()
  end
end
  for i = 1, #enemy do
    if isCollided(player,enemy[i]) then
      enemy[i].x =10
      if player.lives>1 then
      player.lives = player.lives -1
      playerhurt:play()
      else
        --game over
        state = 5
        player.time = timealive
      end
    end
    enemy[i].update(dt)
  end
  -- e2.update(dt)
  if #projectile_player > 0 then
    for i=1, #projectile_player do
      projectile_player[i].update()
    end
  end
  if #projectile_enemy > 0 then
    for i=1, #projectile_enemy do
      projectile_enemy[i].update()
    end
  end
  if #projectile_player > 0 then
    for j=1, #projectile_player do
      for i = 1, #enemy do
        if isshot(enemy[i],projectile_player[j]) then
          enemy[i].health = enemy[i].health-1
          if enemy[i].health<1 then
              bullyhurt:play()
            enemy[i].respawntimes = enemy[i].respawntimes + 1
            enemy[i].speed = enemy[i].speed + .05
            --randomizes the enemy's X value relative to the player's X
              direction = love.math.random(1,100)
              xvalue = love.math.random(1,100)
              if xvalue % 2 == 1 then
                xFromPlayer = love.math.random(0,W/2)
              else
                xFromPlayer = love.math.random(W/2,W)
              end
            --randomizes the enemy's X value relative to the player's X
            yvalue = love.math.random(1,100)
              if yvalue % 2 ==1 then
                yFromPlayer = love.math.random(0,H/2)
              else
                yFromPlayer = love.math.random(H/2,H)
              end
              enemy[i].x = xFromPlayer
              enemy[i].y = yFromPlayer
              enemy[i].speed = enemy[i].speed +15
              --make the x value be random
            -- enemy[i].isalive = false
            -- enemy[i] = nil
          end
        end
      end
    end
  end
end
return T
