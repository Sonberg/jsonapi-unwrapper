require "minitest/autorun"
require "jsonapi-unwrapper"

class WithSingleIncludeTest < Minitest::Test
  def test_with_single_include
    json = {
      "data" => {
        "id" => 1,
        "type" => "users",
        "attributes" => { "name" => "Joe" },
        "relationships" => {
          "pet" => {
            "data" => { "id" => 1, "type" => "pets" },
          },
        },
      },
      "included" => [
        {
          "id" => 1,
          "type" => "pets",
          "attributes" => {
            "type" => "turtle",
            "name" => "Josef",
          },
        },
      ],

    }
    parsed = JsonApiUnwrapper.call(json)

    assert_equal 1, parsed["id"]
    assert_equal "Joe", parsed["name"]

    assert_equal 1, parsed["pet"]["id"]
    assert_equal "Josef", parsed["pet"]["name"]
  end
end
