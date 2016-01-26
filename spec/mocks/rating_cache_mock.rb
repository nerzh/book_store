require 'active_mocker/mock'

class RatingCacheMock < ActiveMocker::Base
  created_with('2.0.0')

# _modules_constants.erb
#_class_methods.erb
  class << self
    def attributes
      @attributes ||= HashWithIndifferentAccess.new({"id"=>nil, "cacheable_id"=>nil, "cacheable_type"=>nil, "avg"=>nil, "qty"=>nil, "dimension"=>nil, "created_at"=>nil, "updated_at"=>nil}).merge(super)
    end

    def types
      @types ||= ActiveMocker::HashProcess.new({ id: Fixnum, cacheable_id: Fixnum, cacheable_type: String, avg: Float, qty: Fixnum, dimension: String, created_at: DateTime, updated_at: DateTime }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= {}.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= {}.merge(super)
    end

    def mocked_class
      "RatingCache"
    end

    private :mocked_class

    def attribute_names
      @attribute_names ||= ["id", "cacheable_id", "cacheable_type", "avg", "qty", "dimension", "created_at", "updated_at"] | super
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "rating_caches" || super
    end

  end
# _attributes.erb
  def id
    read_attribute(:id)
  end

  def id=(val)
    write_attribute(:id, val)
  end
  def cacheable_id
    read_attribute(:cacheable_id)
  end

  def cacheable_id=(val)
    write_attribute(:cacheable_id, val)
  end
  def cacheable_type
    read_attribute(:cacheable_type)
  end

  def cacheable_type=(val)
    write_attribute(:cacheable_type, val)
  end
  def avg
    read_attribute(:avg)
  end

  def avg=(val)
    write_attribute(:avg, val)
  end
  def qty
    read_attribute(:qty)
  end

  def qty=(val)
    write_attribute(:qty, val)
  end
  def dimension
    read_attribute(:dimension)
  end

  def dimension=(val)
    write_attribute(:dimension, val)
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



# _scopes.erb
  module Scopes
    include ActiveMocker::Base::Scopes

  end

  extend Scopes

  class ScopeRelation < ActiveMocker::Association
    include RatingCacheMock::Scopes
  end

  def self.__new_relation__(collection)
    RatingCacheMock::ScopeRelation.new(collection)
  end

  private_class_method :__new_relation__
end
