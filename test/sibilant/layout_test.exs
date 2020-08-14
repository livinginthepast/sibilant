defmodule Sibilant.LayoutTest do
  use Sibilant.SimpleCase

  alias Sibilant.Layout

  setup do
    :ok = Gestalt.replace_config(:sibilant, :root, "test/fixtures", self())

    :ok =
      Gestalt.replace_config(
        :liquid,
        :file_system,
        {Sibilant.Extra.Liquid.FileSystem, "test/fixtures/includes"},
        self()
      )
  end

  describe "path" do
    test "joins filename to the root path" do
      "some.file" |> Layout.path() |> assert_eq("test/fixtures/layout/some.file")
    end
  end

  describe "read" do
    test "reads a layout file and parses it into a Layout" do
      expected_layout = """
      <!doctype html public "✰">
      <html lang="en">
      <head>
        <title dir="ltr">{{ page.title }}</title>
      </head>
      <body>
      {% include 'menu.html' %}
      <main>
        {{ content }}
      </main>
      </body>
      </html>
      """

      Layout.read("default.html")
      |> assert_eq(
        {:ok,
         %Layout{
           body: expected_layout,
           type: :html
         }}
      )
    end
  end

  describe "render" do
    test "evaluates liquid tags in the layout and inserts content" do
      layout = """
      <!doctype html public "✰">
      <html lang="en">
      <body>
      {% include 'menu.html' %}
      <main>{{ content }}</main>
      </body>
      </html>
      """

      %Layout{body: layout, type: :html}
      |> Layout.render(content: "<div>Ima webpage!</div>")
      |> assert_eq({
        :ok,
        """
        <!doctype html public "✰">
        <html lang="en">
        <body>
        <nav>
          <ul>
            <li><a href="/">Root</a></li>
          </ul>
        </nav>
        <main><div>Ima webpage!</div></main>
        </body>
        </html>
        """
      })
    end
  end
end
