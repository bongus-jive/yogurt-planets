local _die = die
function die()
  if _die then _die() end

  local proj = config.getParameter("deathProjectile")
  if not proj then return end
  
  for _ = 1, proj.count or 1 do
    local vec
    if proj.randomDirection then
      local angle = math.random() * math.pi * 2
      vec = {math.cos(angle), math.sin(angle)}
    end
    world.spawnProjectile(proj.type, mcontroller.position(), entity.id(), vec, nil, proj.parameters)
  end
end
