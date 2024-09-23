-- 文件路径：~/.config/nvim/lua/snippets/c.lua
local ls = require'luasnip'
local s = ls.snippet  -- snippet
local i = ls.insert_node  -- insert node
local t = ls.text_node  -- text node

-- 定义代码片段
local snippets = {
    s("for", {
        t({"for ("}),
        i(1, "int i = 0"),
        t({" ; "}),
        i(2, "i < n"),
        t({" ; "}),
        i(3, "i++"),
        t({") {", "    "}),
        i(4, "/* code */"),
        t({"", "}"})
    }),
    s("if", {
        t({"if ("}),
        i(1, "/* condition */"),
        t({") {", "    "}),
        i(2, "/* code */"),
        t({"", "}"})
    }),
    s("ie", {
        t({"if ("}),
        i(1, "/* condition */"),
        t({") {", "    "}),
        i(2, "/* code */"),
        t({"", "} else {", "    "}),
        i(3, "/* code */"),
        t({"", "}"})
    }),
    s("iee", {
        t({"if ("}),
        i(1, "/* condition */"),
        t({") {", "    "}),
        i(2, "/* code */"),
        t({"", "} else if("}),
        i(3, "/* condition */"),
        t({") {", "    "}),
        i(4, "/* code */"),
        t({"", "} else {", "    "}),
        i(5, "/* code */"),
        t({"", "}"})
    }),
    s("while", {
        t({"while ("}),
        i(1, "/* condition */"),
        t({") {", "    "}),
        i(2, "/* code */"),
        t({"", "}"})
    }),
    s("switch", {
        t({"switch ("}),
        i(1, "/* expression */"),
        t({") {", "case "}),
        i(2, "value1"),
        t({":", "    "}),
        i(3, "/* code */"),
        t({"", "    break;", "case "}),
        i(4, "value2"),
        t({":", "    "}),
        i(5, "/* code */"),
        t({"", "    break;", "default:", "    "}),
        i(6, "/* code */"),
        t({"", "}"})
    }),
    s("class", {
        t({"class "}),
        i(1, "ClassName"),
        t({" {", "public:", "    "}),
        i(2, "ClassName"),
        t({"() {", "        "}),
        i(3, "/* constructor */"),
        t({"", "    }", "", "    ~"}),
        i(4, "ClassName"),
        t({"() {", "        "}),
        i(5, "/* destructor */"),
        t({"", "    }", "", "    "}),
        i(6, "void"),
        t({" "}),
        i(7, "memberFunction"),
        t({"() {", "        "}),
        i(8, "/* code */"),
        t({"", "    }", "", "private:", "    "}),
        i(9, "int memberVariable"),
        t({";", "};"})
    }),
    s("func", {
        t({""}),
        i(1, "ReturnType"),
        t({" "}),
        i(2, "functionName"),
        t({"("}),
        i(3, "/* parameters */"),
        t({") {", "    "}),
        i(4, "/* code */"),
        t({"", "}"})
    }),
    s("cm", {
        t({"/** "}),
        i(1, ""),
        t({" */"})
    }),
    s("cmt", {
        t({"/**", " * "}),
        i(1, ""),
        t({"", " */"})
    }),
}

-- 加载代码片段
ls.add_snippets("c", snippets)
ls.add_snippets("cpp", snippets)
