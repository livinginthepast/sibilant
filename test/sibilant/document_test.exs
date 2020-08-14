defmodule Sibilant.DocumentTest do
  use Sibilant.SimpleCase, async: true

  alias Sibilant.Frontmatter
  alias Sibilant.Document

  describe "parse" do
    test "splits front matter from body" do
      """
      ---
      layout: something
      something: else
      ---

      I am a web page.

      * I
      * Have
      * A
      * List
      """
      |> Document.parse(type: :markdown)
      |> assert_eq({
        :ok,
        %Document{
          body: "I am a web page.\n\n* I\n* Have\n* A\n* List",
          frontmatter: %Frontmatter{
            layout: :something,
            extra: %{
              "something" => "else"
            },
            title: nil
          },
          type: :markdown
        }
      })
    end
  end

  describe "render" do
    setup do
      :ok = Gestalt.replace_config(:sibilant, :root, "test/fixtures", self())
    end

    test "renders to html" do
      body = """
      I am a web page.

      * I
      * Have
      * A
      * List

      {% if true %}
      This is true.
      {% else %}
      But also false.
      {% endif %}
      """

      %Document{
        body: body,
        frontmatter: %Frontmatter{layout: :default, extra: %{}, title: "I am a page title"},
        type: :markdown
      }
      |> Document.render()
      |> assert_eq({
        :ok,
        """
        <p>I am a web page.</p>
        <ul>
          <li>I</li>
          <li>Have</li>
          <li>A</li>
          <li>List</li>
        </ul>
        <p>This is true.</p>
        """
      })
    end
  end
end
