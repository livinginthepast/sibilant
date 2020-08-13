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
      |> Sibilant.Document.parse(type: "markdown")
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
          type: "markdown"
        }
      })
    end
  end
end
