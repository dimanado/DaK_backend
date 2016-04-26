class Category < ActiveRecord::Base
  has_and_belongs_to_many :courses

  def self.parsing_to_array(items)
    categories = []
    items.each do |item_name|
      categories << Category.find_by(name: item_name)
    end
    categories
  end
end
