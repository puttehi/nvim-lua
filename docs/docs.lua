local output_file = ".output.md"

local function read_map()
    local maps = vim.api.nvim_exec(":map", true)
    return maps
end

local function str_to_table_lines(maps)
    return vim.split(maps, "\n", { trimempty = true })
end

local function lines_to_maps_table(lines)
    local maps_table = {}
    local pattern = "^(%a+)%s+([%a%p]+)%s+(.+)" -- mode  mapping   command/description
    for index, line in ipairs(lines) do
        local _, _, mode, mapping, cmd = string.find(line, pattern)
        -- if nothing was found, then let's assume the remainder is info on the next line
        if mode == nil or mapping == nil or cmd == nil then
            local prev_index = #maps_table -- must be length as we are filling it up
            maps_table[prev_index].info = line
        else
            table.insert(maps_table, {
                mode = mode,
                mapping = mapping,
                cmd = cmd,
                original = line,
                info = ""
            })
        end
    end
    return maps_table
end

local function cmp_mode_and_mapping(lhs, rhs)
    -- concat mode and mapping to effectively sort by mode first (alphabetically)
    return lhs.mode .. lhs.mapping < rhs.mode .. rhs.mapping
end

-- Sort by mode first, then by mapping
local function sort_maps_table(maps_table)
    table.sort(maps_table, cmp_mode_and_mapping)
    return maps_table
end

local function lstrip(str)
    return str:match '^%s*(.*)'
end

local function with_escaped_angle_brackets(str)
    local pattern = "<.*>"
    return str:gsub(pattern, "\\%1")
end

local function maps_table_to_markdown_table(maps_table, hide_which_key_hiddens)
    hide_which_key_hiddens      = hide_which_key_hiddens or true
    local which_key_hidden_char = "Þ"
    local headers               = "| mode | mapping | info | command |"
    local spacer                = "| ---- | ------- | ---- | ------- |"
    local content               = ""

    local row_template = "| %s | %s | %s | %s |\n"
    for _, v in ipairs(maps_table) do repeat
            if hide_which_key_hiddens and string.find(v.info, which_key_hidden_char) then
                do break end -- continue?
            end
            local mode = with_escaped_angle_brackets(lstrip(v.mode))
            local mapping = with_escaped_angle_brackets(lstrip(v.mapping))
            local info = with_escaped_angle_brackets(lstrip(v.info))
            local cmd = with_escaped_angle_brackets(lstrip(v.cmd))
            content = content ..
                string.format(row_template, mode, mapping, info, cmd)
        until true
    end

    return headers .. "\n" .. spacer .. "\n" .. content
end

local function write_to_file(str)
    local f = assert(io.open(output_file, "w"))
    f:write(str)
    f:close()
end

local maps = read_map()
local lines_as_table = str_to_table_lines(maps)
local maps_as_table = lines_to_maps_table(lines_as_table)

local sorted = sort_maps_table(maps_as_table)

local md_table = maps_table_to_markdown_table(sorted)

write_to_file(md_table)
