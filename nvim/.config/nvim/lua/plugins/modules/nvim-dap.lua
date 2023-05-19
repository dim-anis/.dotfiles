return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-telescope/telescope-dap.nvim",
    "mxsdev/nvim-dap-vscode-js",
    -- UI for the debugger
    {
      "rcarriga/nvim-dap-ui",
      keys = {
        { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } }
      },
      opts = {
        icons = { expanded = '▾', collapsed = '▸' },
        mappings = {
          expand = { '<CR>', '<2-LeftMouse>' },
          open = 'o',
          remove = 'd',
          edit = 'e',
          repl = 'r',
          toggle = 't',
        },
        expand_lines = vim.fn.has('nvim-0.7'),
        layouts = {
          {
            elements = {
              -- Elements can be strings or table with id and size keys.
              { id = 'scopes', size = 0.25 },
              'breakpoints',
              'stacks',
              'watches',
            },
            size = 40,
            position = 'left',
          },
          {
            elements = {
              { id = 'repl',    size = 0.5 },
              { id = 'console', size = 0.5 },
            },
            size = 10,
            position = 'bottom',
          },
        },
        floating = {
          max_height = nil,   -- These can be integers or a float between 0 and 1.
          max_width = nil,    -- Floats will be treated as percentage of your screen.
          border = 'rounded', -- Border style. Can be 'single', 'double' or 'rounded'
          mappings = {
            close = { 'q', '<Esc>' },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil,
        }
      },
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        filter_references_pattern = '<module',
        virt_text_pos = 'eol',
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
      },
      -- config = function(_, opts)
      --
      -- end
    },
    -- {
    --   "jay-babu/mason-nvim-dap.nvim",
    --   dependencies = "mason.nvim",
    --   cmd = { "DapInstall", "DapUninstall" },
    --   opts = {
    --     automatic_installation = true,
    --     handlers = {
    --     },
    --     ensure_installed = { 'js' },
    --   },
    -- },
  },
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
      "Breakpoint Condition" },
    {
      "<leader>dt",
      function() require("dap").toggle_breakpoint() end,
      desc =
      "Toggle Breakpoint"
    },
    {
      "<leader>dc",
      function() require("dap").continue() end,
      desc =
      "Continue"
    },
    {
      "<leader>dC",
      function() require("dap").run_to_cursor() end,
      desc =
      "Run to Cursor"
    },
    {
      "<leader>dg",
      function() require("dap").goto_() end,
      desc =
      "Go to line (no execute)"
    },
    {
      "<leader>di",
      function() require("dap").step_into() end,
      desc =
      "Step Into"
    },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end,   desc = "Up" },
    {
      "<leader>dl",
      function() require("dap").run_last() end,
      desc =
      "Run Last"
    },
    {
      "<leader>do",
      function() require("dap").step_out() end,
      desc =
      "Step Out"
    },
    {
      "<leader>dO",
      function() require("dap").step_over() end,
      desc =
      "Step Over"
    },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    {
      "<leader>dr",
      function() require("dap").repl.toggle() end,
      desc =
      "Toggle REPL"
    },
    {
      "<leader>ds",
      function() require("dap").session() end,
      desc =
      "Session"
    },
    {
      "<leader>dT",
      function() require("dap").terminate() end,
      desc =
      "Terminate"
    },
    {
      "<leader>dw",
      function() require("dap.ui.widgets").hover() end,
      desc =
      "Widgets"
    },
  },
  config = function()
    local dap = require('dap')
    local utils = require('dap.utils')

    -- # Signs
    vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '🟧', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '🟩', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '🈁', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '⬜', texthl = '', linehl = '', numhl = '' })

    require('dap-vscode-js').setup({
      debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
      debugger_cmd = { 'js-debug-adapter' },
      adapters = {
        "pwa-node",
        'pwa-chrome',
        'pwa-msedge',
        'node-terminal',
        'pwa-extensionHost',
      },
    })

    for _, language in ipairs({
      'typescript',
      'javascript',
      'javascriptreact',
      'typescriptreact',
    }) do
      dap.configurations[language] = {
        {
          name = 'TS-Node Launch',
          type = 'pwa-node',
          request = 'launch',
          program = '${file}',
          cwd = '${workspaceFolder}',
          sourceMaps = true,
          protocol = 'inspector',
          console = 'integratedTerminal',
          resolveSourceMapLocations = {
            '${workspaceFolder}/dist/**/*.js',
            '${workspaceFolder}/**',
            '!**/node_modules/**',
          },
          runtimeExecutable = '${workspaceFolder}/node_modules/.bin/ts-node',
        },
        {
          name = 'Node Attach',
          type = 'pwa-node',
          request = 'attach',
          processId = utils.pick_process,
          cwd = '${workspaceFolder}',
          sourceMaps = true,
          protocol = 'inspector',
          console = 'integratedTerminal',
          resolveSourceMapLocations = {
            '${workspaceFolder}/dist/**/*.js',
            '${workspaceFolder}/**',
            '!**/node_modules/**',
          },
        },
        {
          name = 'Jest Launch',
          type = 'pwa-node',
          request = 'launch',
          -- trace = true, -- include debugger info
          runtimeExecutable = 'node',
          runtimeArgs = {
            './node_modules/jest/bin/jest.js',
            '--runInBand',
          },
          rootPath = '${workspaceFolder}',
          cwd = '${workspaceFolder}',
          console = 'integratedTerminal',
          internalConsoleOptions = 'neverOpen',
        },
      }
    end

    -- ## DAP `launch.json`
    require('dap.ext.vscode').load_launchjs(nil, {
      ['pwa-node'] = {
        'javascript',
        'typescript',
      },
      ['node'] = {
        'javascript',
        'typescript',
      }
    })
  end
}
