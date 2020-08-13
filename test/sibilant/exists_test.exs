defmodule Sibilant.ExistsTest do
  use Sibilant.SimpleCase, async: true

  import Sibilant.Exists,
    only: [blank?: 1, exists?: 1]

  describe "blank? and exists?" do
    test "nil" do
      assert blank?(nil) == true
      assert exists?(nil) == false
    end

    test "strings" do
      assert blank?("") == true
      assert exists?("") == false
      assert blank?("hi") == false
      assert exists?("hi") == true
    end

    test "lists" do
      assert blank?([]) == true
      assert exists?([]) == false
      assert blank?([1]) == false
      assert exists?([1]) == true
    end

    test "maps" do
      assert blank?(%{}) == true
      assert exists?(%{}) == false
      assert blank?(%{a: 1}) == false
      assert exists?(%{a: 1}) == true
    end
  end
end
