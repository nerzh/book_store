require 'active_mocker/mock'

class CategoryMock < ActiveMocker::Base
  created_with('2.0.0')

# _modules_constants.erb
#_class_methods.erb
  class << self
    def attributes
      @attributes ||= HashWithIndifferentAccess.new({"id"=>nil, "title"=>nil, "created_at"=>nil, "updated_at"=>nil}).merge(super)
    end

    def types
      @types ||= ActiveMocker::HashProcess.new({ id: Fixnum, title: String, created_at: DateTime, updated_at: DateTime }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= {:books=>nil}.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= {"Book"=>{:has_many=>[:books]}}.merge(super)
    end

    def mocked_class
      "Category"
    end

    private :mocked_class

    def attribute_names
      @attribute_names ||= ["id", "title", "created_at", "updated_at"] | super
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "categories" || super
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


# has_many
  def books
    read_association(:books, -> { ActiveMocker::HasMany.new([],foreign_key: 'category_id', foreign_id: self.id, relation_class: classes('Book'), source: '') })
  end

  def books=(val)
    write_association(:books, ActiveMocker::HasMany.new(val, foreign_key: 'category_id', foreign_id: self.id, relation_class: classes('Book'), source: ''))
  end

# _scopes.erb
  module Scopes
    include ActiveMocker::Base::Scopes

  end

  extend Scopes

  class ScopeRelation < ActiveMocker::Association
    include CategoryMock::Scopes
  end

  def self.__new_relation__(collection)
    CategoryMock::ScopeRelation.new(collection)
  end

  private_class_method :__new_relation__
end
