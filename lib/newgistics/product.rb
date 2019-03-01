module Newgistics
  class Product
    include Newgistics::Model

    attribute :id, Integer
    attribute :sku, String
    attribute :description, String
    attribute :upc, String
    attribute :supplier, String
    attribute :value, Float
    attribute :retail_value, Float
    attribute :ship_from, String
    attribute :country_of_origin, String
    attribute :is_active, Boolean

    attribute :putaway_quantity, Integer
    attribute :quarantine_quantity, Integer
    attribute :damaged_quantity, Integer
    attribute :expired_quantity, Integer
    attribute :recalled_quantity, Integer
    attribute :current_quantity, Integer
    attribute :kitting_quantity, Integer
    attribute :pending_quantity, Integer
    attribute :available_quantity, Integer

    attribute :errors, Array[String], default: []
    attribute :warnings, Array[String], default: []

    def self.all
      where({}).all
    end

    def self.where(conditions)
      Query.build(
        endpoint: '/inventory.aspx',
        model_class: self
      ).where(conditions)
    end

    def self.element_selector
      'product'
    end

    def save
      Requests::PostProduct.new(self).perform
      errors.empty?
    end
  end
end
