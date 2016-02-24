require 'active_mocker/mock'

class ReviewMock < ActiveMocker::Base
  created_with('2.0.0')

# _modules_constants.erb
#_class_methods.erb
  class << self
    def attributes
      @attributes ||= HashWithIndifferentAccess.new({"id"=>nil, "text"=>nil, "user_id"=>nil, "book_id"=>nil, "created_at"=>nil, "updated_at"=>nil, "theme"=>nil}).merge(super)
    end

    def types
      @types ||= ActiveMocker::HashProcess.new({ id: Fixnum, text: String, user_id: Fixnum, book_id: Fixnum, created_at: DateTime, updated_at: DateTime, theme: String }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= {:user=>nil, :book=>nil}.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= {"User"=>{:belongs_to=>[:user]}, "Book"=>{:belongs_to=>[:book]}}.merge(super)
    end

    def mocked_class
      "Review"
    end

    private :mocked_class

    def attribute_names
      @attribute_names ||= ["id", "text", "user_id", "book_id", "created_at", "updated_at", "theme"] | super
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "reviews" || super
    end

  end
# _attributes.erb
  def id
    read_attribute(:id)
  end

  def id=(val)
    write_attribute(:id, val)
  end
  def text
    read_attribute(:text)
  end

  def text=(val)
    write_attribute(:text, val)
  end
  def user_id
    read_attribute(:user_id)
  end

  def user_id=(val)
    write_attribute(:user_id, val)
  end
  def book_id
    read_attribute(:book_id)
  end

  def book_id=(val)
    write_attribute(:book_id, val)
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
  def theme
    read_attribute(:theme)
  end

  def theme=(val)
    write_attribute(:theme, val)
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


# _scopes.erb
  module Scopes
    include ActiveMocker::Base::Scopes

  end

  extend Scopes

  class ScopeRelation < ActiveMocker::Association
    include ReviewMock::Scopes
  end

  def self.__new_relation__(collection)
    ReviewMock::ScopeRelation.new(collection)
  end

  private_class_method :__new_relation__
end
