require 'active_mocker/mock'

class ShippingAddressMock < ActiveMocker::Base
  created_with('2.0.0')

# _modules_constants.erb
#_class_methods.erb
  class << self
    def attributes
      @attributes ||= HashWithIndifferentAccess.new({"id"=>nil, "first_name"=>nil, "last_name"=>nil, "street"=>nil, "city"=>nil, "country_id"=>nil, "zip"=>nil, "phone"=>nil, "created_at"=>nil, "updated_at"=>nil, "user_id"=>nil}).merge(super)
    end

    def types
      @types ||= ActiveMocker::HashProcess.new({ id: Fixnum, first_name: String, last_name: String, street: String, city: String, country_id: Fixnum, zip: String, phone: String, created_at: DateTime, updated_at: DateTime, user_id: Fixnum }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= {:user=>nil, :country=>nil}.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= {"User"=>{:belongs_to=>[:user]}, "Country"=>{:belongs_to=>[:country]}}.merge(super)
    end

    def mocked_class
      "ShippingAddress"
    end

    private :mocked_class

    def attribute_names
      @attribute_names ||= ["id", "first_name", "last_name", "street", "city", "country_id", "zip", "phone", "created_at", "updated_at", "user_id"] | super
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "shipping_addresses" || super
    end

  end
# _attributes.erb
  def id
    read_attribute(:id)
  end

  def id=(val)
    write_attribute(:id, val)
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
  def street
    read_attribute(:street)
  end

  def street=(val)
    write_attribute(:street, val)
  end
  def city
    read_attribute(:city)
  end

  def city=(val)
    write_attribute(:city, val)
  end
  def country_id
    read_attribute(:country_id)
  end

  def country_id=(val)
    write_attribute(:country_id, val)
  end
  def zip
    read_attribute(:zip)
  end

  def zip=(val)
    write_attribute(:zip, val)
  end
  def phone
    read_attribute(:phone)
  end

  def phone=(val)
    write_attribute(:phone, val)
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
  def user_id
    read_attribute(:user_id)
  end

  def user_id=(val)
    write_attribute(:user_id, val)
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
  def country
    read_association(:country) || write_association(:country, classes('Country').try{ |k| k.find_by(id: country_id)})
  end
  def country=(val)
    write_association(:country, val)
    ActiveMocker::BelongsTo.new(val, child_self: self, foreign_key: :country_id).item
  end

  def build_country(attributes={}, &block)
    association = classes('Country').try(:new, attributes, &block)
    write_association(:country, association) unless association.nil?
  end

  def create_country(attributes={}, &block)
    association = classes('Country').try(:create,attributes, &block)
    write_association(:country, association) unless association.nil?
  end
  alias_method :create_country!, :create_country


# _scopes.erb
  module Scopes
    include ActiveMocker::Base::Scopes

  end

  extend Scopes

  class ScopeRelation < ActiveMocker::Association
    include ShippingAddressMock::Scopes
  end

  def self.__new_relation__(collection)
    ShippingAddressMock::ScopeRelation.new(collection)
  end

  private_class_method :__new_relation__
end
