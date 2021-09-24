class JsonApiUnwrapper
  def self.call(json)
    data = json["data"]
    included = json["included"] || {}

    return JsonApiUnwrapper.deserilize_entity(data, included)
  end

  private

  def self.deserilize_relationship(data, included)
    return if data == nil
    return data.map { |x| JsonApiUnwrapper.deserilize_relationship(x, included) }.filter { |x| x != nil } if data.kind_of?(Array)

    included_entity = JsonApiUnwrapper.find_included(data, included)

    return if included_entity == nil

    JsonApiUnwrapper.deserilize_entity(included_entity, included)
  end

  def self.deserilize_entity(entity, included)
    return entity.map { |x| JsonApiUnwrapper.deserilize_entity(x, included) } if entity.kind_of?(Array)

    relationships = entity["relationships"] || {}
    relationship_keys = relationships.keys || []
    relationships_result = relationship_keys.reduce({}) do |memo, key|
      data = relationships[key]["data"]

      next memo if data == nil

      [
        memo,
        Hash[key => JsonApiUnwrapper.deserilize_relationship(data, included)],
      ].inject(:merge)
    end

    [
      Hash["id" => entity["id"]],
      entity["attributes"],
      relationships_result,
    ].inject(:merge)
  end

  def self.find_included(data, included)
    return data.map { |x| JsonApiUnwrapper.find_included(x, included) } if data.kind_of?(Array)

    included.detect { |x| x["id"] == data["id"] && x["type"] == data["type"] }
  end
end
