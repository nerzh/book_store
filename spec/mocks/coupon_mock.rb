require 'active_mocker/mock'

class CouponMock < ActiveMocker::Base
  created_with('2.0.0')

# _modules_constants.erb
#_class_methods.erb
  class << self
    def attributes
      @attributes ||= HashWithIndifferentAccess.new({"id"=>nil, "number"=>nil, "discount"=>nil, "created_at"=>nil, "updated_at"=>nil}).merge(super)
    end

    def types
      @types ||= ActiveMocker::HashProcess.new({ id: Fixnum, number: Fixnum, discount: Fixnum, created_at: DateTime, updated_at: DateTime }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= {:order=>nil}.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= {"Order"=>{:has_one=>[:order]}}.merge(super)
    end

    def mocked_class
      "Coupon"
    end

    private :mocked_class

    def attribute_names
      @attribute_names ||= ["id", "number", "discount", "created_at", "updated_at"] | super
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "coupons" || super
    end

  end
# _attributes.erb
  def id
    read_attribute(:id)
  end

  def id=(val)
    write_attribute(:id, val)
  end
  def number
    read_attribute(:number)
  end

  def number=(val)
    write_attribute(:number, val)
  end
  def discount
    read_attribute(:discount)
  end

  def discount=(val)
    write_attribute(:discount, val)
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
    ActiveMocker::HasOne.new(val, child_self: self, foreign_key: 'coupon_id').item
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
    include CouponMock::Scopes
  end

  def self.__new_relation__(collection)
    CouponMock::ScopeRelation.new(collection)
  end

  private_class_method :__new_relation__
end
