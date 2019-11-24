function dump(o) -- modified
-- Remember that this does just returns a string and does not print it!
    if o == nil then return 'nil' end
    if type(o) == 'table' then
      local s = '{ '
      if tableIsArray(o) then
        for _, v in ipairs(o) do
          s = s .. dump(v) .. ', '
        end
      else
        for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..']=' .. dump(v) .. ', '
        end
      end
      return s .. '} '
    else
      return tostring(o)
    end
end

function pdump(o, s)
    s = s or ''
    print(s .. ': ' .. dump(o))
end

function tableIsArray(t) -- quick check, see if indices are sequential
  local i = 1
  for k, _ in pairs(t) do
    if k ~= i then return false end
    i = i + 1
  end
  return true
end
--- new utilities --
function split(str, delim) -- split a string on delim
  assert(#delim==1, "Delimiter in this split function must have length of 1 char")
  local results = {}
  for elem in string.gmatch(str, "[^" .. delim.. "]+") do
    table.insert(results, elem)
  end
  return results
end

function map(func, array)
  local new_array = {}
  for i,v in ipairs(array) do
    new_array[i] = func(v)
  end
  return new_array
end

---============================

function Matrix(s)
    function split(str, delim) -- split a string on delim
      assert(#delim==1, "Delimiter in this split function must have length of 1 char")
      local results = {}
      for elem in string.gmatch(str, "[^" .. delim.. "]+") do
        table.insert(results, elem)
      end
      return results
    end
    function map(func, array)
      local new_array = {}
      for i,v in ipairs(array) do
        new_array[i] = func(v)
      end
      return new_array
    end

  local obj = {}
  local rowsStr = split(s,"\n")
  for _,v in ipairs(rowsStr) do
    matRow = split(v,' ') -- string -> list of numbers as string {"1","2","3"}
    table.insert(obj, map(tonumber,matRow))  -- convert to number {1,2,3}
  end
  obj.row = function(n) return obj[n] end
  obj.column = function (n)
        local result = {}
        for _, row in ipairs(obj) do
          table.insert(result, row[n])
        end
        return result
      end      
  
  return obj

end

ms = '1 2 3\n4 5 6\n72 8 9'
m = Matrix(ms)
pdump(m.row(2))
pdump(m.column(2))

