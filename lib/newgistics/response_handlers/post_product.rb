module Newgistics
  module ResponseHandlers
    class PostProduct
      attr_reader :product

      def initialize(product)
        @product = product
      end

      def handle(response)
        PostErrors.new(product).handle(response)
        handle_successful_response(response) if product.errors.empty?
      end

      private

      def handle_successful_response(response)
        xml = Nokogiri::XML(response.body)
        puts response.body
        product.id = xml.at_css('products > product:first')['id']
      end
    end
  end
end
