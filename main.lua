local mod = RegisterMod("Random Destination", 1)

local rd_where_to_show_enum = require("features.enum.rd_where_to_show_enum")
local rd_descriptions_language = require("features.enum.rd_descriptions_language")

local cfg = {
  isThisModEnabled = true,
  language = rd_descriptions_language.obj[1],
  isShowAlways = false,
  whereToShowAlways = rd_where_to_show_enum.obj[2],
  addBlueBabyToRandomPool = true,
  addTheLambToRandomPool = true,
  addMegaSatanToRandomPool = true,
  addHushToRandomPool = true,
  addDeliriumToRandomPool = true,
  addMotherToRandomPool = true,
  addTheBeastToRandomPool = true,
  ifMegaSatanIsDrawnThenGiveFullKey = true,
  ifHushIsDrawnThenRemoveTheTimeLimit = true,
  ifMotherIsDrawnThenOpenMomsHeartDoor = true,
  ifTheBeastIsDrawnThenOpenPortalInTheMomBossRoomForLeave = true
}

local game = Game()
local f = Font()

-- load data
local rd_data = require("features.rd_data")
local loadCfg = rd_data:loadData(mod)
if loadCfg ~= nil then
  cfg = loadCfg
end

-- Mod Config Menu Settings
local rd_mcm = require("features.rd_mcm")
rd_mcm:init(rd_data, mod, cfg)

-- require descriptions
local rd_desc
local languageSwitch = {
  [rd_descriptions_language.obj[1]] = function()
    rd_desc = require("descriptions.en_us")
  end,
  [rd_descriptions_language.obj[2]] = function()
    rd_desc = require("descriptions.zh_cn")
  end
}
if languageSwitch[cfg.language] then
  languageSwitch[cfg.language]()
end

local rd_util = require("features.rd_util")
local rd_helper = require("features.rd_helper")

-- load font
f:Load(rd_util:getCurrentModPath() .. "resources/font/rd_default.fnt")

local recentBoss = ""

local function main(_, isContinued)
  if not cfg.isThisModEnabled then
    return
  end

  -- ignore greed/greedier mode
  if game:IsGreedMode() then
    recentBoss = ""
    return
  end

  -- ignore challenge
  if Isaac.GetChallenge() ~= 0 then
    recentBoss = ""
    return
  end

  -- continue a run
  if isContinued then
    if recentBoss ~= "" then
      -- show destination text again
      local destinationText = rd_desc.prefix .. recentBoss .. rd_desc.suffix
      if cfg.isShowAlways
      then
        rd_util:showAlways(destinationText, f, cfg, game, mod)
      else
        rd_util:showOnceInTheCenter(destinationText, f, game, mod)
      end
      -- add callback again
      rd_helper:hushHelper(recentBoss, rd_desc, cfg, mod, rd_util, game)
      rd_helper:motherHelper(recentBoss, rd_desc, cfg, mod, rd_util, game)
      rd_helper:theBeastHelper(recentBoss, rd_desc, cfg, mod, rd_util, game)
    end
    -- recentBoss not store when close the game, will do nothing
    return
  end

  -- init random pool
  local randomPool = {}
  if cfg.addBlueBabyToRandomPool then
    randomPool[#randomPool + 1] = rd_desc.blueBaby
  end
  if cfg.addTheLambToRandomPool then
    randomPool[#randomPool + 1] = rd_desc.theLamb
  end
  if cfg.addMegaSatanToRandomPool then
    randomPool[#randomPool + 1] = rd_desc.megaSatan
  end
  if cfg.addHushToRandomPool then
    randomPool[#randomPool + 1] = rd_desc.hush
  end
  if cfg.addDeliriumToRandomPool then
    randomPool[#randomPool + 1] = rd_desc.delirium
  end
  if cfg.addMotherToRandomPool then
    randomPool[#randomPool + 1] = rd_desc.mother
  end
  if cfg.addTheBeastToRandomPool then
    randomPool[#randomPool + 1] = rd_desc.theBeast
  end

  -- generate rng
  local rng = RNG()
  rng:SetSeed(rd_util:getRNGSeed(), 35)

  -- choose destination
  local drawn = rng:RandomInt(#randomPool) + 1

  local drawnBoss = randomPool[drawn]
  recentBoss = drawnBoss

  -- show destination text
  local destinationText = rd_desc.prefix .. drawnBoss .. rd_desc.suffix
  if cfg.isShowAlways
  then
    rd_util:showAlways(destinationText, f, cfg, game, mod)
  else
    rd_util:showOnceInTheCenter(destinationText, f, game, mod)
  end

  -- helper
  rd_helper:megaSatanHelper(drawnBoss, rd_desc, cfg)
  rd_helper:hushHelper(drawnBoss, rd_desc, cfg, mod, rd_util, game)
  rd_helper:motherHelper(drawnBoss, rd_desc, cfg, mod, rd_util, game)
  rd_helper:theBeastHelper(drawnBoss, rd_desc, cfg, mod, rd_util, game)
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, main)
