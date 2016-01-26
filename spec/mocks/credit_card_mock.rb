require 'active_mocker/mock'

class CreditCardMock < ActiveMocker::Base
  created_with('2.0.0')

# _modules_constants.erb
#_class_methods.erb
  class << self
    def attributes
      @attributes ||= HashWithIndifferentAccess.new({"id"=>nil, "number"=>nil, "cvv"=>nil, "exp_date"=>nil, "first_name"=>nil, "last_name"=>nil, "user_id"=>nil, "created_at"=>nil, "updated_at"=>nil}).merge(super)
    end

    def types
      @types ||= ActiveMocker::HashProcess.new({ id: Fixnum, number: String, cvv: Fixnum, exp_date: Date, first_name: String, last_name: String, user_id: Fixnum, created_at: DateTime, updated_at: DateTime }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= {:user=>nil, :orders=>nil}.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= {"User"=>{:belongs_to=>[:user]}, "Order"=>{:has_many=>[:orders]}}.merge(super)
    end

    def mocked_class
      "CreditCard"
    end

    private :mocked_class

    def attribute_names
      @attribute_names ||= ["id", "number", "cvv", "exp_date", "first_name", "last_name", "user_id", "created_at", "updated_at"] | super
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "credit_cards" || super
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
  def cvv
    read_attribute(:cvv)
  end

  def cvv=(val)
    write_attribute(:cvv, val)
  end
  def exp_date
    read_attribute(:exp_date)
  end

  def exp_date=(val)
    write_attribute(:exp_date, val)
  end
  def first_name
    read_attribute(:first_name)
  end

  def first_name=(val)
    write_attribute(:first_name, val)
  end
  def last_name
    read_attribute(:last_name)
  end

  def last_name=(val)
    write_attribute(:last_name, val)
  end
  def user_id
    read_attribute(:user_id)
  end

  def user_id=(val)
    write_attribute(:user_id, val)
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
  def user
    read_association(:user) || write_association(:user, classes('User').try{ |k| k.find_by(id: user_id)})
  end
  def user=(val)
    write_association(:user, val)
    ActiveMocker::BelongsTo.new(val, child_self: self, foreign_key: :user_id).item
  end

  def build_user(attributes={}, &block)
    association = classes('User').try(:new, attributes, &block)
    write_association(:user, association) unless association.nil?
  end

  def create_user(attributes={}, &block)
    association = classes('User').try(:create,attributes, &block)
    write_association(:user, association) unless association.nil?
  end
  alias_method :create_user!, :create_user

# has_many
  def orders
    read_association(:orders, -> { ActiveMocker::HasMany.new([],foreign_key: 'credit_card_id', foreign_id: self.id, relation_class: classes('Order'), source: '') })
  end

  def orders=(val)
    write_association(:orders, ActiveMocker::HasMany.new(val, foreign_key: 'credit_card_id', foreign_id: self.id, relation_class: classes('Order'), source: ''))
  end

# _scopes.erb
  module Scopes
    include ActiveMocker::Base::Scopes

  end

  extend Scopes

  class ScopeRelation < ActiveMocker::Association
    include CreditCardMock::Scopes
  end

  def self.__new_relation__(collection)
    CreditCardMock::ScopeRelation.new(collection)
  end

  private_class_method :__new_relation__
end
