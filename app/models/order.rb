class Order < ActiveRecord::Base

  include AASM

  belongs_to :user
  belongs_to :credit_card
  belongs_to :coupon
  has_many   :order_items, dependent: :delete_all
  has_many   :books,       through:   :order_items
  has_one    :order_shipping_address
  has_one    :order_billing_address

  validates :total_price, :aasm_state, presence: true
  # validates_associated :order_billing_address
  # validates_associated :order_shipping_address
  # validates_associated :credit_card
  # validates_associated :order_items

  after_initialize -> { self.total_price = 0 if self.total_price == nil }
  # after_initialize -> { self.aasm_state = 'in_progress' if self.aasm_state == nil }
  after_initialize :get_address

  aasm do
    state :in_progress, :initial => true
    state :complited
    state :shipped

    event :complete do
      after do
        self.update(completed_date: Time.now)
      end
      transitions :from => :in_progress, :to => :complited
    end

    event :shipped do
      after do
        self.update(completed_date: Time.now)
      end
      transitions :from => [:in_progress, :complited], :to => :shipped
    end

    event :in_progress do
      after do
        self.update(completed_date: nil)
      end
      transitions :from => [:complited, :shipped], :to => :in_progress
    end
  end

  def get_address
    if self.user&.billing_address != nil
      billing_attr = self.user.billing_address.attributes.slice('first_name', 'last_name', 'street',
                                                                'city', 'country_id', 'zip', 'phone')
      self.order_billing_address = OrderBillingAddress.new( billing_attr )
    else
      # self.build_order_billing_address( order_id: self.id )
      # OrderBillingAddress.new( order_id: self.id )
    end


    if self.user&.shipping_address != nil
      shipping_attr = self.user.shipping_address.attributes.slice('first_name', 'last_name', 'street',
                                                                  'city', 'country_id', 'zip', 'phone')
      self.order_shipping_address = OrderShippingAddress.new( shipping_attr )
    else
      # self.build_order_shipping_address( order_id: self.id )
      # OrderShippingAddress.new( order_id: self.id )
    end
  end
end