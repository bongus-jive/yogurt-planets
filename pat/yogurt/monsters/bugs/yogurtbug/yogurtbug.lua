require "/monsters/bugs/bug.lua"

pat_yogurtbug = {}
local bug = pat_yogurtbug

function bug:init()
  setmetatable(self, { __index = config.getParameter("yogurtBug") })

  self.projectile.parameters.powerMultiplier = root.evalFunction("monsterLevelPowerMultiplier", monster.level()) * status.stat("powerMultiplier")

  self:resetTimer()
end

function bug:update(dt)
  if self.timer > 0 then
    self.timer = self.timer - dt
  else
    self:resetTimer()
    self:spawnProjectile()
  end
end

function bug:resetTimer()
  self.timer = util.randomInRange(self.timerRange)
end

function bug:spawnProjectile()
  local pos = mcontroller.position()
  local dir = self:directionToPlayer(pos)

  world.spawnProjectile(self.projectile.type, pos, entity.id(), dir, nil, self.projectile.parameters)
end

function bug:directionToPlayer(pos)
  local player = world.playerQuery(pos, self.queryRange, self.queryOptions)[1]
  if not player then return end

  local playerPos = world.entityPosition(player)
  if not playerPos then return end
  
  local distance = world.distance(playerPos, pos)
  return vec2.norm(distance)
end

local _init, _update = init, update
function init() _init() bug:init() end
function update(dt) _update(dt) bug:update(dt) end
