local rd_data = {}

local json = require("json")

function rd_data:saveData(mod, cfg)
    local jsonString = json.encode(cfg)
    mod:SaveData(jsonString)
end

function rd_data:loadData(mod)
    if not mod:HasData() then
        return nil
    end
    local jsonString = mod:LoadData()
    return json.decode(jsonString)
end

return rd_data
