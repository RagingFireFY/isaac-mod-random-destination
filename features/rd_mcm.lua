local rd_mcm = {}

local rd_where_to_show_enum = require("features.enum.rd_where_to_show_enum")

function rd_mcm:init(rd_data, mod, cfg)
  if ModConfigMenu then
    local RandomDestination = "Random Destination"

    ModConfigMenu.UpdateCategory(RandomDestination, {
      Info = { "Random Destination Settings." }
    })

    -- settings
    ModConfigMenu.AddSetting(RandomDestination, "Misc",
      {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
          return cfg.isThisModEnabled
        end,
        Display = function()
          local onOff = "False"
          if cfg.isThisModEnabled then
            onOff = "True"
          end
          return 'Is this mod enabled: ' .. onOff
        end,
        OnChange = function(currentBool)
          cfg.isThisModEnabled = currentBool
          rd_data:saveData(mod, cfg)
        end,
        Info = { 'If false, this mod will do nothing.' }
      })

    ModConfigMenu.AddSetting(RandomDestination, "Misc",
      {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
          return cfg.isShowAlways
        end,
        Display = function()
          local onOff = "False"
          if cfg.isShowAlways then
            onOff = "True"
          end
          return 'Show destination always: ' .. onOff
        end,
        OnChange = function(currentBool)
          cfg.isShowAlways = currentBool
          rd_data:saveData(mod, cfg)
        end,
        Info = { 'If true, destination text will show always.' }
      })

    ModConfigMenu.AddSetting(RandomDestination, "Misc",
      {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function()
          return rd_where_to_show_enum:getTableIndex(rd_where_to_show_enum.obj, cfg.whereToShowAlways)
        end,
        Minimum = 1,
        Maximum = #rd_where_to_show_enum.obj,
        Display = function()
          return "Where to show always: " .. cfg.whereToShowAlways
        end,
        OnChange = function(currentChoice)
          cfg.whereToShowAlways = rd_where_to_show_enum.obj[currentChoice]
          rd_data:saveData(mod, cfg)
        end,
        Info = { "If \'Show destination always\' is True, sets where the destination text is displayed." }
      }
    )

    ModConfigMenu.AddSetting(RandomDestination, "Random Pool",
      {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
          return cfg.addBlueBabyToRandomPool
        end,
        Display = function()
          local onOff = "False"
          if cfg.addBlueBabyToRandomPool then
            onOff = "True"
          end
          return 'Boss ???: ' .. onOff
        end,
        OnChange = function(currentBool)
          cfg.addBlueBabyToRandomPool = currentBool
          rd_data:saveData(mod, cfg)
        end,
        Info = { 'Add boss ??? to random pool.' }
      })

    ModConfigMenu.AddSetting(RandomDestination, "Random Pool",
      {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
          return cfg.addTheLambToRandomPool
        end,
        Display = function()
          local onOff = "False"
          if cfg.addTheLambToRandomPool then
            onOff = "True"
          end
          return 'Boss The Lamb: ' .. onOff
        end,
        OnChange = function(currentBool)
          cfg.addTheLambToRandomPool = currentBool
          rd_data:saveData(mod, cfg)
        end,
        Info = { 'Add boss The Lamb to random pool.' }
      })

    ModConfigMenu.AddSetting(RandomDestination, "Random Pool",
      {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
          return cfg.addMegaSatanToRandomPool
        end,
        Display = function()
          local onOff = "False"
          if cfg.addMegaSatanToRandomPool then
            onOff = "True"
          end
          return 'Boss Mega Satan: ' .. onOff
        end,
        OnChange = function(currentBool)
          cfg.addMegaSatanToRandomPool = currentBool
          rd_data:saveData(mod, cfg)
        end,
        Info = { 'Add boss Mega Satan to random pool.' }
      })

    ModConfigMenu.AddSetting(RandomDestination, "Random Pool",
      {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
          return cfg.addHushToRandomPool
        end,
        Display = function()
          local onOff = "False"
          if cfg.addHushToRandomPool then
            onOff = "True"
          end
          return 'Boss Hush: ' .. onOff
        end,
        OnChange = function(currentBool)
          cfg.addHushToRandomPool = currentBool
          rd_data:saveData(mod, cfg)
        end,
        Info = { 'Add boss Hush to random pool.' }
      })

    ModConfigMenu.AddSetting(RandomDestination, "Random Pool",
      {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
          return cfg.addDeliriumToRandomPool
        end,
        Display = function()
          local onOff = "False"
          if cfg.addDeliriumToRandomPool then
            onOff = "True"
          end
          return 'Boss Delirium: ' .. onOff
        end,
        OnChange = function(currentBool)
          cfg.addDeliriumToRandomPool = currentBool
          rd_data:saveData(mod, cfg)
        end,
        Info = { 'Add boss Delirium to random pool.' }
      })

    ModConfigMenu.AddSetting(RandomDestination, "Random Pool",
      {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
          return cfg.addMotherToRandomPool
        end,
        Display = function()
          local onOff = "False"
          if cfg.addMotherToRandomPool then
            onOff = "True"
          end
          return 'Boss Mother: ' .. onOff
        end,
        OnChange = function(currentBool)
          cfg.addMotherToRandomPool = currentBool
          rd_data:saveData(mod, cfg)
        end,
        Info = { 'Add boss Mother to random pool.' }
      })

    ModConfigMenu.AddSetting(RandomDestination, "Random Pool",
      {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
          return cfg.addTheBeastToRandomPool
        end,
        Display = function()
          local onOff = "False"
          if cfg.addTheBeastToRandomPool then
            onOff = "True"
          end
          return 'Boss The Beast: ' .. onOff
        end,
        OnChange = function(currentBool)
          cfg.addTheBeastToRandomPool = currentBool
          rd_data:saveData(mod, cfg)
        end,
        Info = { 'Add boss The Beast to random pool.' }
      })

    ModConfigMenu.AddSetting(RandomDestination, "Helper",
      {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
          return cfg.ifMegaSatanIsDrawnThenGiveFullKey
        end,
        Display = function()
          local onOff = "False"
          if cfg.ifMegaSatanIsDrawnThenGiveFullKey then
            onOff = "True"
          end
          return 'Mega Satan Helper: ' .. onOff
        end,
        OnChange = function(currentBool)
          cfg.ifMegaSatanIsDrawnThenGiveFullKey = currentBool
          rd_data:saveData(mod, cfg)
        end,
        Info = { 'If true, when Mega Satan is drawn will give you Full Key.' }
      })

    ModConfigMenu.AddSetting(RandomDestination, "Helper",
      {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
          return cfg.ifHushIsDrawnThenRemoveTheTimeLimit
        end,
        Display = function()
          local onOff = "False"
          if cfg.ifHushIsDrawnThenRemoveTheTimeLimit then
            onOff = "True"
          end
          return 'Hush Helper: ' .. onOff
        end,
        OnChange = function(currentBool)
          cfg.ifHushIsDrawnThenRemoveTheTimeLimit = currentBool
          rd_data:saveData(mod, cfg)
        end,
        Info = { 'If true, when Hush is drawn will remove the 30 minutes time limit.' }
      })

    ModConfigMenu.AddSetting(RandomDestination, "Helper",
      {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
          return cfg.ifDeliriumIsDrawnThenAlwaysOpenTheVoid
        end,
        Display = function()
          local onOff = "False"
          if cfg.ifDeliriumIsDrawnThenAlwaysOpenTheVoid then
            onOff = "True"
          end
          return 'Delirium Helper: ' .. onOff
        end,
        OnChange = function(currentBool)
          cfg.ifDeliriumIsDrawnThenAlwaysOpenTheVoid = currentBool
          rd_data:saveData(mod, cfg)
        end,
        Info = { 'If true, when Delirium is drawn and defeat The Lamb or ??? will open The Void portal.' }
      })

    ModConfigMenu.AddSetting(RandomDestination, "Helper",
      {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
          return cfg.ifMotherIsDrawnThenOpenMomsHeartDoor
        end,
        Display = function()
          local onOff = "False"
          if cfg.ifMotherIsDrawnThenOpenMomsHeartDoor then
            onOff = "True"
          end
          return 'Mother Helper: ' .. onOff
        end,
        OnChange = function(currentBool)
          cfg.ifMotherIsDrawnThenOpenMomsHeartDoor = currentBool
          rd_data:saveData(mod, cfg)
        end,
        Info = { 'If true, when Mother is drawn will open Mom\'s Heart Door no need Full Knife.' }
      })

    ModConfigMenu.AddSetting(RandomDestination, "Helper",
      {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
          return cfg.ifTheBeastIsDrawnThenOpenPortalInTheMomBossRoomForLeave
        end,
        Display = function()
          local onOff = "False"
          if cfg.ifTheBeastIsDrawnThenOpenPortalInTheMomBossRoomForLeave then
            onOff = "True"
          end
          return 'The Beast Helper: ' .. onOff
        end,
        OnChange = function(currentBool)
          cfg.ifTheBeastIsDrawnThenOpenPortalInTheMomBossRoomForLeave = currentBool
          rd_data:saveData(mod, cfg)
        end,
        Info = { 'If true, when The Beast is drawn will open a portal in the Mom boss room for leave.' }
      })
  end
end

return rd_mcm
