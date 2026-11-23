-- Pandoc Lua filter: turns the exported handbook markdown into Typst calls
-- for the custom template (parts, chapters, callouts, diagram).

local stringify = pandoc.utils.stringify

local function tstr(s)
  -- escape a Lua string as a Typst string literal
  s = s:gsub('\\', '\\\\'):gsub('"', '\\"')
  return '"' .. s .. '"'
end

local roman = { I = true, II = true, III = true, IV = true, V = true, VI = true }

function Header(el)
  local txt = stringify(el)
  if el.level == 1 then
    local num, title = txt:match('^Part%s+([IVX]+):%s*(.+)$')
    if num and roman[num] then
      return pandoc.RawBlock('typst', '#part-page(' .. tstr(num) .. ', ' .. tstr(title) .. ')')
    end
    if txt == 'Appendices' then
      return pandoc.RawBlock('typst', '#part-page("A", "Appendices")')
    end
    return pandoc.RawBlock('typst', '// dropped h1: ' .. txt)
  elseif el.level == 2 then
    local n, title = txt:match('^Chapter%s+(%d+):%s*(.+)$')
    if not n then n, title = txt:match('^Appendix%s+(%u):%s*(.+)$') end
    if not n then n, title = '', txt end
    return pandoc.RawBlock('typst', '#chapter-heading(' .. tstr(n) .. ', ' .. tstr(title) .. ')')
  else
    el.level = el.level - 1
    return el
  end
end

-- callout kinds, matched against the bold label at the start of a quote
local kinds = {
  { '^Why',                 'why',      nil },
  { '^Tip',                 'tip',      'Tip' },
  { '^Real%-world tip',     'tip',      'Real-world tip' },
  { '^Golden rules',        'tip',      'Golden rules' },
  { '^Binary search idea',  'tip',      'Idea' },
  { '^Space check %(danger', 'danger',  'Space check · danger' },
  { '^Space check',         'space',    'Space check' },
  { '^Common cron mistakes','mistake',  'Common cron mistakes' },
  { '^Common mistake',      'mistake',  'Common mistake' },
  { '^Safety',              'danger',   'Safety' },
  { '^Practice',            'practice', nil },
  { '^Fedora note',         'note',     'Fedora note' },
  { '^Note',                'note',     'Note' },
  { '^Concepts',            'note',     'Concepts' },
}

local generic = {
  ['Tip:'] = true, ['Space check:'] = true, ['Space check (danger):'] = true,
  ['Common mistake:'] = true, ['Safety first:'] = true, ['Safety:'] = true,
  ['Note:'] = true, ['Fedora note:'] = true, ['Golden rules:'] = true,
  ['Real-world tip:'] = true, ['Binary search idea:'] = true,
  ['Common cron mistakes:'] = true, ['বাংলা নোট:'] = true,
}

function BlockQuote(el)
  local first = el.content[1]
  local kind, title = 'quote', ''
  local label = nil
  if first and first.t == 'Para' and first.content[1] then
    local i1 = first.content[1]
    if i1.t == 'Strong' then
      label = stringify(i1)
    else
      -- plain Bangla label without bold
      local s = stringify(first)
      if s:match('^বাংলা নোট') then label = 'বাংলা নোট:' end
    end
  end
  if label then
    if label:match('^বাংলা') then
      kind, title = 'bangla', 'বাংলা নোট'
    else
      for _, k in ipairs(kinds) do
        if label:match(k[1]) then
          kind = k[2]
          title = k[3] or ''
          break
        end
      end
      if kind == 'practice' then
        title = label:gsub(':$', '')
      end
      if kind == 'why' then title = 'Why?' end
    end
    -- strip generic labels (they become the box title)
    local strip = generic[label] or kind == 'practice' or label == 'Why?'
    if strip then
      local inl = first.content
      if inl[1].t == 'Strong' then
        table.remove(inl, 1)
      else
        -- Bangla label as plain text: remove leading words up to ':'
        while #inl > 0 do
          local x = table.remove(inl, 1)
          if x.t == 'Str' and x.text:match(':$') then break end
        end
      end
      while inl[1] and (inl[1].t == 'Space' or inl[1].t == 'SoftBreak') do table.remove(inl, 1) end
    end
    if kind == 'quote' then kind = 'note' end
  end
  local out = { pandoc.RawBlock('typst', '#callout(' .. tstr(kind) .. ', ' .. tstr(title) .. ')[') }
  for _, b in ipairs(el.content) do table.insert(out, b) end
  table.insert(out, pandoc.RawBlock('typst', ']'))
  return out
end

function Para(el)
  local s = stringify(el)
  if s:match('embedded content: how a command travels') then
    return pandoc.RawBlock('typst', '#layers-diagram()')
  end
  if s:match('^End of handbook') then
    return pandoc.RawBlock('typst', '#end-mark()')
  end
end

function HorizontalRule(el)
  return {}
end
