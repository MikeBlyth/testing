function dump(o) -- modified
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

---============================
function find (zarray, target, first, last)
  first = first or 1
  last = last or #zarray
  if (last<first) then return -1 end
  middle = first + math.floor((last-first)/2)
  elem = zarray[middle]
  if elem == target then return middle end
  if target > elem then return find2(zarray, target, middle+1, last) end
  return find2(zarray, target, first, middle-1)
end

zarray = {1,2,3,4,5,6,7,8,9,10,11,12,13}

assert(find2(zarray, 2) == 2)
assert(find2(zarray, 0) == -1)
assert(find2({}, 2)== -1)
assert(find2(zarray, 50)==-1)
assert(find2(zarray, 13)==13)

qarray = {-1000, -200, 0, 12.5, 16, 50, 100, 1000, 2000}
function test(array, n)
  assert(array[find2(array,n)] == n)
end

test (qarray, -1000)
test (qarray, -200)
test (qarray, 1000)