local util = require("monokai.util")
local colors = require("monokai.colors")

local M = {}
--
---@class Highlight
---@field fg string|nil
---@field bg string|nil
---@field sp string|nil
---@field style string|nil|Highlight

---@alias Highlights table<string,Highlight>

---@return Theme
function M.setup()
    local config = require("monokai.config")
    local options = config.options
    ---@class Theme
    ---@field highlights Highlights
    local theme = {
        config = options,
        colors = colors.setup(),
    }

    local c = theme.colors

    theme.highlights = {
        Foo = { fg = c.fg, bg = c.purple },

        Normal = { fg = c.fg, bg = options.transparent and c.none or c.bg }, -- normal text
        Cursor = { fg = c.bg, bg = c.blue_light }, -- character under the cursor
        lCursor = { fg = c.bg, bg = c.blue_light }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
        CursorIM = { fg = c.bg, bg = c.blue_light }, -- like Cursor, but used when in IME mode |CursorIM|
        TermCursor  = { fg = c.bg, bg = c.fg }, -- cursor in a focused terminal
        TermCursorNC= { fg = c.bg, bg = c.fg_dark }, -- cursor in an unfocused terminal
        Special = { fg = c.purple }, -- (preferred) any special symbol
        Title = { fg = c.fg, bold = true }, -- titles for output from ":set all", ":autocmd" etc.
        EndOfBuffer = { fg = c.grey_darker }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
        WinSeparator = { fg = c.border }, --, bold = true }, -- the column separating vertically split windows
        Error = { fg = c.white, bg = c.red }, -- (preferred) any erroneous construct
        ErrorMsg = { fg = c.white, bg = c.red }, -- error messages on the command line
        WarningMsg = { fg = c.white, bg = c.red }, -- warning messages
        SpellBad = { sp = c.error, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap = { sp = c.warning, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal = { sp = c.info, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare = { sp = c.hint, undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
        CursorLineNR = { fg = c.yellow }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        CursorColumn = { bg = c.bg_highlight }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        ColorColumn = { bg = c.bg }, -- used for the columns set with 'colorcolumn'
        -- Conceal = { fg = c.dark5 }, -- placeholder characters substituted for concealed text (see 'conceallevel')
        Conceal = {},
        CursorLine = { bg = c.bg }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        LineNrBe = { fg = c.green_light },
        Type = {}, -- (preferred) int, long, char, etc.
        Visual = { bg = c.bg_visual }, -- Visual mode selection
        TabLine = { fg = c.fg_statusline, bg = c.bg_statusline, underline = true }, -- tab pages line, not active tab page label
        Whitespace = { fg = c.grey_darker }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
        TabLineSel = { bg = c.bg }, -- tab pages line, active tab page label
        SignColumn = { bg = options.transparent and c.none or c.bg, fg = c.fg_gutter }, -- column where |signs| are displayed
        NonText = { fg = c.grey_darker }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        TabLineFill = { bg = c.grey_darker }, -- tab pages line, where there are no labels
        LineNr = { fg = c.fg_gutter }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        VertSplit = { fg = c.border }, -- the column separating vertically split windows
        StatusLine = { fg = c.fg_sidebar, bg = c.bg_statusline }, -- status line of current window
        StatusLineNC = { fg = c.fg_gutter, bg = c.bg_statusline }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        Exception = { fg = c.magenta }, --  try, catch, throw
        MatchParen = { fg = c.magenta, bold = true, underline = true }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        Include = { fg = c.magenta }, -- preprocessor #include
        Conditional = { fg = c.magenta }, -- if, then, else, endif, switch, etc.
        Define = { fg = c.magenta }, -- preprocessor #define
        Debug = { fg = c.orange }, -- c.magenta }, -- debugging statements
        Delimiter = { fg = c.magenta }, -- character that needs attention
        Keyword = { fg = c.magenta, style = options.styles.keywords }, -- any other keyword
        Macro = { fg = c.magenta }, -- same as Define
        Operator = { fg = c.magenta }, -- "sizeof", "+", "*", etc.
        PreProc = { fg = c.magenta }, -- (preferred) generic Preprocessor
        Statement = { fg = c.magenta }, -- (preferred) any statement
        Repeat = { fg = c.magenta }, -- for, do, while, etc.

        DiffChange = { bg = c.diff.change }, -- diff mode: Changed line |diff.txt|
        DiffText = { bg = c.diff.text }, -- diff mode: Changed text within a changed line |diff.txt|
        DiffDelete = { bg = c.diff.delete }, -- diff mode: Deleted line |diff.txt|
        DiffAdd = { bg = c.diff.add }, -- diff mode: Added line |diff.txt|
        -- diff
        diffAdded = { fg = c.git.add },
        diffRemoved = { fg = c.git.delete },
        diffChanged = { fg = c.git.change },
        diffOldFile = { fg = c.yellow },
        diffNewFile = { fg = c.orange },
        diffFile = { fg = c.white },
        diffLine = { fg = c.purple },
        diffIndexLine = { fg = c.purple },
        diffSubname = { fg = c.yellow },

        -- git?
        gitcommitHeader = { fg = c.blue_light },
        gitcommitSelectedFile = { fg = c.yellow },
        gitcommitSummary = { fg = c.fg },
        gitcommitOverflow = { fg = c.magenta },

        SpecialKey = { fg = c.grey_medium }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        IncSearch = { fg = c.black, bg = c.purple }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        Search = { fg = c.fg_search, bg = c.bg_search, bold = true }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        CurSearch = { link = "IncSearch" },
        Identifier = { fg = c.fg, style = options.styles.variables }, -- (preferred) any variable name
        Question = { fg = c.blue_light }, -- |hit-enter| prompt and yes/no questions
        StorageClass = { fg = c.blue_light, italic = true }, -- static, register, volatile, etc.
        Structure = { fg = c.blue_light }, -- struct, union, enum, etc.
        Typedef = { fg = c.blue_light }, -- A typedef
        Function = { fg = c.green_light, style = options.styles.functions }, -- function name (also: methods for classes)
        PreCondit = { fg = c.purple }, -- preprocessor #if, #else, #endif, etc.
        Constant = { fg = c.purple }, -- (preferred) any constant
        Directory = { fg = c.purple }, -- directory names (and other special names in listings)
        Tag = { fg = c.purple }, -- you can use CTRL-] on this
        Boolean = { fg = c.purple }, -- a boolean constant: TRUE, false
        Character = { fg = c.purple }, --  a character constant: 'c', '\n'
        Float = { fg = c.purple }, -- a floating point constant: 2.3e10
        Folded = { fg = c.comment, bg = c.fg_gutter }, -- line used for closed folds
        FoldColumn = { fg = c.comment, bg = options.transparent and c.none or c.bg }, -- 'foldcolumn'
        Comment = { fg = c.comment, style = options.styles.comments }, -- any comment
        Label = { fg = c.yellow }, -- case, default, etc.
        String = { fg = c.yellow }, --   a string constant: "this is a string"
        Todo = { fg = c.yellow, bg = c.grey_medium }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
        Underlined = { underline = true }, -- (preferred) text that stands out, HTML links
        Pmenu = { fg = c.blue_light, bg = c.bg_popup }, -- Popup menu: normal item.
        PmenuSel = { fg = c.yellow, bg = util.darken(c.fg_gutter, 0.8) }, -- Popup menu: selected item.
        PmenuSbar = { bg = util.lighten(c.bg_popup, 0.95) }, -- bg = c.grey -- Popup menu: scrollbar.
        PmenuThumb = { bg = c.fg_gutter }, -- Popup menu: Thumb of the scrollbar.
        MoreMsg = { fg = c.green_light }, -- |more-prompt|
        Substitute = { fg = c.black, bg = c.green_light }, -- |:substitute| replacement text highlighting
        ModeMsg = { fg = c.fg_dark, bold = true }, -- 'showmode' message (e.g., "-- INSERT -- ")

        SignColumnSB = { bg = c.bg_sidebar, fg = c.fg_gutter }, -- column where |signs| are displayed
        MsgArea = { fg = c.fg_dark }, -- Area for messages and cmdline
        -- MsgSeparator= { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
        -- TODO: Fix this to get a nice and distinct set of colors for the non-current windows
        NormalNC = { fg = c.fg, bg = options.transparent and c.none or options.dim_inactive and c.bg_dark or c.bg }, -- normal text in non-current windows
        NormalSB = { fg = c.fg_sidebar, bg = c.bg_sidebar }, -- normal text in sidebar
        NormalFloat = { fg = c.fg_float, bg = c.bg_float }, -- Normal text in floating windows.
        FloatBorder = { fg = c.border_highlight, bg = c.bg_float },

        IndentBlanklineChar = { fg = c.fg_gutter, nocombine = true },
        IndentBlanklineSpaceChar = { fg = c.fg_dark, nocombine = true },
        IndentBlanklineContextChar = { fg = c.purple, nocombine = true },

        -- FloatTitle = { fg = c.border_highlight, bg = c.bg_float },
        -- QuickFixLine = { bg = c.bg_visual, bold = true }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        -- VisualNOS = { bg = c.bg_visual }, -- Visual mode selection when vim is "Not Owning the Selection".
        -- WildMenu = { bg = c.bg_visual }, -- current match in 'wildmenu' completion

        ---
        -- These groups are not listed as default vim groups,
        -- but they are defacto standard group names for syntax highlighting.
        -- commented out groups should chain up to their "preferred" group by
        -- default,
        -- Uncomment and edit if you want more specific syntax highlighting.
        -- Number        = { }, --   a number constant: 234, 0xff
        -- SpecialChar   = { }, --  special character in a constant
        -- SpecialComment= { }, -- special things inside a comment

        Bold = { bold = true },
        Italic = { italic = true },

        -- -- ("Ignore", below, may be invisible...)
        -- -- Ignore = { }, -- (preferred) left blank, hidden  |hl-Ignore|

        qfLineNr = { fg = c.grey },
        qfFileName = { fg = c.purple },

        -- htmlH1 = { fg = c.fg, bold = true },
        -- htmlH1 = {fg = c.fg},
        -- htmlH2 = { fg = c.fg, bold = true },
        -- htmlH3 = { fg = c.fg },
        ["@tag"] = { fg = c.magenta },
        ["@tag.attribute"] = { fg = c.blue_light, italic = true },
        ["@tag.delimiter"] = { fg = c.grey_light },

        --- Markdown
        markdownCode = { fg = c.purple },
        markdownCodeBlock = { fg = c.yellow },
        markdownCodeDelimiter = { fg = c.green_light },
        markdownH1 = { fg = c.fg, bold = true },
        markdownHeadingDelimiter = { fg = c.magenta },
        markdownHeadingRule = { fg = c.magenta, bold = true },
        markdownLinkDelimiter = { fg = c.blue_light },
        markdownLinkText = { fg = c.blue_light, underline = true },
        markdownLinkTextDelimiter = { fg = c.blue_light },
        markdownListMarker = { fg = c.magenta },
        markdownRule = { fg = c.blue_light },
        markdownUrl = { fg = c.orange },
        ["@lsp.type.class.markdown"] = { fg = c.yellow },

        -- vim-markdown
        mkdHeading = { fg = c.magenta },
        mkdURL = { fg = c.orange },
        mkdCode = { fg = c.purple },
        mkdCodeStart = { fg = c.green_light },
        mkdCodeEnd = { fg = c.green_light },
        mkdDelimiter = { fg = c.blue_light },
        mkdListItem = { fg = c.magenta },
        mkdListItemCheckbox = { fg = c.magenta },
        mkdCodeDelimiter = { fg = c.purple },
        mkdLink = { fg = c.blue_light, underline = true },

        -- TODO: ??
        ["helpCommand"] = { fg = c.blue_light, bg = c.bg_float },

        debugPC = { bg = c.bg_sidebar }, -- used for highlighting the current line in terminal-debug
        debugBreakpoint = { bg = util.darken(c.info, 0.1), fg = c.info }, -- used for breakpoint colors in terminal-debug

        -- These groups are for the native LSP client. Some other LSP clients may
        -- use these groups, or use their own. Consult your LSP client's
        -- documentation.
        LspReferenceText = { bg = c.fg_gutter }, -- used for highlighting "text" references
        LspReferenceRead = { bg = c.fg_gutter }, -- used for highlighting "read" references
        LspReferenceWrite = { bg = c.fg_gutter }, -- used for highlighting "write" references

        DiagnosticError = { fg = c.error }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticWarn = { fg = c.warning }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticInfo = { fg = c.info }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticHint = { fg = c.hint }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticUnnecessary = { fg = c.grey_light, italic = true, undercurl = true }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default

        DiagnosticVirtualTextError = { fg = c.error, bg = util.darken(c.error, 0.08) }, -- Used for "Error" diagnostic virtual text
        DiagnosticVirtualTextWarn = { fg = c.warning, bg = util.darken(c.warning, 0.08) }, -- Used for "Warning" diagnostic virtual text
        DiagnosticVirtualTextInfo = { fg = c.info, bg = util.darken(c.info, 0.08) }, -- Used for "Information" diagnostic virtual text
        DiagnosticVirtualTextHint = { fg = c.hint, bg = util.darken(c.hint, 0.08) }, -- Used for "Hint" diagnostic virtual text

        DiagnosticUnderlineError = { undercurl = true, sp = c.error }, -- Used to underline "Error" diagnostics
        DiagnosticUnderlineWarn = { undercurl = true, sp = c.warning }, -- Used to underline "Warning" diagnostics
        DiagnosticUnderlineInfo = { undercurl = true, sp = c.info }, -- Used to underline "Information" diagnostics
        DiagnosticUnderlineHint = { undercurl = true, sp = c.hint }, -- Used to underline "Hint" diagnostics

        -- LspSignatureActiveParameter = { bg = util.darken(c.bg_visual, 0.4), bold = true },
        -- LspCodeLens = { fg = c.comment },
        -- LspInlayHint = { bg = util.darken(c.blue7, 0.1), fg = c.grey_dark },
        --
        -- LspInfoBorder = { fg = c.border_highlight, bg = c.bg_float },
        --
        -- ALEErrorSign = { fg = c.error },
        -- ALEWarningSign = { fg = c.warning },
        --
        -- DapStoppedLine = { bg = util.darken(c.warning, 0.1) }, -- Used for "Warning" diagnostic virtual text
        --
        -- -- These groups are for the Neovim tree-sitter highlights.
        -- -- As of writing, tree-sitter support is a WIP, group names may change.
        --
        --- Misc
        -- TODO:
        -- -- ["@comment.documentation"] = { },
        -- ["@operator"] = { fg = c.blue5 }, -- For any operator: `+`, but also `->` and `*` in C.
        ["@preproc"] = { fg = c.grey, italic = true},

        --- Punctuation
        ["@punctuation.delimiter"] = { fg = c.grey}, -- For delimiters ie: `.`
        ["@punctuation.bracket"] = { fg = c.magenta }, -- For brackets and parens.
        -- ["@punctuation.special"] = { fg = c.blue5 }, -- For special punctutation that does not fall in the catagories before.
        -- ["@punctuation.special.markdown"] = { fg = c.orange, bold = true },

        --- Literals
        ["@string.documentation"] = { fg = c.grey, italic = true},
        -- TODO: Check with reference:
        -- ["@string.regex"] = { fg = c.blue6 }, -- For regexes.
        --["@string.escape"] = { fg = c.purple }, -- For escape characters within a string.

        --- Functions
        ["@constructor"] = { fg = c.blue_light, italic = true },
        ["@parameter"] = { fg = c.orange, italic = true }, -- parameters of a function
        ["@function.builtin"] = { fg = c.green_light },

        --- Keywords
        ["@keyword"] = { fg = c.magenta, style = options.styles.keywords }, -- For keywords that don't fall in previous categories.
        ["@keyword.function"] = { fg = c.blue_light, italic = true },
        -- ["@label"] = { fg = c.blue }, -- For labels: `label:` in C and `:label:` in Lua.

        --- Types
        ["@type"] = { fg = c.blue_light },
        ["@field"] = { fg = c.fg },
        ["@type.builtin"] = { fg = c.blue_light, italic = true },
        -- ["@property"] = { fg = c.green1 },

        --- Identifiers
        ["@attribute.builtin"] = { fg = c.magenta, italic = true }, -- Variable names that are defined by the languages, like `this` or `self`.
        ["@variable"] = { fg = c.white, style = options.styles.variables }, -- Any variable name that does not have another highlight.
        ["@variable.builtin"] = { fg = c.grey_light, italic = true }, -- Variable names that are defined by the languages, like `this` or `self`.

        --- Text
        -- ["@text.literal.markdown"] = { fg = c.blue },
        -- ["@text.literal.markdown_inline"] = { bg = c.terminal_black, fg = c.blue },
        -- ["@text.reference"] = { fg = c.teal },
        --
        -- ["@text.todo.unchecked"] = { fg = c.blue }, -- For brackets and parens.
        -- ["@text.todo.checked"] = { fg = c.green1 }, -- For brackets and parens.
        ["@text.warning"] = { fg = c.bg, bg = c.warning },
        ["@text.danger"] = { fg = c.bg, bg = c.error },

        ["@text.diff.add"] = { link = "DiffAdd" },
        ["@text.diff.delete"] = { link = "DiffDelete" },

        -- ["@namespace"] = { link = "Include" },

        -- tsx
        -- ["@tag.tsx"] = { fg = c.red },
        -- ["@constructor.tsx"] = { fg = c.blue1 },
        -- ["@tag.delimiter.tsx"] = { fg = util.darken(c.blue, 0.7) },

        -- LSP Semantic Token Groups
        ["@lsp.type.boolean"] = { link = "@boolean" },
        ["@lsp.type.builtinType"] = { link = "@type.builtin" },
        ["@lsp.type.comment"] = { link = "@comment" },
        ["@lsp.type.enum"] = { link = "@type" },
        ["@lsp.type.enumMember"] = { link = "@constant" },
        ["@lsp.type.escapeSequence"] = { link = "@string.escape" },
        ["@lsp.type.formatSpecifier"] = { link = "@punctuation.special" },
        -- ["@lsp.type.interface"] = { fg = util.lighten(c.blue1, 0.7) },
        ["@lsp.type.keyword"] = { link = "@keyword" },
        ["@lsp.type.namespace"] = { link = "@namespace" },
        ["@lsp.type.number"] = { link = "@number" },
        ["@lsp.type.operator"] = { link = "@operator" },
        ["@lsp.type.parameter"] = { link = "@parameter" },
        ["@lsp.type.property"] = { link = "@property" },
        ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
        ["@lsp.type.string.rust"] = { link = "@string" },
        ["@lsp.type.typeAlias"] = { link = "@type.definition" },
        ["@lsp.type.unresolvedReference"] = { undercurl = true, sp = c.error },
        ["@lsp.type.variable"] = {}, -- use treesitter styles for regular variables
        ["@lsp.typemod.class.defaultLibrary"] = { link = "@type.builtin" },
        ["@lsp.typemod.enum.defaultLibrary"] = { link = "@type.builtin" },
        ["@lsp.typemod.enumMember.defaultLibrary"] = { link = "@constant.builtin" },
        ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
        ["@lsp.typemod.keyword.async"] = { link = "@keyword.coroutine" },
        ["@lsp.typemod.macro.defaultLibrary"] = { link = "@function.builtin" },
        ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
        ["@lsp.typemod.operator.injected"] = { link = "@operator" },
        ["@lsp.typemod.string.injected"] = { link = "@string" },
        -- ["@lsp.typemod.type.defaultLibrary"] = { fg = util.darken(c.blue1, 0.8) },
        ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
        ["@lsp.typemod.variable.injected"] = { link = "@variable" },

        -- Languages specifics
        ["@function.builtin.bash"] = { fg = c.blue_light },
        ["@constructor.lua"] = { fg = c.magenta },

        -- Rainbow Delimiters
        -- RainbowDelimiterRed = { fg = c.magenta },
        -- RainbowDelimiterOrange = { fg = c.orange },
        -- RainbowDelimiterYellow = { fg = c.yellow },
        -- RainbowDelimiterGreen = { fg = c.green_light },
        -- RainbowDelimiterBlue = { fg = c.blue_light },
        -- RainbowDelimiterViolet = { fg = c.purple },
        -- RainbowDelimiterCyan = { fg = c.blue_medium },

        -- -- LspTrouble
        -- TroubleText = { fg = c.fg_dark },
        -- TroubleCount = { fg = c.magenta, bg = c.fg_gutter },
        -- TroubleNormal = { fg = c.fg_sidebar, bg = c.bg_sidebar },

        -- -- Illuminate
        -- illuminatedWord = { bg = c.fg_gutter },
        -- illuminatedCurWord = { bg = c.fg_gutter },
        -- IlluminatedWordText = { bg = c.fg_gutter },
        -- IlluminatedWordRead = { bg = c.fg_gutter },
        -- IlluminatedWordWrite = { bg = c.fg_gutter },

        -- Neogit
        -- NeogitBranch = { fg = c.magenta },
        -- NeogitRemote = { fg = c.purple },
        -- NeogitHunkHeader = { bg = c.bg_highlight, fg = c.fg },
        -- NeogitHunkHeaderHighlight = { bg = c.fg_gutter, fg = c.blue },
        -- NeogitDiffContextHighlight = { bg = util.darken(c.fg_gutter, 0.5), fg = c.fg_dark },
        -- NeogitDiffDeleteHighlight = { fg = c.git.delete, bg = c.diff.delete },
        -- NeogitDiffAddHighlight = { fg = c.git.add, bg = c.diff.add },

        -- Neotest
        -- NeotestPassed = { fg = c.green },
        -- NeotestRunning = { fg = c.yellow },
        -- NeotestFailed = { fg = c.red },
        -- NeotestSkipped = { fg = c.blue },
        -- NeotestTest = { fg = c.fg_sidebar },
        -- NeotestNamespace = { fg = c.green2 },
        -- NeotestFocused = { fg = c.yellow },
        -- NeotestFile = { fg = c.teal },
        -- NeotestDir = { fg = c.blue },
        -- NeotestBorder = { fg = c.blue },
        -- NeotestIndent = { fg = c.fg_sidebar },
        -- NeotestExpandMarker = { fg = c.fg_sidebar },
        -- NeotestAdapterName = { fg = c.purple, bold = true },
        -- NeotestWinSelect = { fg = c.blue },
        -- NeotestMarked = { fg = c.blue },
        -- NeotestTarget = { fg = c.blue },
        -- --[[ NeotestUnknown = {}, ]]

        -- GitGutter
        -- GitGutterAdd = { fg = c.gitSigns.add }, -- diff mode: Added line |diff.txt|
        -- GitGutterChange = { fg = c.gitSigns.change }, -- diff mode: Changed line |diff.txt|
        -- GitGutterDelete = { fg = c.gitSigns.delete }, -- diff mode: Deleted line |diff.txt|
        -- GitGutterAddLineNr = { fg = c.gitSigns.add },
        -- GitGutterChangeLineNr = { fg = c.gitSigns.change },
        -- GitGutterDeleteLineNr = { fg = c.gitSigns.delete },

        -- GitSigns
        -- GitSignsAdd = { fg = c.gitSigns.add }, -- diff mode: Added line |diff.txt|
        -- GitSignsChange = { fg = c.gitSigns.change }, -- diff mode: Changed line |diff.txt|
        -- GitSignsDelete = { fg = c.gitSigns.delete }, -- diff mode: Deleted line |diff.txt|

        -- Telescope
        TelescopeBorder = { fg = c.border_highlight, bg = options.transparent and c.none or c.bg_float },
        TelescopeNormal = { fg = c.grey_light, bg = options.transparent and c.none or c.bg_float },
        -- TelescopePromptNormal = {},
        TelescopePromptPrefix = { fg = c.blue_medium },
        TelescopeSelection = { fg = c.fg, bg = c.bg_statusline },
        TelescopeSelectionCaret = { fg = c.magenta, bg = c.bg_statusline },

        -- NvimTree
        -- NvimTreeNormal = { fg = c.fg_sidebar, bg = c.bg_sidebar },
        -- NvimTreeWinSeparator = {
        --   fg = options.styles.sidebars == "transparent" and c.border or c.bg_sidebar,
        --   bg = c.bg_sidebar,
        -- },
        -- NvimTreeNormalNC = { fg = c.fg_sidebar, bg = c.bg_sidebar },
        -- NvimTreeRootFolder = { fg = c.blue, bold = true },
        -- NvimTreeGitDirty = { fg = c.git.change },
        -- NvimTreeGitNew = { fg = c.git.add },
        -- NvimTreeGitDeleted = { fg = c.git.delete },
        -- NvimTreeOpenedFile = { bg = c.bg_highlight },
        -- NvimTreeSpecialFile = { fg = c.purple, underline = true },
        -- NvimTreeIndentMarker = { fg = c.fg_gutter },
        -- NvimTreeImageFile = { fg = c.fg_sidebar },
        -- NvimTreeSymlink = { fg = c.blue },
        -- NvimTreeFolderIcon = { bg = c.none, fg = c.blue },
        -- -- NvimTreeFolderName= { fg = c.fg_float },
        -- NeoTreeNormal = { fg = c.fg_sidebar, bg = c.bg_sidebar },
        -- NeoTreeNormalNC = { fg = c.fg_sidebar, bg = c.bg_sidebar },
        -- NeoTreeDimText = { fg = c.fg_gutter },

        -- -- Fern
        -- FernBranchText = { fg = c.blue },

        -- glyph palette
        -- GlyphPalette1 = { fg = c.red1 },
        -- GlyphPalette2 = { fg = c.green },
        -- GlyphPalette3 = { fg = c.yellow },
        -- GlyphPalette4 = { fg = c.blue },
        -- GlyphPalette6 = { fg = c.green1 },
        -- GlyphPalette7 = { fg = c.fg },
        -- GlyphPalette9 = { fg = c.red },

        -- Dashboard
        -- DashboardShortCut = { fg = c.cyan },
        -- DashboardHeader = { fg = c.blue },
        -- DashboardCenter = { fg = c.magenta },
        -- DashboardFooter = { fg = c.yellow, italic = true },

        -- Alpha
        -- AlphaShortcut = { fg = c.orange },
        AlphaHeader = { fg = c.orange },
        -- AlphaHeaderLabel = { fg = c.orange },
        -- AlphaFooter = { fg = c.grey_medium },
        -- AlphaButtons = { fg = c.blue_light },

        -- WhichKey
        WhichKey = { fg = c.yellow },
        WhichKeyGroup = { fg = c.magenta },
        WhichKeySeparator = { fg = c.grey_light, italic = false },
        WhichKeyDesc = { fg = c.fg },
        WhichKeyFloat = { bg = c.bg_sidebar },
        WhichKeyBorder = { bg = c.bg_sidebar },
        WhichKeyValue = { fg = c.grey_light },

        -- LspSaga
        -- DiagnosticWarning = { link = "DiagnosticWarn" },
        -- DiagnosticInformation = { link = "DiagnosticInfo" },
        --
        -- LspFloatWinNormal = { bg = c.bg_float },
        -- LspFloatWinBorder = { fg = c.border_highlight },
        -- LspSagaBorderTitle = { fg = c.cyan },
        -- LspSagaHoverBorder = { fg = c.blue },
        -- LspSagaRenameBorder = { fg = c.green },
        -- LspSagaDefPreviewBorder = { fg = c.green },
        -- LspSagaCodeActionBorder = { fg = c.blue },
        -- LspSagaFinderSelection = { fg = c.bg_visual },
        -- LspSagaCodeActionTitle = { fg = c.blue1 },
        -- LspSagaCodeActionContent = { fg = c.purple },
        -- LspSagaSignatureHelpBorder = { fg = c.red },
        -- ReferencesCount = { fg = c.purple },
        -- DefinitionCount = { fg = c.purple },
        -- DefinitionIcon = { fg = c.blue },
        -- ReferencesIcon = { fg = c.blue },
        -- TargetWord = { fg = c.cyan },

        -- NeoVim
        healthError = { fg = c.error },
        healthSuccess = { fg = c.green_alt }, -- TODO: check color
        healthWarning = { fg = c.warning },

        -- TreeSitter
        TreesitterContext = { bg = options.transparent and c.none or util.darken(c.fg_gutter, 0.8) },
        TreesitterContextBottom = { sp = c.blue_light, underline = true },
        Hlargs = { fg = c.yellow },

        -- BufferLine
        -- BufferLineIndicatorSelected = { fg = c.git.change },

        -- Barbar
        -- BufferCurrent = { bg = c.bg, fg = c.fg },
        -- BufferCurrentERROR = { bg = c.bg, fg = c.error },
        -- BufferCurrentHINT = { bg = c.bg, fg = c.hint },
        -- -- BufferCurrentIcon = { bg = c.bg, fg = c.},
        -- BufferCurrentINFO = { bg = c.bg, fg = c.info },
        -- BufferCurrentWARN = { bg = c.bg, fg = c.warning },
        -- BufferCurrentIndex = { bg = c.bg, fg = c.info },
        -- BufferCurrentMod = { bg = c.bg, fg = c.warning },
        -- BufferCurrentSign = { bg = c.bg, fg = c.bg },
        -- BufferCurrentTarget = { bg = c.bg, fg = c.red },
        -- BufferAlternate = { bg = c.fg_gutter, fg = c.fg },
        -- BufferAlternateERROR = { bg = c.fg_gutter, fg = c.error },
        -- BufferAlternateHINT = { bg = c.fg_gutter, fg = c.hint },
        -- -- BufferAlternateIcon = { bg = c.fg_gutter, fg = c. },
        -- BufferAlternateIndex = { bg = c.fg_gutter, fg = c.info },
        -- BufferAlternateINFO = { bg = c.fg_gutter, fg = c.info },
        -- BufferAlternateMod = { bg = c.fg_gutter, fg = c.warning },
        -- BufferAlternateSign = { bg = c.fg_gutter, fg = c.info },
        -- BufferAlternateTarget = { bg = c.fg_gutter, fg = c.red },
        -- BufferAlternateWARN = { bg = c.fg_gutter, fg = c.warning },
        -- BufferVisible = { bg = c.bg_statusline, fg = c.fg },
        -- BufferVisibleERROR = { bg = c.bg_statusline, fg = c.error },
        -- BufferVisibleHINT = { bg = c.bg_statusline, fg = c.hint },
        -- -- BufferVisibleIcon = { bg = c.bg_statusline, fg = c. },
        -- BufferVisibleINFO = { bg = c.bg_statusline, fg = c.info },
        -- BufferVisibleWARN = { bg = c.bg_statusline, fg = c.warning },
        -- BufferVisibleIndex = { bg = c.bg_statusline, fg = c.info },
        -- BufferVisibleMod = { bg = c.bg_statusline, fg = c.warning },
        -- BufferVisibleSign = { bg = c.bg_statusline, fg = c.info },
        -- BufferVisibleTarget = { bg = c.bg_statusline, fg = c.red },
        -- BufferInactive = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.dark5, 0.8) },
        -- BufferInactiveERROR = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.error, 0.8) },
        -- BufferInactiveHINT = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.hint, 0.8) },
        -- -- BufferInactiveIcon = { bg = c.bg_statusline, fg = util.darken(c., 0.1) },
        -- BufferInactiveINFO = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.info, 0.8) },
        -- BufferInactiveWARN = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.warning, 0.8) },
        -- BufferInactiveIndex = { bg = util.darken(c.bg_highlight, 0.4), fg = c.dark5 },
        -- BufferInactiveMod = { bg = util.darken(c.bg_highlight, 0.4), fg = util.darken(c.warning, 0.8) },
        -- BufferInactiveSign = { bg = util.darken(c.bg_highlight, 0.4), fg = c.bg },
        -- BufferInactiveTarget = { bg = util.darken(c.bg_highlight, 0.4), fg = c.red },
        -- BufferOffset = { bg = c.bg_statusline, fg = c.dark5 },
        -- BufferTabpageFill = { bg = util.darken(c.bg_highlight, 0.8), fg = c.dark5 },
        -- BufferTabpages = { bg = c.bg_statusline, fg = c.none },

        -- Sneak
        -- Sneak = { fg = c.bg_highlight, bg = c.magenta },
        -- SneakScope = { bg = c.bg_visual },

        -- Hop
        -- HopNextKey = { fg = c.magenta2, bold = true },
        -- HopNextKey1 = { fg = c.blue2, bold = true },
        -- HopNextKey2 = { fg = util.darken(c.blue2, 0.6) },
        -- HopUnmatched = { fg = c.grey_dark },

        -- TSNodeKey = { fg = c.magenta2, bold = true },
        -- TSNodeUnmatched = { fg = c.grey_dark },

        -- LeapMatch = { bg = c.magenta2, fg = c.fg, bold = true },
        -- LeapLabelPrimary = { fg = c.magenta2, bold = true },
        -- LeapLabelSecondary = { fg = c.green1, bold = true },
        -- LeapBackdrop = { fg = c.grey_dark },

        -- FlashBackdrop = { fg = c.grey_dark },
        -- FlashLabel = { bg = c.magenta2, bold = true, fg = c.fg },

        -- LightspeedGreyWash = { fg = c.grey_dark },
        -- -- LightspeedCursor = { link = "Cursor" },
        -- LightspeedLabel = { fg = c.magenta2, bold = true, underline = true },
        -- LightspeedLabelDistant = { fg = c.green1, bold = true, underline = true },
        -- LightspeedLabelDistantOverlapped = { fg = c.green2, underline = true },
        -- LightspeedLabelOverlapped = { fg = c.magenta2, underline = true },
        -- LightspeedMaskedChar = { fg = c.orange },
        -- LightspeedOneCharMatch = { bg = c.magenta2, fg = c.fg, bold = true },
        -- LightspeedPendingOpArea = { bg = c.magenta2, fg = c.fg },
        -- LightspeedShortcut = { bg = c.magenta2, fg = c.fg, bold = true, underline = true },
        -- -- LightspeedShortcutOverlapped = { link = "LightspeedShortcut" },
        -- -- LightspeedUniqueChar = { link = "LightspeedUnlabeledMatch" },
        -- LightspeedUnlabeledMatch = { fg = c.blue2, bold = true },

        -- Cmp
        -- CmpDocumentation = { fg = c.fg, bg = c.bg_float },
        -- CmpDocumentationBorder = { fg = c.border_highlight, bg = c.bg_float },
        -- CmpGhostText = { fg = c.terminal_black },
        --
        -- CmpItemAbbr = { fg = c.fg, bg = c.none },
        -- CmpItemAbbrDeprecated = { fg = c.fg_gutter, bg = c.none, strikethrough = true },
        -- CmpItemAbbrMatch = { fg = c.blue1, bg = c.none },
        -- CmpItemAbbrMatchFuzzy = { fg = c.blue1, bg = c.none },
        --
        -- CmpItemMenu = { fg = c.comment, bg = c.none },
        --
        -- CmpItemKindDefault = { fg = c.fg_dark, bg = c.none },
        --
        -- CmpItemKindKeyword = { fg = c.cyan, bg = c.none },
        --
        -- CmpItemKindVariable = { fg = c.magenta, bg = c.none },
        -- CmpItemKindConstant = { fg = c.magenta, bg = c.none },
        -- CmpItemKindReference = { fg = c.magenta, bg = c.none },
        -- CmpItemKindValue = { fg = c.magenta, bg = c.none },
        -- CmpItemKindCopilot = { fg = c.teal, bg = c.none },
        --
        -- CmpItemKindFunction = { fg = c.blue, bg = c.none },
        -- CmpItemKindMethod = { fg = c.blue, bg = c.none },
        -- CmpItemKindConstructor = { fg = c.blue, bg = c.none },
        --
        -- CmpItemKindClass = { fg = c.orange, bg = c.none },
        -- CmpItemKindInterface = { fg = c.orange, bg = c.none },
        -- CmpItemKindStruct = { fg = c.orange, bg = c.none },
        -- CmpItemKindEvent = { fg = c.orange, bg = c.none },
        -- CmpItemKindEnum = { fg = c.orange, bg = c.none },
        -- CmpItemKindUnit = { fg = c.orange, bg = c.none },
        --
        -- CmpItemKindModule = { fg = c.yellow, bg = c.none },
        --
        -- CmpItemKindProperty = { fg = c.green1, bg = c.none },
        -- CmpItemKindField = { fg = c.green1, bg = c.none },
        -- CmpItemKindTypeParameter = { fg = c.green1, bg = c.none },
        -- CmpItemKindEnumMember = { fg = c.green1, bg = c.none },
        -- CmpItemKindOperator = { fg = c.green1, bg = c.none },
        -- CmpItemKindSnippet = { fg = c.dark5, bg = c.none },

        -- navic
        -- NavicIconsFile = { fg = c.fg, bg = c.none },
        -- NavicIconsModule = { fg = c.yellow, bg = c.none },
        -- NavicIconsNamespace = { fg = c.fg, bg = c.none },
        -- NavicIconsPackage = { fg = c.fg, bg = c.none },
        -- NavicIconsClass = { fg = c.orange, bg = c.none },
        -- NavicIconsMethod = { fg = c.blue, bg = c.none },
        -- NavicIconsProperty = { fg = c.green1, bg = c.none },
        -- NavicIconsField = { fg = c.green1, bg = c.none },
        -- NavicIconsConstructor = { fg = c.orange, bg = c.none },
        -- NavicIconsEnum = { fg = c.orange, bg = c.none },
        -- NavicIconsInterface = { fg = c.orange, bg = c.none },
        -- NavicIconsFunction = { fg = c.blue, bg = c.none },
        -- NavicIconsVariable = { fg = c.magenta, bg = c.none },
        -- NavicIconsConstant = { fg = c.magenta, bg = c.none },
        -- NavicIconsString = { fg = c.green, bg = c.none },
        -- NavicIconsNumber = { fg = c.orange, bg = c.none },
        -- NavicIconsBoolean = { fg = c.orange, bg = c.none },
        -- NavicIconsArray = { fg = c.orange, bg = c.none },
        -- NavicIconsObject = { fg = c.orange, bg = c.none },
        -- NavicIconsKey = { fg = c.purple, bg = c.none },
        -- NavicIconsKeyword = { fg = c.purple, bg = c.none },
        -- NavicIconsNull = { fg = c.orange, bg = c.none },
        -- NavicIconsEnumMember = { fg = c.green1, bg = c.none },
        -- NavicIconsStruct = { fg = c.orange, bg = c.none },
        -- NavicIconsEvent = { fg = c.orange, bg = c.none },
        -- NavicIconsOperator = { fg = c.fg, bg = c.none },
        -- NavicIconsTypeParameter = { fg = c.green1, bg = c.none },
        -- NavicText = { fg = c.fg, bg = c.none },
        -- NavicSeparator = { fg = c.fg, bg = c.none },

        -- Scrollbar
        -- ScrollbarHandle = { fg = c.none, bg = c.bg_highlight },
        --
        -- ScrollbarSearchHandle = { fg = c.orange, bg = c.bg_highlight },
        -- ScrollbarSearch = { fg = c.orange, bg = c.none },
        --
        -- ScrollbarErrorHandle = { fg = c.error, bg = c.bg_highlight },
        -- ScrollbarError = { fg = c.error, bg = c.none },
        --
        -- ScrollbarWarnHandle = { fg = c.warning, bg = c.bg_highlight },
        -- ScrollbarWarn = { fg = c.warning, bg = c.none },
        --
        -- ScrollbarInfoHandle = { fg = c.info, bg = c.bg_highlight },
        -- ScrollbarInfo = { fg = c.info, bg = c.none },
        --
        -- ScrollbarHintHandle = { fg = c.hint, bg = c.bg_highlight },
        -- ScrollbarHint = { fg = c.hint, bg = c.none },
        --
        -- ScrollbarMiscHandle = { fg = c.purple, bg = c.bg_highlight },
        -- ScrollbarMisc = { fg = c.purple, bg = c.none },

        -- Yanky
        -- YankyPut = { link = "IncSearch" },
        -- YankyYanked = { link = "IncSearch" },

        -- Lazy
        LazyProgressDone = { fg = c.magenta, bold = true },
        LazyProgressTodo = { fg = c.fg_gutter, bold = true },

        -- Notify
        -- NotifyBackground = { fg = c.fg, bg = c.bg },
        -- --- Border
        -- NotifyERRORBorder = { fg = util.darken(c.error, 0.3), bg = options.transparent and c.none or c.bg },
        -- NotifyWARNBorder = { fg = util.darken(c.warning, 0.3), bg = options.transparent and c.none or c.bg },
        -- NotifyINFOBorder = { fg = util.darken(c.info, 0.3), bg = options.transparent and c.none or c.bg },
        -- NotifyDEBUGBorder = { fg = util.darken(c.comment, 0.3), bg = options.transparent and c.none or c.bg },
        -- NotifyTRACEBorder = { fg = util.darken(c.purple, 0.3), bg = options.transparent and c.none or c.bg },
        -- --- Icons
        -- NotifyERRORIcon = { fg = c.error },
        -- NotifyWARNIcon = { fg = c.warning },
        -- NotifyINFOIcon = { fg = c.info },
        -- NotifyDEBUGIcon = { fg = c.comment },
        -- NotifyTRACEIcon = { fg = c.purple },
        -- --- Title
        -- NotifyERRORTitle = { fg = c.error },
        -- NotifyWARNTitle = { fg = c.warning },
        -- NotifyINFOTitle = { fg = c.info },
        -- NotifyDEBUGTitle = { fg = c.comment },
        -- NotifyTRACETitle = { fg = c.purple },
        -- --- Body
        -- NotifyERRORBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
        -- NotifyWARNBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
        -- NotifyINFOBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
        -- NotifyDEBUGBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },
        -- NotifyTRACEBody = { fg = c.fg, bg = options.transparent and c.none or c.bg },

        -- Mini
        -- MiniCompletionActiveParameter = { underline = true },
        --
        -- MiniCursorword = { bg = c.fg_gutter },
        -- MiniCursorwordCurrent = { bg = c.fg_gutter },
        --
        -- MiniIndentscopeSymbol = { fg = c.blue1, nocombine = true },
        -- MiniIndentscopePrefix = { nocombine = true }, -- Make it invisible
        --
        -- MiniJump = { bg = c.magenta2, fg = "#ffffff" },
        --
        -- MiniJump2dSpot = { fg = c.magenta2, bold = true, nocombine = true },
        --
        -- MiniStarterCurrent = { nocombine = true },
        -- MiniStarterFooter = { fg = c.yellow, italic = true },
        -- MiniStarterHeader = { fg = c.blue },
        -- MiniStarterInactive = { fg = c.comment, style = options.styles.comments },
        -- MiniStarterItem = { fg = c.fg, bg = options.transparent and c.none or c.bg },
        -- MiniStarterItemBullet = { fg = c.border_highlight },
        -- MiniStarterItemPrefix = { fg = c.warning },
        -- MiniStarterSection = { fg = c.blue1 },
        -- MiniStarterQuery = { fg = c.info },
        --
        -- MiniStatuslineDevinfo = { fg = c.fg_dark, bg = c.bg_highlight },
        -- MiniStatuslineFileinfo = { fg = c.fg_dark, bg = c.bg_highlight },
        -- MiniStatuslineFilename = { fg = c.fg_dark, bg = c.fg_gutter },
        -- MiniStatuslineInactive = { fg = c.blue, bg = c.bg_statusline },
        -- MiniStatuslineModeCommand = { fg = c.black, bg = c.yellow, bold = true },
        -- MiniStatuslineModeInsert = { fg = c.black, bg = c.green, bold = true },
        -- MiniStatuslineModeNormal = { fg = c.black, bg = c.blue, bold = true },
        -- MiniStatuslineModeOther = { fg = c.black, bg = c.teal, bold = true },
        -- MiniStatuslineModeReplace = { fg = c.black, bg = c.red, bold = true },
        -- MiniStatuslineModeVisual = { fg = c.black, bg = c.magenta, bold = true },
        --
        -- MiniSurround = { bg = c.orange, fg = c.black },
        --
        -- MiniTablineCurrent = { fg = c.fg, bg = c.fg_gutter },
        -- MiniTablineFill = { bg = c.black },
        -- MiniTablineHidden = { fg = c.dark5, bg = c.bg_statusline },
        -- MiniTablineModifiedCurrent = { fg = c.warning, bg = c.fg_gutter },
        -- MiniTablineModifiedHidden = { bg = c.bg_statusline, fg = util.darken(c.warning, 0.7) },
        -- MiniTablineModifiedVisible = { fg = c.warning, bg = c.bg_statusline },
        -- MiniTablineTabpagesection = { bg = c.bg_statusline, fg = c.none },
        -- MiniTablineVisible = { fg = c.fg, bg = c.bg_statusline },
        --
        -- MiniTestEmphasis = { bold = true },
        -- MiniTestFail = { fg = c.red, bold = true },
        -- MiniTestPass = { fg = c.green, bold = true },
        --
        -- MiniTrailspace = { bg = c.red },

        -- Noice
        -- NoiceCompletionItemKindDefault = { fg = c.fg_dark, bg = c.none },
        --
        -- NoiceCompletionItemKindKeyword = { fg = c.cyan, bg = c.none },
        --
        -- NoiceCompletionItemKindVariable = { fg = c.magenta, bg = c.none },
        -- NoiceCompletionItemKindConstant = { fg = c.magenta, bg = c.none },
        -- NoiceCompletionItemKindReference = { fg = c.magenta, bg = c.none },
        -- NoiceCompletionItemKindValue = { fg = c.magenta, bg = c.none },
        --
        -- NoiceCompletionItemKindFunction = { fg = c.blue, bg = c.none },
        -- NoiceCompletionItemKindMethod = { fg = c.blue, bg = c.none },
        -- NoiceCompletionItemKindConstructor = { fg = c.blue, bg = c.none },
        --
        -- NoiceCompletionItemKindClass = { fg = c.orange, bg = c.none },
        -- NoiceCompletionItemKindInterface = { fg = c.orange, bg = c.none },
        -- NoiceCompletionItemKindStruct = { fg = c.orange, bg = c.none },
        -- NoiceCompletionItemKindEvent = { fg = c.orange, bg = c.none },
        -- NoiceCompletionItemKindEnum = { fg = c.orange, bg = c.none },
        -- NoiceCompletionItemKindUnit = { fg = c.orange, bg = c.none },
        --
        -- NoiceCompletionItemKindModule = { fg = c.yellow, bg = c.none },
        --
        -- NoiceCompletionItemKindProperty = { fg = c.green1, bg = c.none },
        -- NoiceCompletionItemKindField = { fg = c.green1, bg = c.none },
        -- NoiceCompletionItemKindTypeParameter = { fg = c.green1, bg = c.none },
        -- NoiceCompletionItemKindEnumMember = { fg = c.green1, bg = c.none },
        -- NoiceCompletionItemKindOperator = { fg = c.green1, bg = c.none },
        -- NoiceCompletionItemKindSnippet = { fg = c.dark5, bg = c.none },
    }

    if not vim.diagnostic then
        local severity_map = {
            Error = "Error",
            Warn = "Warning",
            Info = "Information",
            Hint = "Hint",
        }
        local types = { "Default", "VirtualText", "Underline" }
        for _, type in ipairs(types) do
            for snew, sold in pairs(severity_map) do
                theme.highlights["LspDiagnostics" .. type .. sold] = {
                    link = "Diagnostic" .. (type == "Default" and "" or type) .. snew,
                }
            end
        end
    end

    ---@type table<string, table>
    theme.defer = {}

    if options.hide_inactive_statusline then
        local inactive = { underline = true, bg = c.none, fg = c.bg, sp = c.border }

        -- StatusLineNC
        theme.highlights.StatusLineNC = inactive

        -- LuaLine
        for _, section in ipairs({ "a", "b", "c" }) do
            theme.defer["lualine_" .. section .. "_inactive"] = inactive
        end

        -- mini.statusline
        theme.highlights.MiniStatuslineInactive = inactive
    end

    options.on_highlights(theme.highlights, theme.colors)

    if config.is_day() then
        -- FIXME: The day theme need a lot of work. Maybe only invert neutrals.
        util.invert_colors(theme.colors)
        util.invert_highlights(theme.highlights)
    end

    return theme
end

return M
