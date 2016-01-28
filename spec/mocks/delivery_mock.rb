require 'active_mocker/mock'

class DeliveryMock < ActiveMocker::Base
  created_with('2.0.0')

# _modules_constants.erb
#_class_methods.erb
  class << self
    def attributes
      @attributes ||= HashWithIndifferentAccess.new({"id"=>nil, "name"=>nil, "price"=>0, "created_at"=>nil, "updated_at"=>nil}).merge(super)
    end

    def types
      @types ||= ActiveMocker::HashProcess.new({ id: Fixnum, name: String, price: Fixnum, created_at: DateTime, updated_at: DateTime }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= {:order=>nil}.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= {"Order"=>{:has_one=>[:order]}}.merge(super)
    end

    def mocked_class
      "Delivery"
    end

    private :mocked_class

    def attribute_names
      @attribute_names ||= ["id", "name", "price", "created_at", "updated_at"] | super
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "deliveries" || super
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
  def price
    read_attribute(:price)
  end

  def price=(val)
    write_attribute(:price, val)
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
  def order
    read_association(:order)
  end

  def order=(val)
    write_association(:order, val)
    ActiveMocker::HasOne.new(val, child_self: self, foreign_key: 'delivery_id').item
  end

  def build_order(attributes={}, &block)
    write_association(:order, classes('Order').new(attributes, &block)) if classes('Order')
  end

  def create_order(attributes={}, &block)
    write_association(:order, classes('Order').new(attributes, &block)) if classes('Order')
  end
  alias_method :create_order!, :create_order

# _scopes.erb
  module Scopes
    include ActiveMocker::Base::Scopes

  end

  extend Scopes

  class ScopeRelation < ActiveMocker::Association
    include DeliveryMock::Scopes
  end

  def self.__new_relation__(collection)
    DeliveryMock::ScopeRelation.new(collection)
  end

  private_class_method :__new_relation__
end
