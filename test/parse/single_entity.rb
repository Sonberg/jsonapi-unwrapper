require "minitest/autorun"
require "jsonapi-unwrapper"

class ParseSingleEntityTest < Minitest::Test
  def test_single_entity
    json = { "data" => { "id" => 1, "type" => "users", "attributes" => { "name" => "Joe" } } }
    parsed = JsonApiUnwrapper.call(json)

    assert_equal 1, parsed["id"]
    assert_equal "Joe", parsed["name"]
  end
end
