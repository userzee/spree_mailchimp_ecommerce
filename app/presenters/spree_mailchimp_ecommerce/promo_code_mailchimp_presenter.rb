# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class PromoCodeMailchimpPresenter
    include Rails.application.routes.url_helpers
    attr_reader :promotion

    def initialize(promotion, store_url)
      @promotion = promotion
      @store_url = store_url
    end

    def json
      {
        id: Digest::MD5.hexdigest(promotion.id.to_s),
        code: promotion.code || "",
        redemption_url: redemption_url,
        usage_count: promotion.credits_count,
        created_at_foreign: promotion.created_at.strftime("%Y%m%dT%H%M%S") || "",
        updated_at_foreign: promotion.updated_at.strftime("%Y%m%dT%H%M%S") || ""
      }.as_json
    end

    private

    def redemption_url
      "#{@store_url}/checkout"
    end
  end
end
