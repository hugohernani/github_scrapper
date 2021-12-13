class MultipleFieldRansackSearch
  def initialize(ransack_relation = User.all)
    @ransack_relation = ransack_relation
  end

  def search(query, fields: [])
    search_params           = query_for_containing_fields(query || '', fields)
    exclusive_search_params = search_params.merge({ m: 'or' })
    @ransack_relation.ransack(exclusive_search_params).result(distinct: true)
  end

  private

  def query_for_containing_fields(query, fields)
    fields.each_with_object({}) do |field, hash|
      hash["#{field}_i_cont"] = query.downcase
    end
  end
end
