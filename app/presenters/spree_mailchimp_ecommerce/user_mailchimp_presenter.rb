# frozen_string_literal: true

module SpreeMailchimpEcommerce
  class UserMailchimpPresenter
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def json
      {
        id: Digest::MD5.hexdigest(user.email.downcase),
        email_address: user.email || "",
        opt_in_status: user.news_letter,
        first_name: firstname,
        last_name: lastname,
        store_id: @user.try(:store_id).to_s
      }.merge(address).as_json
    end

    private

    def firstname
      user.try(:firstname) || user&.bill_address&.firstname || ""
    end

    def lastname
      user.try(:lastname) || user&.bill_address&.lastname || ""
    end

    def address
      ad = user.bill_address
      return {} unless ad

      {
        address: AddressMailchimpPresenter.new(ad).json
      }
    end
  end
end
