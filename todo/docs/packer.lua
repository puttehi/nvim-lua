local readme_path = "README.md"

-- for appending (raw) or matching (escaped)
local inject_start = "<!-- DOCGEN_PLUGS_START -->"
local inject_start_pattern = "<!%-%- DOCGEN_PLUGS_START %-%->"

local inject_end = "<!-- DOCGEN_PLUGS_END -->"
local inject_end_pattern = "<!%-%- DOCGEN_PLUGS_END %-%->"


local plugin_definitions = require('puttehi.packer')
-- Plugin definitions is a table of tables where each
-- sub-tables first value is the plugin name as a string,
-- with optional keyed options after that.
-- But Packer also allows name= key, which we must account for.
-- Then the first value is not the plugin name but is behind a key.

local function add_name_key_if_missing(def)
    if not def.name then
        local plugin_name = table.remove(def, 1)
        def.name = plugin_name
    end
end

-- Pipes still break markdown tables, even in code blocks
local function escape_pipes(str)
    return string.gsub(str, "|", "\\%1")
end

local function surround_with_code_ticks(str)
    if str == nil then
        str = ""
    end
    return "`" .. str .. "`"
end

local function defs_table_to_markdown_table_with_requires(defs_tbl)

    local headers = "| name | branch/tag | commit | info | requires |"
    local spacer  = "| ---- | ---------- | ------ | ---- | -------- |"
    local content = ""

    local row_template = "| %s | %s | %s | %s | %s |\n"
    for _, v in ipairs(defs_tbl) do
        local name          = escape_pipes(surround_with_code_ticks(v.name))
        local branch_or_tag = escape_pipes(surround_with_code_ticks(v.branch or v.tag or "master/main"))
        local commit        = escape_pipes(v.commit or "latest")
        local info          = escape_pipes(v.info or v.desc or "")
        local requires      = ""
        if v.requires then
            if not v.requires.opt then
                requires = escape_pipes(surround_with_code_ticks(vim.inspect(v.requires)))
            else
                requires = escape_pipes(surround_with_code_ticks(vim.inspect("opt: " .. v.requires[1])))
            end
        end
        content = content ..
            string.format(row_template, name, branch_or_tag, commit, info, requires)
    end

    return headers .. "\n" .. spacer .. "\n" .. content
end

local function read_file(path)
    local f = assert(io.open(path, "r"))
    local contents = f:read("*all")
    f:close()
    return contents
end

local function inject_docs(readme, str)
    local _, start_j = string.find(readme, inject_start_pattern)
    local end_i, _ = string.find(readme, inject_end_pattern)

    local injected = ""

    if start_j and end_i then
        local until_start_j = string.sub(readme, 0, start_j) -- from start of document to end of start tag
        local remainder = string.sub(readme, end_i) -- from end of end tag to end of document
        injected = until_start_j .. "\n" .. str .. remainder
    else
        -- Tags were not found, append with tags
        injected = readme .. "\n" .. inject_start .. "\n" .. str .. inject_end .. "\n"
    end

    return injected
end

local function write_to_file(path, str)
    local f = assert(io.open(path, "w"))
    f:write(str)
    f:close()
end

-- Enforce common format
for _, v in ipairs(plugin_definitions) do
    add_name_key_if_missing(v)
end

local md_table = defs_table_to_markdown_table_with_requires(plugin_definitions)

local readme_contents = read_file(readme_path)
local injected = inject_docs(readme_contents, md_table)

write_to_file("README.md", injected)
