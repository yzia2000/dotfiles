local dap = require('dap')

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/.local/share/nvim/gadgets/vscode-node-debug2/out/src/nodeDebug.js'},
}

dap.configurations.javascript = {
  {
    type = 'node2',
    name = 'Docker Node TS',
    request = "attach",
    protocol = "auto",
    stopOnEntry = true,
    restart = true,
    port = 9229,
    cwd = "${workspaceFolder}",
    remoteRoot = "/app/dist",
    localRoot = "${workspaceFolder}/dist",
    outFiles = {
      "${workspaceFolder}/dist/**/*.js"
    },
    skipFiles = { "<node_internals>/**/*.js"
    },
    internalConsoleOptions = "neverOpen"
  },
}

dap.adapters.rust = {
  type = 'executable',
  attach = {
    pidProperty = "pid",
    pidSelect = "ask"
  },
  command = 'lldb-vscode',
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
  },
  name = "lldb"
}

dap.configurations.rust = {
  {
    name = "Rust",
    console = "externalConsole",
    type = "rust",
    request = "launch",
    stopOnEntry = true,
    terminal = "external",
    restart = true,
    sourceLanguages = {"rust"},
    program = "${workspaceFolder}/target/debug/source-compiler",
    cwd = "${workspaceFolder}",
    cargo = {
        args = { "build" }
    }
  }
}

dap.defaults.fallback.external_terminal = {
  command = '/usr/local/bin/st';
  args = {'-e'};
}

dap.adapters.c = {
  type = 'executable',
  attach = {
    pidProperty = "pid",
    pidSelect = "ask"
  },
  command = 'lldb-vscode',
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
  },
  name = "lldb"
}

dap.configurations.c = {
  {
    name = "C",
    console = "externalConsole",
    type = "c",
    request = "launch",
    stopOnEntry = true,
    terminal = "external",
    restart = true,
    sourceLanguages = {"c"},
    program = "${workspaceFolder}/server",
    cwd = "${workspaceFolder}",
  }
}

dap.defaults.fallback.external_terminal = {
  command = '/usr/local/bin/st';
  args = {'-e'};
}
