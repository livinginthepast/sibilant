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

    test "is {:error, :unknown_file_type when the filename has no extension" do
      "about" |> FileExtension.parse() |> assert_eq({:error, :unknown_file_type})
    end

    test "is {:error, :unknown_file_type} when no known pattern matches the file extension" do
      "yo.yoyoyo" |> FileExtension.parse() |> assert_eq({:error, :unknown_file_type})
    end

    test "allows for overrides to file_types configuration" do
      :ok = Gestalt.replace_config(:sibilant, :file_types, [yoyo: [pattern: ~r"yoyo"]], self())
      "yo.yoyoyo" |> FileExtension.parse() |> assert_eq({:ok, :yoyo})
    end
  end

  describe "parse!" do
    test "is :type when matching a known type" do
      "about.htm" |> FileExtension.parse!() |> assert_eq(:html)
    end

    test "raises when unable to match a type" do
      assert_raise RuntimeError, fn ->
        "yo.yoyoyo" |> FileExtension.parse!()
      end
    end
  end
end
