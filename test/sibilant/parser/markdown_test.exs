defmodule Sibilant.Parser.MarkdownTest do
  use Sibilant.SimpleCase

  describe "earmark_config" do
    import Sibilant.Parser.Markdown, only: [earmark_config: 0]

    test "provides default values for Earmark" do
      earmark_config()
      |> assert_eq(%{breaks: false, gfm: true, smartypants: true},
        only: ~w{breaks gfm smartypants}a
      )
    end

    test "can override values from config" do
      :ok =
        Gestalt.replace_config(
          :sibilant,
          :earmark,
          [breaks: true, gfm: false, smartypants: false],
          self()
        )

      earmark_config()
      |> assert_eq(%{breaks: true, gfm: false, smartypants: false},
        only: ~w{breaks gfm smartypants}a
      )
    end
  end

  describe "parse" do
    import Sibilant.Parser.Markdown, only: [parse: 1]

    test "parses markdown to HTML" do
      """
      I have some text.
      And other text.

      And---some other text.

      * This
      * Is
      * A list

      1. This is
      1. An ordered list
      """
      |> parse()
      |> assert_eq(
        {:ok,
         """
         <p>
         I have some text.
         And other text.</p>
         <p>
         And—some other text.</p>
         <ul>
           <li>
         This  </li>
           <li>
         Is  </li>
           <li>
         A list  </li>
         </ul>
         <ol>
           <li>
         This is  </li>
           <li>
         An ordered list  </li>
         </ol>
         """}
      )
    end

    test "allows earmark config to be set" do
      :ok =
        Gestalt.replace_config(:sibilant, :earmark, [breaks: true, smartypants: false], self())

      """
      I have some text.
      And other text.



      And---some other text.
      """
      |> parse()
      |> assert_eq(
        {:ok,
         """
         <p>
         I have some text.  <br />
         And other text.</p>
         <p>
         And---some other text.</p>
         """}
      )
    end
  end
end
