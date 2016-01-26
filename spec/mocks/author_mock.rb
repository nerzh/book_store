require 'active_mocker/mock'

class AuthorMock < ActiveMocker::Base
  created_with('2.0.0')

# _modules_constants.erb
#_class_methods.erb
  class << self
    def attributes
      @attributes ||= HashWithIndifferentAccess.new({"id"=>nil, "first_name"=>nil, "last_name"=>nil, "biography"=>nil, "created_at"=>nil, "updated_at"=>nil}).merge(super)
    end

    def types
      @types ||= ActiveMocker::HashProcess.new({ id: Fixnum, first_name: String, last_name: String, biography: String, created_at: DateTime, updated_at: DateTime }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= {:books=>nil}.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= {"Book"=>{:has_and_belongs_to_many=>[:books]}}.merge(super)
    end

    def mocked_class
      "Author"
    end

    private :mocked_class

    def attribute_names
      @attribute_names ||= ["id", "first_name", "last_name", "biography", "created_at", "updated_at"] | super
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "authors" || super
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
  def biography
    read_attribute(:biography)
  end

  def biography=(val)
    write_attribute(:biography, val)
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



# has_and_belongs_to_many
  def books
    read_association(:books, ->{ ActiveMocker::HasAndBelongsToMany.new([]) })
  end

  def books=(val)
    write_association(:books, ActiveMocker::HasAndBelongsToMany.new(val))
  end
# _scopes.erb
  module Scopes
    include ActiveMocker::Base::Scopes

  end

  extend Scopes

  class ScopeRelation < ActiveMocker::Association
    include AuthorMock::Scopes
  end

  def self.__new_relation__(collection)
    AuthorMock::ScopeRelation.new(collection)
  end

  private_class_method :__new_relation__
end
