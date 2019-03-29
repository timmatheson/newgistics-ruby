module Newgistics
  class BackorderedItem
    include Newgistics::Model

    attribute :id, String
    attribute :new_shipment_id, String

    attribute :sku, String
    attribute :description, String
    attribute :qty, Integer
    attribute :custom_fields, Hash


    attribute :is_cancelled, Boolean
  end
end
