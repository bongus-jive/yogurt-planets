function die(smash)
  local proj = config.getParameter(smash and "smashProjectile" or "breakProjectile")

  if not proj or not proj.type then return end

  local pos = object.toAbsolutePosition(proj.offset or { 0, 0 })

  world.spawnProjectile(proj.type, pos, entity.id(), nil, nil, proj.parameters)
end
