require "minitest/autorun"
require "jsonapi-unwrapper"

class ParseSingleEntityTest < Minitest::Test
  def test_single_entity
    json = {
      "data" => {
        "id" => 1,
        "type" => "users",
        "attributes" => { "name" => "Joe" },
        "relationships" => {
          "pets" => {
            "data" => [{ "id" => 1, "type" => "pets" }],
          },
        },
      },
      "included" => [{
        "id" => 1,
        "type" => "pets",
        "attributes" => {
          "type" => "dog",
          "name" => "Skippy",
        },
      }],

    }
    parsed = JsonApiUnwrapper.call(json)

    assert_equal 1, parsed["id"]
    assert_equal "Joe", parsed["name"]
    assert_equal 1, parsed["pets"].count
    assert_equal "Skippy", parsed["pets"][0]["name"]
  end
end
