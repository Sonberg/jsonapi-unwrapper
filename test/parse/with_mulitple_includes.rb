require "minitest/autorun"
require "jsonapi-unwrapper"

class WithMultipleIncludesTest < Minitest::Test
  def test_with_multiple_includes
    json = {
      "data" => {
        "id" => 1,
        "type" => "users",
        "attributes" => { "name" => "Joe" },
        "relationships" => {
          "pets" => {
            "data" => [
              { "id" => 1, "type" => "pets" },
              { "id" => 2, "type" => "pets" },
            ],
          },
        },
      },
      "included" => [
        {
          "id" => 1,
          "type" => "pets",
          "attributes" => {
            "type" => "dog",
            "name" => "Skippy",
          },
        },
        {
          "id" => 2,
          "type" => "pets",
          "attributes" => {
            "type" => "cat",
            "name" => "Frank",
          },
        },
      ],

    }
    parsed = JsonApiUnwrapper.call(json)

    assert_equal 1, parsed["id"]
    assert_equal "Joe", parsed["name"]
    assert_equal 2, parsed["pets"].count
    assert_equal "Skippy", parsed["pets"][0]["name"]
  end
end
