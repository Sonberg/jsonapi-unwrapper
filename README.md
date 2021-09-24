# jsonapi-unwrapper
Dead simple parser / deserilizer for json api (https://jsonapi.org/)

## Install

``` 
gem 'jsonapi-unwrapper', '~> 0.0.1'
```
or
```
gem install jsonapi-unwrapper
```

## Use
```
require "jsonapi-unwrapper"

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

    parsed["id"] // 1
    parsed["name"] // Joe
    parsed["pet"]["name"] // Frank
```

### Feel free to create a pull request