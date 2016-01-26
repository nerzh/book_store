require 'active_mocker/mock'

class OrderItemMock < ActiveMocker::Base
  created_with('2.0.0')

# _modules_constants.erb
#_class_methods.erb
  class << self
    def attributes
      @attributes ||= HashWithIndifferentAccess.new({"id"=>nil, "price"=>nil, "quantity"=>nil, "book_id"=>nil, "order_id"=>nil, "created_at"=>nil, "updated_at"=>nil}).merge(super)
    end

    def types
      @types ||= ActiveMocker::HashProcess.new({ id: Fixnum, price: Fixnum, quantity: Fixnum, book_id: Fixnum, order_id: Fixnum, created_at: DateTime, updated_at: DateTime }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= {:book=>nil, :order=>nil}.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= {"Book"=>{:belongs_to=>[:book]}, "Order"=>{:belongs_to=>[:order]}}.merge(super)
    end

    def mocked_class
      "OrderItem"
    end

    private :mocked_class

    def attribute_names
      @attribute_names ||= ["id", "price", "quantity", "book_id", "order_id", "created_at", "updated_at"] | super
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "order_items" || super
    end

  end
# _attributes.erb
  def id
    read_attribute(:id)
  end

  def id=(val)
    write_attribute(:id, val)
  end
  def price
    read_attribute(:price)
  end

  def price=(val)
    write_attribute(:price, val)
  end
  def quantity
    read_attribute(:quantity)
  end

  def quantity=(val)
    write_attribute(:quantity, val)
  end
  def book_id
    read_attribute(:book_id)
  end

  def book_id=(val)
    write_attribute(:book_id, val)
  end
  def order_id
    read_attribute(:order_id)
  end

  def order_id=(val)
    write_attribute(:order_id, val)
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

# belongs_to
  def book
    read_association(:book) || write_association(:book, classes('Book').try{ |k| k.find_by(id: book_id)})
  end
  def book=(val)
    write_association(:book, val)
    ActiveMocker::BelongsTo.new(val, child_self: self, foreign_key: :book_id).item
  end

  def build_book(attributes={}, &block)
    association = classes('Book').try(:new, attributes, &block)
    write_association(:book, association) unless association.nil?
  end

  def create_book(attributes={}, &block)
    association = classes('Book').try(:create,attributes, &block)
    write_association(:book, association) unless association.nil?
  end
  alias_method :create_book!, :create_book
  def order
    read_association(:order) || write_association(:order, classes('Order').try{ |k| k.find_by(id: order_id)})
  end
  def order=(val)
    write_association(:order, val)
    ActiveMocker::BelongsTo.new(val, child_self: self, foreign_key: :order_id).item
  end

  def build_order(attributes={}, &block)
    association = classes('Order').try(:new, attributes, &block)
    write_association(:order, association) unless association.nil?
  end

  def create_order(attributes={}, &block)
    association = classes('Order').try(:create,attributes, &block)
    write_association(:order, association) unless association.nil?
  end
  alias_method :create_order!, :create_order


# _scopes.erb
  module Scopes
    include ActiveMocker::Base::Scopes

  end

  extend Scopes

  class ScopeRelation < ActiveMocker::Association
    include OrderItemMock::Scopes
  end

  def self.__new_relation__(collection)
    OrderItemMock::ScopeRelation.new(collection)
  end

  private_class_method :__new_relation__
  def update_total_price_in_order
    call_mock_method(method: __method__, caller: Kernel.caller, arguments: [])
  end
end
