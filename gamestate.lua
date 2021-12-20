function isshot(entity, proj)
if isTouched(entity, proj) then
  proj.x = -50
  proj.y = -50
 if proj.isfriendly then
   if entity.id=="enemy" then
   return true
 end
end
if not proj.isfriendly then
  if entity.id=="player" then
  return true
  end
  end
return false
end
end

function isCollided(player, enemy)
  if isTouched(player,enemy) then
    return true
  end
  return false
end

function isTouched(playerobj,entityobj)
  local player = {}
  player.left = playerobj.x
  player.right = player.left+playerobj.w
  player.top = playerobj.y
  player.bottom = player.top+playerobj.h

  --object checking to see if it is hit
  local obj = {}
  obj.left = entityobj.x
  obj.right = obj.left+entityobj.w
  obj.top = entityobj.y
  obj.bottom = obj.top+entityobj.h

  if player.left <= obj.right and player.right >=obj.left and
  player.top <= obj.bottom and player.bottom >= obj.top then
    return true
  end
  return false
end

function gameOver()
  --this function ends the game and makes it possible to have the game be over
end

-- local T = {}
--
-- function T.draw()
--
-- end
--
-- function T.update()
--
-- end
--
-- return T
-- function isGameOver(player, obj)
--     local player = {}
--   player.left = player.x
--   player.right = pleft+player.w
--   player.top = player.y
--   player.bottom = ptop+playe.h
--
--
--     local obj= {}
--   obj.left = obj.x
--   obj.right = obj.left+obj.w
--   obj.top. = obj.y
--   obj.bottom = obj.top+obj.h
-- -- if the player and the enemy touch then the game will be over
--
-- end
