return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Forzar el uso del tema actual (monocromático)
      opts.options.theme = "auto"
      -- Eliminar separadores internos para un look más limpio
      opts.options.component_separators = { left = "", right = "" }
      -- Aplicar los semicírculos en los extremos de los bloques
      opts.options.section_separators = { left = "", right = "" }
    end,
  },
}
