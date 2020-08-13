defmodule Sibilant.PostTest do
  use Sibilant.SimpleCase, async: true

  alias Sibilant.Frontmatter
  alias Sibilant.Post

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
      |> Sibilant.Post.parse()
      |> assert_eq(%Post{
        body: "\nI am a web page.\n\n* I\n* Have\n* A\n* List\n",
        frontmatter: %Frontmatter{
          layout: :something,
          extra: %{
            "something" => "else"
          },
          title: nil
        }
      })
    end
  end
end
