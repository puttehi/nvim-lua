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
                original = line
            })
        end
    end
    return maps_table
end

local maps = read_map()
local lines_table = str_to_table_lines(maps)
local maps_table = lines_to_maps_table(lines_table)



--print(vim.inspect(lines_table))
print(vim.inspect(maps_table))
