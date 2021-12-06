module RansackObjectForLowercase
  def self.included(base)
    base.columns.each do |column|
      if column.type == :string
        base.ransacker column.name.to_sym, type: :string do
          Arel.sql("lower(#{base.table_name}.#{column.name})")
        end
      end
    end
  end
end
