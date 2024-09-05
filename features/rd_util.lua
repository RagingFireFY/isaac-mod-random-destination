local rd_util = {}

local rd_where_to_show_enum = require("features.enum.rd_where_to_show_enum")

-- copy from liltimer
function rd_util:GetScreenSize(game)
  local room = game:GetRoom()
  local pos = room:WorldToScreenPosition(Vector(0, 0)) - room:GetRenderScrollOffset() - game.ScreenShakeOffset

  local rx = pos.X + 60 * 26 / 40
  local ry = pos.Y + 140 * (26 / 40)

  return Vector(rx * 2 + 13 * 26, ry * 2 + 7 * 26)
end

function rd_util:GetScreenCenter(game)
  return rd_util:GetScreenSize(game) / 2
end
-- copy from liltimer

function rd_util:getEntityID(entity)
  return tostring(entity.Type) .. "." .. tostring(entity.Variant) .. "." .. tostring(entity.SubType)
end

local chapter3MomBossIds = { "45.10.0", "45.10.1", "45.10.2" }
function rd_util:isChapter3MomBoss(inputEntityID)
  for _, v in ipairs(chapter3MomBossIds) do
    if v == inputEntityID then
      return true
    end
  end
  return false
end

function rd_util:getRNGSeed()
  for x = 1, 10 do
    local y = Random()
    if (y ~= 0 and y ~= 4294967296) then
      return y
    end
  end
  return 1234567890
end

-- copy from eid
function rd_util:getCurrentModPath()
  if debug then
    local modPath = string.sub(debug.getinfo(rd_util.getCurrentModPath).source, 2)
    modPath = string.gsub(modPath, "rd_util.lua", "")
    modPath = string.gsub(modPath, "\\", "/")
    modPath = modPath .. "../"
    return modPath
  end
  --use some very hacky trickery to get the path to this mod
  local _, err = pcall(require, "")
  local _, basePathStart = string.find(err, "no file '", 1)
  local _, modPathStart = string.find(err, "no file '", basePathStart)
  local modPathEnd, _ = string.find(err, ".lua'", modPathStart)
  local modPath = string.sub(err, modPathStart + 1, modPathEnd - 1)
  modPath = string.gsub(modPath, "\\", "/")
  modPath = string.gsub(modPath, "//", "/")
  modPath = string.gsub(modPath, ":/", ":\\")

  return modPath
end
-- copy from eid

function rd_util:showOnceInTheCenter(destinationText, f, game, mod)
  local function drawText()
    f:DrawStringUTF8(destinationText, rd_util:GetScreenCenter(game).X - f:GetStringWidthUTF8(destinationText) / 2,
      rd_util:GetScreenCenter(game).Y - f:GetLineHeight(), KColor(1, 1, 1, 1), 0, true)
  end

  mod:AddCallback(ModCallbacks.MC_POST_RENDER, drawText)

  local function removeDraw()
    mod:RemoveCallback(ModCallbacks.MC_POST_RENDER, drawText)
    mod:RemoveCallback(ModCallbacks.MC_POST_NEW_ROOM, removeDraw)
  end

  mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, removeDraw)
end

function rd_util:showAlways(destinationText, f, cfg, game, mod)
  local showY = 255
  if cfg.whereToShowAlways == rd_where_to_show_enum.obj[1] then
    showY = 0
  elseif cfg.whereToShowAlways == rd_where_to_show_enum.obj[2] then
    showY = 255
  end

  local function drawText()
    f:DrawStringUTF8(destinationText, rd_util:GetScreenCenter(game).X - f:GetStringWidthUTF8(destinationText) / 2,
      showY, KColor(1, 1, 1, 1), 0, true)
  end

  mod:AddCallback(ModCallbacks.MC_POST_RENDER, drawText)

  local function removeDraw()
    mod:RemoveCallback(ModCallbacks.MC_POST_RENDER, drawText)
    mod:RemoveCallback(ModCallbacks.MC_PRE_GAME_EXIT, removeDraw)
  end

  mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, removeDraw)
end

return rd_util
