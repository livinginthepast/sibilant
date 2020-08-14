defmodule Sibilant.PageTest do
  use Sibilant.SimpleCase

  alias Sibilant.Document
  alias Sibilant.Frontmatter
  alias Sibilant.Page

  setup do
    :ok = Gestalt.replace_config(:sibilant, :root, "test/fixtures", self())
  end

  describe "ls" do
    test "lists all pages" do
      Page.ls()
      |> assert_eq(["about.html", "index.md"])
    end
  end

  describe "path" do
    test "joins filename to the root path" do
      "some.file" |> Page.path() |> assert_eq("test/fixtures/pages/some.file")
    end
  end

  describe "read" do
    test "reads a file and parses it into a document" do
      Page.read("about.html")
      |> assert_eq(
        {:ok,
         %Document{
           body: "<div>\n  I am an about page.\n</div>",
           frontmatter: %Frontmatter{extra: %{}, layout: :default, title: "I am an about page"},
           type: :html
         }}
      )
    end
  end
end
