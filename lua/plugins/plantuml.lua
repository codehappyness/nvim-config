return {
  "weirongxu/plantuml-previewer.vim",
  dependencies = {
    "aklt/plantuml-syntax",
    "tyru/open-browser.vim",
  },
  ft = { "plantuml" },
  init = function()
    vim.g["plantuml_previewer#plantuml_jar_path"] = "/home/codehappyness/.local/share/plantuml/plantuml.jar"
    vim.filetype.add({
      extension = {
        puml = "plantuml",
        uml = "plantuml",
        plantuml = "plantuml",
        pu = "plantuml",
        iuml = "plantuml",
      },
    })
  end,
  keys = {
    { "<leader>po", "<cmd>PlantumlOpen<cr>", desc = "Open PlantUML Preview" },
    { "<leader>ps", "<cmd>PlantumlStop<cr>", desc = "Stop PlantUML Preview" },
  },
}
