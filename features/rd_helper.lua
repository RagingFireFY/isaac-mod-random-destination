local rd_helper = {}

function rd_helper:megaSatanHelper(drawnBoss, rd_desc, cfg)
  if (drawnBoss == rd_desc.megaSatan and cfg.ifMegaSatanIsDrawnThenGiveFullKey) then
    Isaac.ExecuteCommand("g c238")
    Isaac.ExecuteCommand("g c239")
  end
end

function rd_helper:hushHelper(drawnBoss, rd_desc, cfg, mod, rd_util, game)
  if (drawnBoss == rd_desc.hush and cfg.ifHushIsDrawnThenRemoveTheTimeLimit) then
    local function openDoor()
      local room = game:GetRoom()
      local roomType = room:GetType()
      if roomType == RoomType.ROOM_BOSS then
        room:TrySpawnBlueWombDoor(true, true, false)
      end
    end

    local function removeOpenDoorCallback()
      mod:RemoveCallback(ModCallbacks.MC_POST_NEW_ROOM, openDoor)
      mod:RemoveCallback(ModCallbacks.MC_POST_NEW_LEVEL, removeOpenDoorCallback)
    end

    local function doHelper(_, entityNPC)
      if rd_util:getEntityID(entityNPC) == "78.1.0" then
        openDoor()

        mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, openDoor)
        mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, removeOpenDoorCallback)
        mod:RemoveCallback(ModCallbacks.MC_POST_NPC_DEATH, doHelper)
      end
    end
    mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, doHelper, EntityType.ENTITY_MOMS_HEART)

    local function exitGameRemoveHelper()
      mod:RemoveCallback(ModCallbacks.MC_POST_NEW_ROOM, openDoor)
      mod:RemoveCallback(ModCallbacks.MC_POST_NEW_LEVEL, removeOpenDoorCallback)
      mod:RemoveCallback(ModCallbacks.MC_POST_NPC_DEATH, doHelper)
      mod:RemoveCallback(ModCallbacks.MC_PRE_GAME_EXIT, exitGameRemoveHelper)
    end
    mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, exitGameRemoveHelper)
  end
end

function rd_helper:deliriumHelper(drawnBoss, rd_desc, cfg, mod, rd_util, game)
  if (drawnBoss == rd_desc.delirium and cfg.ifDeliriumIsDrawnThenAlwaysOpenTheVoid) then
    local function openVoidPortal()
      local voidPortal = Isaac.GridSpawn(GridEntityType.GRID_TRAPDOOR, 1, Vector(320, 360), false)
      voidPortal.VarData = 1
      local sprite = voidPortal:GetSprite()
      sprite:Load("gfx/grid/voidtrapdoor.anm2", true)
    end

    local function openVoidPortalCallback()
      local room = game:GetRoom()
      local roomType = room:GetType()
      if (room:IsClear() and roomType == RoomType.ROOM_BOSS) then
        openVoidPortal()
        mod:RemoveCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, openVoidPortalCallback)
      end
    end

    local function doHelper1(_, entityNPC)
      if (rd_util:getEntityID(entityNPC) == "102.1.0") then
        mod:RemoveCallback(ModCallbacks.MC_POST_NPC_DEATH, doHelper1)
        local room = game:GetRoom()
        if room:IsClear()
        then
          openVoidPortal()
        else
          mod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, openVoidPortalCallback)
        end
      end
    end
    mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, doHelper1, EntityType.ENTITY_ISAAC)

    local function doHelper2()
      mod:RemoveCallback(ModCallbacks.MC_POST_NPC_DEATH, doHelper2)
      local room = game:GetRoom()
      if room:IsClear()
      then
        openVoidPortal()
      else
        mod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, openVoidPortalCallback)
      end
    end
    mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, doHelper2, EntityType.ENTITY_THE_LAMB)

    local function exitGameRemoveHelper()
      mod:RemoveCallback(ModCallbacks.MC_POST_NPC_DEATH, doHelper1)
      mod:RemoveCallback(ModCallbacks.MC_POST_NPC_DEATH, doHelper2)
      mod:RemoveCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, openVoidPortalCallback)
      mod:RemoveCallback(ModCallbacks.MC_PRE_GAME_EXIT, exitGameRemoveHelper)
    end
    mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, exitGameRemoveHelper)
  end
end

function rd_helper:motherHelper(drawnBoss, rd_desc, cfg, mod, rd_util, game)
  if (drawnBoss == rd_desc.mother and cfg.ifMotherIsDrawnThenOpenMomsHeartDoor) then
    local function doOpen(door)
      if door ~= nil then
        local targetDoorType = door.TargetRoomType
        if targetDoorType == RoomType.ROOM_BOSS then
          door:SetLocked(false)
          return
        end
      end
    end

    local function openMomsHeartDoor(room)
      local l0Door = room:GetDoor(DoorSlot.LEFT0)
      local u0Door = room:GetDoor(DoorSlot.UP0)
      local r0Door = room:GetDoor(DoorSlot.RIGHT0)
      local d0Door = room:GetDoor(DoorSlot.DOWN0)
      doOpen(l0Door)
      doOpen(u0Door)
      doOpen(r0Door)
      doOpen(d0Door)
    end

    local function openMomsHeartDoorCallback()
      local room = game:GetRoom()
      if room:IsClear() then
        openMomsHeartDoor(room)
        mod:RemoveCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, openMomsHeartDoorCallback)
      end
    end

    local function doHelper(_, entityNPC)
      if rd_util:getEntityID(entityNPC) == "45.10.3" then
        mod:RemoveCallback(ModCallbacks.MC_POST_NPC_DEATH, doHelper)
        local room = game:GetRoom()
        if room:IsClear()
        then
          openMomsHeartDoor(room)
        else
          mod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, openMomsHeartDoorCallback)
        end
      end
    end
    mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, doHelper, EntityType.ENTITY_MOM)

    local function exitGameRemoveHelper()
      mod:RemoveCallback(ModCallbacks.MC_POST_NPC_DEATH, doHelper)
      mod:RemoveCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, openMomsHeartDoorCallback)
      mod:RemoveCallback(ModCallbacks.MC_PRE_GAME_EXIT, exitGameRemoveHelper)
    end
    mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, exitGameRemoveHelper)
  end
end

function rd_helper:theBeastHelper(drawnBoss, rd_desc, cfg, mod, rd_util, game)
  if (drawnBoss == rd_desc.theBeast and cfg.ifTheBeastIsDrawnThenOpenPortalInTheMomBossRoomForLeave) then
    local function openPortal()
      local room = game:GetRoom()
      local roomType = room:GetType()
      if roomType == RoomType.ROOM_BOSS then
        Isaac.ExecuteCommand("spawn 1000.161.4")
      end
    end

    local function removeOpenPortalCallback()
      mod:RemoveCallback(ModCallbacks.MC_POST_NEW_ROOM, openPortal)
      mod:RemoveCallback(ModCallbacks.MC_POST_NEW_LEVEL, removeOpenPortalCallback)
    end

    local function doHelper(_, entityNPC)
      if rd_util:isChapter3MomBoss(rd_util:getEntityID(entityNPC)) then
        Isaac.ExecuteCommand("spawn 1000.161.4")

        mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, openPortal)
        mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, removeOpenPortalCallback)
        mod:RemoveCallback(ModCallbacks.MC_POST_NPC_DEATH, doHelper)
      end
    end
    mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, doHelper, EntityType.ENTITY_MOM)

    local function exitGameRemoveHelper()
      mod:RemoveCallback(ModCallbacks.MC_POST_NEW_ROOM, openPortal)
      mod:RemoveCallback(ModCallbacks.MC_POST_NEW_LEVEL, removeOpenPortalCallback)
      mod:RemoveCallback(ModCallbacks.MC_POST_NPC_DEATH, doHelper)
      mod:RemoveCallback(ModCallbacks.MC_PRE_GAME_EXIT, exitGameRemoveHelper)
    end
    mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, exitGameRemoveHelper)
  end
end

return rd_helper
