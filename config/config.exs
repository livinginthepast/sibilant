use Mix.Config

config :sibilant, :file_types,
  html: [compiler: Sibilant.Compiler.Noop, pattern: ~r"^(html|htm)$"],
  markdown: [compiler: Sibilant.Compiler.Markdown, pattern: ~r"^(md|markdown)$"]

config :sibilant, :earmark,
  breaks: false,
  smartypants: true

config :sibilant, :root, "priv/site"

config :liquid,
  file_system: {Sibilant.Extra.Liquid.FileSystem, "priv/site/includes"}
