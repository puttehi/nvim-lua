--[[
Command 	Lua Function 	Description
:StrudelLaunch 	strudel.launch() 	Launch a Strudel browser session and start syncing the current buffer.
:StrudelQuit 	strudel.quit() 	Quit the Strudel session and close the browser.
:StrudelToggle 	strudel.toggle() 	Toggle playback (the Play/Stop button) in the Strudel editor.
:StrudelUpdate 	strudel.update() 	Trigger code evaluation (the Update button) in the Strudel editor. It will start playback if not already started.
:StrudelStop 	strudel.stop() 	Stop playback in Strudel (calls strudelMirror.stop()).
:StrudelSetBuffer 	strudel.set_buffer() 	Change the buffer that is synced to Strudel (optionally by providing a buffer number, current buffer otherwise).
:StrudelExecute 	strudel.execute() 	Combo command: set current buffer and trigger Update.
]]

return {
    "gruvw/strudel.nvim",
    cmd = "StrudelLaunch",
    build = "npm install",
    config = function()
        require("strudel").setup({
            -- Strudel web user interface related options
            ui = {
                -- Maximise the menu panel
                -- (optional, default: true)
                maximise_menu_panel = true,
                -- Hide the Strudel menu panel (and handle)
                -- (optional, default: false)
                hide_menu_panel = false,
                -- Hide the default Strudel top bar (controls)
                -- (optional, default: false)
                hide_top_bar = false,
                -- Hide the Strudel code editor
                -- (optional, default: false)
                hide_code_editor = false,
                -- Hide the Strudel eval error display under the editor
                -- (optional, default: false)
                hide_error_display = false,
            },
            -- Set to `true` to automatically trigger the code evaluation after saving the buffer content
            -- Only works if the playback was already started (doesn't start the playback on save)
            -- (optional, default: false)
            update_on_save = false,
            -- Enable two-way cursor position sync between Neovim and Strudel editor.
            -- (optional, default: true)
            sync_cursor = true,
            -- Report evaluation errors from Strudel as Neovim notifications.
            -- (optional, default: true)
            report_eval_errors = true,
            -- Path to a custom CSS file to style the Strudel web editor (base64-encoded and injected at launch).
            -- This allows you to override or extend the default Strudel UI appearance.
            -- (optional, default: nil)
            custom_css_file = "/path/to/your/custom.css",
            -- Headless mode: set to `true` to run the browser without launching a window
            -- (optional, default: false)
            headless = false,
            -- Path to the directory where Strudel browser user data (cookies, sessions, etc.) is stored
            -- (optional, default: `~/.cache/strudel-nvim/`)
            browser_data_dir = "~/.cache/strudel-nvim/",
        })

        local strudel = require("strudel")

        vim.keymap.set("n", "<leader>sl", strudel.launch, { desc = "Launch Strudel" })
        vim.keymap.set("n", "<leader>sq", strudel.quit, { desc = "Quit Strudel" })
        vim.keymap.set("n", "<leader>st", strudel.toggle, { desc = "Strudel Toggle Play/Stop" })
        vim.keymap.set("n", "<leader>su", strudel.update, { desc = "Strudel Update" })
        vim.keymap.set("n", "<leader>ss", strudel.stop, { desc = "Strudel Stop Playback" })
        vim.keymap.set(
            "n",
            "<leader>sb",
            strudel.set_buffer,
            { desc = "Strudel set current buffer" }
        )
        vim.keymap.set(
            "n",
            "<leader>sx",
            strudel.execute,
            { desc = "Strudel set current buffer and update" }
        )
    end,
}
