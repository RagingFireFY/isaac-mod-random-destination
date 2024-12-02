local rd_descriptions_language = {}

rd_descriptions_language.obj = {
  "EN_US",
  "ZH_CN"
}

function rd_descriptions_language:getTableIndex(tbl, val)
  for i, v in ipairs(tbl) do
    if v == val then
      return i
    end
  end

  return 0
end

return rd_descriptions_language