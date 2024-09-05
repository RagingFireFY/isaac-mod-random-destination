local rd_where_to_show_enum = {}

rd_where_to_show_enum.obj = {
  "TOP",
  "BOTTOM"
}

function rd_where_to_show_enum:getTableIndex(tbl, val)
  for i, v in ipairs(tbl) do
    if v == val then
      return i
    end
  end

  return 0
end

return rd_where_to_show_enum