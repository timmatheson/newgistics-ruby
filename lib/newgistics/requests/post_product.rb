module Newgistics
  module Requests
    class PostProduct
      attr_reader :product, :response_handler

      def initialize(product, response_handler: nil)
        @product = product
        @response_handler = response_handler || default_response_handler
      end

      def path
        '/post_products.aspx'
      end

      def body
        xml_builder.to_xml
      end

      def perform
        puts "="*8
        puts self.body
        puts "="*8
        Newgistics.api.post(self, response_handler)
      end

      private

      def api_key
        Newgistics.configuration.api_key
      end

      def xml_builder
        puts @product.inspect
        Nokogiri::XML::Builder.new do |xml|
          xml.products(apiKey: api_key) do
            xml.product do |x|
              x.id @product.id
              x.sku @product.sku
              x.upc @product.upc
              x.description @product.description
              x.retailValue @product.retail_value
              x.value @product.value
              x.isActive @product.is_active
              x.shipFrom @product.ship_from
              x.countryOfOrigin @product.country_of_origin
            end
          end
        end
      end



      def format_date(date)
        date.strftime("%m/%d/%Y") if date.respond_to?(:strftime)
      end

      def default_response_handler
        ResponseHandlers::PostProduct.new(product)
      end
    end
  end
end
