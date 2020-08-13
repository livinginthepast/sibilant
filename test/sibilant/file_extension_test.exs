defmodule Sibilant.FileExtensionTest do
  use Sibilant.SimpleCase

  alias Sibilant.FileExtension

  describe "parse" do
    test "is {:ok, type} when first part of file extension matches a known type" do
      "about.htm" |> FileExtension.parse() |> assert_eq({:ok, :html})
      "about.html" |> FileExtension.parse() |> assert_eq({:ok, :html})
      "about.html.liquid" |> FileExtension.parse() |> assert_eq({:ok, :html})
      "about.md" |> FileExtension.parse() |> assert_eq({:ok, :markdown})
      "about.markdown" |> FileExtension.parse() |> assert_eq({:ok, :markdown})
    end

    test "is {:error, :unknown_extension} when no known pattern matches the file extension" do
      "yo.yoyoyo" |> FileExtension.parse() |> assert_eq({:error, :unknown_extension})
    end

    test "allows for overrides to configuration" do
      :ok = Gestalt.replace_config(:sibilant, :extensions, [yoyo: ~r"yoyo"], self())
      "yo.yoyoyo" |> FileExtension.parse() |> assert_eq({:ok, :yoyo})
    end
  end
end
