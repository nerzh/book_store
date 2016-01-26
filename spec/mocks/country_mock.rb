require 'active_mocker/mock'

class CountryMock < ActiveMocker::Base
  created_with('2.0.0')

# _modules_constants.erb
#_class_methods.erb
  class << self
    def attributes
      @attributes ||= HashWithIndifferentAccess.new({"id"=>nil, "name"=>nil, "created_at"=>nil, "updated_at"=>nil}).merge(super)
    end

    def types
      @types ||= ActiveMocker::HashProcess.new({ id: Fixnum, name: String, created_at: DateTime, updated_at: DateTime }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= {:shipping_address=>nil, :billing_address=>nil, :order_shipping_address=>nil, :order_billing_address=>nil}.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= {"ShippingAddress"=>{:has_one=>[:shipping_address]}, "BillingAddress"=>{:has_one=>[:billing_address]}, "OrderShippingAddress"=>{:has_one=>[:order_shipping_address]}, "OrderBillingAddress"=>{:has_one=>[:order_billing_address]}}.merge(super)
    end

    def mocked_class
      "Country"
    end

    private :mocked_class

    def attribute_names
      @attribute_names ||= ["id", "name", "created_at", "updated_at"] | super
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "countries" || super
    end

  end
# _attributes.erb
  def id
    read_attribute(:id)
  end

  def id=(val)
    write_attribute(:id, val)
  end
  def name
    read_attribute(:name)
  end

  def name=(val)
    write_attribute(:name, val)
  end
  def created_at
    read_attribute(:created_at)
  end

  def created_at=(val)
    write_attribute(:created_at, val)
  end
  def updated_at
    read_attribute(:updated_at)
  end

  def updated_at=(val)
    write_attribute(:updated_at, val)
  end
# _associations.erb

# has_one
  def shipping_address
    read_association(:shipping_address)
  end

  def shipping_address=(val)
    write_association(:shipping_address, val)
    ActiveMocker::HasOne.new(val, child_self: self, foreign_key: 'country_id').item
  end

  def build_shipping_address(attributes={}, &block)
    write_association(:shipping_address, classes('ShippingAddress').new(attributes, &block)) if classes('ShippingAddress')
  end

  def create_shipping_address(attributes={}, &block)
    write_association(:shipping_address, classes('ShippingAddress').new(attributes, &block)) if classes('ShippingAddress')
  end
  alias_method :create_shipping_address!, :create_shipping_address
  def billing_address
    read_association(:billing_address)
  end

  def billing_address=(val)
    write_association(:billing_address, val)
    ActiveMocker::HasOne.new(val, child_self: self, foreign_key: 'country_id').item
  end

  def build_billing_address(attributes={}, &block)
    write_association(:billing_address, classes('BillingAddress').new(attributes, &block)) if classes('BillingAddress')
  end

  def create_billing_address(attributes={}, &block)
    write_association(:billing_address, classes('BillingAddress').new(attributes, &block)) if classes('BillingAddress')
  end
  alias_method :create_billing_address!, :create_billing_address
  def order_shipping_address
    read_association(:order_shipping_address)
  end

  def order_shipping_address=(val)
    write_association(:order_shipping_address, val)
    ActiveMocker::HasOne.new(val, child_self: self, foreign_key: 'country_id').item
  end

  def build_order_shipping_address(attributes={}, &block)
    write_association(:order_shipping_address, classes('OrderShippingAddress').new(attributes, &block)) if classes('OrderShippingAddress')
  end

  def create_order_shipping_address(attributes={}, &block)
    write_association(:order_shipping_address, classes('OrderShippingAddress').new(attributes, &block)) if classes('OrderShippingAddress')
  end
  alias_method :create_order_shipping_address!, :create_order_shipping_address
  def order_billing_address
    read_association(:order_billing_address)
  end

  def order_billing_address=(val)
    write_association(:order_billing_address, val)
    ActiveMocker::HasOne.new(val, child_self: self, foreign_key: 'country_id').item
  end

  def build_order_billing_address(attributes={}, &block)
    write_association(:order_billing_address, classes('OrderBillingAddress').new(attributes, &block)) if classes('OrderBillingAddress')
  end

  def create_order_billing_address(attributes={}, &block)
    write_association(:order_billing_address, classes('OrderBillingAddress').new(attributes, &block)) if classes('OrderBillingAddress')
  end
  alias_method :create_order_billing_address!, :create_order_billing_address

# _scopes.erb
  module Scopes
    include ActiveMocker::Base::Scopes

  end

  extend Scopes

  class ScopeRelation < ActiveMocker::Association
    include CountryMock::Scopes
  end

  def self.__new_relation__(collection)
    CountryMock::ScopeRelation.new(collection)
  end

  private_class_method :__new_relation__
end
