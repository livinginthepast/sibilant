use Mix.Config

config :sibilant, :extensions,
  html: ~r"^(html|htm)$",
  markdown: ~r"^(md|markdown)$"

config :sibilant, :earmark,
  breaks: false,
  smartypants: true

config :sibilant, :root, "priv/site"
