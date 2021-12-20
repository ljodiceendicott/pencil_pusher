require("projectile")
local levels = {}

state = 1

local H = love.graphics.getHeight()
local W = love.graphics.getWidth()




function love.load()
  gamestate = require("gamestate")
  map= require("levels/gameplay")
  map.load()
  mainmenu = require("levels/mainmenu")
  mainmenu.load()
  --
  credits = require("levels/credits")
  controls = require("levels/controls")
  endgame = require("levels/endgame")
  img = love.graphics.newImage("levels/level.png")

  mainscr = love.graphics.newImage("levels/main.png")
  creditscr = love.graphics.newImage("levels/credits.png")
  controlscr = love.graphics.newImage("levels/controls.png")
  endgamescr = love.graphics.newImage("levels/endscreen.png")

  menusound = love.audio.newSource("assets/sounds/menusound.wav", "stream")
  ingamesound = love.audio.newSource("assets/sounds/ingamesound.wav", "stream")
  -- lose = love.audio.newSource("lose.wav", "static")
  -- hurt = love.audio.newSource("bullyhurt.wav","statics")
  -- entergame = love.audio.newSource("entergame.wav", "static")
end

function love.draw()

  if state == 1 then
    -- mainmenu.draw()
    love.graphics.draw(mainscr,0,0)
  elseif state == 2 then
    map.draw()
  elseif state == 3 then
    love.graphics.draw(controlscr,0,0)
  elseif state == 4 then
    --credits
    love.graphics.draw(creditscr,0,0)
elseif state == 5 then
    love.graphics.draw(endgamescr,0,0)
    love.graphics.print("Time Survived:"..timealive,30,20,0,2,2)
  end
end

function love.update(dt)
  if state ==1 then
    mainmenu.update(dt)
elseif state == 2 then
  map.update(dt)
elseif state == 3 then
  controls.update(dt)
elseif state == 4 then
  credits.update(dt)
elseif state == 5 then
  endgame.update(dt)
end

if state ==1 then
  menusound:play()
  menusound:setVolume(.5)
else
  menusound:stop()
end

if state == 2 then
ingamesound:play()
ingamesound:setVolume(.5)
else
ingamesound:stop()
end


end
