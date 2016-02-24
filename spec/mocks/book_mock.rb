require 'active_mocker/mock'

class BookMock < ActiveMocker::Base
  created_with('2.0.0')

# _modules_constants.erb
#_class_methods.erb
  class << self
    def attributes
      @attributes ||= HashWithIndifferentAccess.new({"id"=>nil, "title"=>nil, "description"=>nil, "price"=>nil, "amount"=>nil, "category_id"=>nil, "created_at"=>nil, "updated_at"=>nil, "cover"=>nil}).merge(super)
    end

    def types
      @types ||= ActiveMocker::HashProcess.new({ id: Fixnum, title: String, description: String, price: Fixnum, amount: Fixnum, category_id: Fixnum, created_at: DateTime, updated_at: DateTime, cover: String }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= {:authors=>nil, :category=>nil, :reviews=>nil, :orders=>nil, :order_items=>nil}.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= {"Author"=>{:has_and_belongs_to_many=>[:authors]}, "Category"=>{:belongs_to=>[:category]}, "Review"=>{:has_many=>[:reviews]}, "Order"=>{:has_many=>[:orders]}, "OrderItem"=>{:has_many=>[:order_items]}}.merge(super)
    end

    def mocked_class
      "Book"
    end

    private :mocked_class

    def attribute_names
      @attribute_names ||= ["id", "title", "description", "price", "amount", "category_id", "created_at", "updated_at", "cover"] | super
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "books" || super
    end

  end
# _attributes.erb
  def id
    read_attribute(:id)
  end

  def id=(val)
    write_attribute(:id, val)
  end
  def title
    read_attribute(:title)
  end

  def title=(val)
    write_attribute(:title, val)
  end
  def description
    read_attribute(:description)
  end

  def description=(val)
    write_attribute(:description, val)
  end
  def price
    read_attribute(:price)
  end

  def price=(val)
    write_attribute(:price, val)
  end
  def amount
    read_attribute(:amount)
  end

  def amount=(val)
    write_attribute(:amount, val)
  end
  def category_id
    read_attribute(:category_id)
  end

  def category_id=(val)
    write_attribute(:category_id, val)
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
  def cover
    read_attribute(:cover)
  end

  def cover=(val)
    write_attribute(:cover, val)
  end
# _associations.erb

# belongs_to
  def category
    read_association(:category) || write_association(:category, classes('Category').try{ |k| k.find_by(id: category_id)})
  end
  def category=(val)
    write_association(:category, val)
    ActiveMocker::BelongsTo.new(val, child_self: self, foreign_key: :category_id).item
  end

  def build_category(attributes={}, &block)
    association = classes('Category').try(:new, attributes, &block)
    write_association(:category, association) unless association.nil?
  end

  def create_category(attributes={}, &block)
    association = classes('Category').try(:create,attributes, &block)
    write_association(:category, association) unless association.nil?
  end
  alias_method :create_category!, :create_category

# has_many
  def reviews
    read_association(:reviews, -> { ActiveMocker::HasMany.new([],foreign_key: 'book_id', foreign_id: self.id, relation_class: classes('Review'), source: '') })
  end

  def reviews=(val)
    write_association(:reviews, ActiveMocker::HasMany.new(val, foreign_key: 'book_id', foreign_id: self.id, relation_class: classes('Review'), source: ''))
  end
  def orders
    read_association(:orders, -> { ActiveMocker::HasMany.new([],foreign_key: 'order_id', foreign_id: self.id, relation_class: classes('Order'), source: '') })
  end

  def orders=(val)
    write_association(:orders, ActiveMocker::HasMany.new(val, foreign_key: 'order_id', foreign_id: self.id, relation_class: classes('Order'), source: ''))
  end
  def order_items
    read_association(:order_items, -> { ActiveMocker::HasMany.new([],foreign_key: 'book_id', foreign_id: self.id, relation_class: classes('OrderItem'), source: '') })
  end

  def order_items=(val)
    write_association(:order_items, ActiveMocker::HasMany.new(val, foreign_key: 'book_id', foreign_id: self.id, relation_class: classes('OrderItem'), source: ''))
  end
# has_and_belongs_to_many
  def authors
    read_association(:authors, ->{ ActiveMocker::HasAndBelongsToMany.new([]) })
  end

  def authors=(val)
    write_association(:authors, ActiveMocker::HasAndBelongsToMany.new(val))
  end
# _scopes.erb
  module Scopes
    include ActiveMocker::Base::Scopes

  end

  extend Scopes

  class ScopeRelation < ActiveMocker::Association
    include BookMock::Scopes
  end

  def self.__new_relation__(collection)
    BookMock::ScopeRelation.new(collection)
  end

  private_class_method :__new_relation__
  def show_price
    call_mock_method(method: __method__, caller: Kernel.caller, arguments: [])
  end
end
