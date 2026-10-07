return {
  -- 1. Instalar y configurar Lackluster
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("lackluster").setup({
        disable_background = true, -- Mantiene la transparencia de Kitty
      })
    end,
  },

  -- 2. Decirle al núcleo de LazyVim que use Lackluster por defecto
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "lackluster",
    },
  },

  -- 3. Desactivar Tokyonight para no descargar paquetes innecesarios
  { "folke/tokyonight.nvim", enabled = false },
}
