defmodule Sibilant.FrontmatterTest do
  use Sibilant.SimpleCase

  alias Sibilant.Frontmatter

  describe "parse" do
    test "parses yaml" do
      """
      ---
      layout: my_layout
      title: I am a title
      random: thing
      """
      |> Frontmatter.parse()
      |> assert_eq(
        {:ok,
         %Frontmatter{
           layout: :my_layout,
           title: "I am a title",
           extra: %{"random" => "thing"}
         }}
      )
    end

    test "parses yaml with empty values" do
      """
      """
      |> Frontmatter.parse()
      |> assert_eq(
        {:ok,
         %Frontmatter{
           layout: :default,
           title: nil,
           extra: %{}
         }}
      )
    end
  end
end
