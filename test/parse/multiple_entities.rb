require "minitest/autorun"
require "jsonapi-unwrapper"

class ParseMultipleEntitiesTest < Minitest::Test
  def test_multiple_entities
    json = { "data" => [
      { "id" => 1, "type" => "users", "attributes" => { "name" => "Joe" } },
      { "id" => 2, "type" => "users", "attributes" => { "name" => "Tom" } },
    ] }
    parsed = JsonApiUnwrapper.call(json)

    assert_equal 1, parsed[0]["id"]
    assert_equal "Joe", parsed[0]["name"]

    assert_equal 2, parsed[1]["id"]
    assert_equal "Tom", parsed[1]["name"]
  end
end
