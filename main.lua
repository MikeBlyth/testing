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

local codonVals =
  {AUG =	'Methionine',
  UUU =	'Phenylalanine',
  UUC	= 'Phenylalanine',
  UUA =	'Leucine',
  UUG =	'Leucine',
  UCU =	'Serine', UCC='Serine', UCA='Serine', UCG =	'Serine',
  UAU = 'Tyrosine', UAC =	'Tyrosine',
  UGU = 'Cysteine', UGC = 'Cysteine',
  UGG	= 'Tryptophan',
  UAA = 'STOP', UAG = 'STOP', UGA = 'STOP'}

local function translate_codon(codon)
  local val = codonVals[codon]
  assert(val, "Invalid codon " .. codon .. ' encountered.')
  return val
end

function translate_rna_strand(rna_strand)
  if rna_strand == '' then return {} end 
  local thisPep = translate_codon(string.sub(rna_strand,1,3))
  if thisPep=='STOP' then return {} end 
  local tr = translate_rna_strand(string.sub(rna_strand,4))
  table.insert(tr, 1, translate_codon(string.sub(rna_strand,1,3)))
  return tr
end

tr = translate_rna_strand

st1 = 'UUUUUAUCUUAUUAAUCUUCU'
st0 = 'UUU'

print(translate_codon('UUA'))
translated = translate_rna_strand(st1)
pdump(translated)


return {
  codon = translate_codon,
  rna_strand = translate_rna_strand
}



