import re
import os
from slpp import slpp


def lua_table_to_dict(lua_table: str) -> dict:
    """Convert Lua table to a Python dict using slpp"""
    return slpp.decode(lua_table)


def read_which_key_groups(path: str) -> dict:
    """Try to parse which-key groups from the lua file"""

    abs_path = os.path.abspath(path)
    with open(abs_path, "r") as f:
        content_bytes = f.read()

    content = str(content_bytes)

    # something.register({...}, {prefix = ...})
    # Match:             ^^^^^^^^^^^^^^^^^^^^^

    anything = r"[\r|\n|\t|\ |\w|\W|.]"
    table_pattern = r"[{]" + anything + r"*" + r"[}]"
    table_separator_pattern = r"[,|\ ]*"  # ', '
    tables_pattern = rf"{table_pattern}{table_separator_pattern}{table_pattern}"
    regex_pattern = rf"{anything}*register\(({tables_pattern})\)"
    compiled = re.compile(regex_pattern, re.MULTILINE)

    # print(tables_pattern)
    matches = compiled.findall(content)

    assert len(matches) == 1, "Only one match should be found"
    prefix_groups = lua_table_to_dict(str(matches[0]))
    # TODO: Matching multiple tables doesn't seem to work but
    # at least we get what we came for, so let's assume it's for <prefix>..

    simplified = {}  # without inner dicts
    for k, v in prefix_groups.items():
        if isinstance(v, dict):
            simplified[k] = v["name"]

    return simplified


def generate_dict() -> dict:
    """Generate dictionary of keymaps for further parsing to text"""

    groups_path = "../after/plugin/which-key.lua"
    which_key_prefix_groups = read_which_key_groups(groups_path)

    return which_key_prefix_groups
