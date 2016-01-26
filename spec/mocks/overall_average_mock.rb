require 'active_mocker/mock'

class OverallAverageMock < ActiveMocker::Base
  created_with('2.0.0')

# _modules_constants.erb
#_class_methods.erb
  class << self
    def attributes
      @attributes ||= HashWithIndifferentAccess.new({"id"=>nil, "rateable_id"=>nil, "rateable_type"=>nil, "overall_avg"=>nil, "created_at"=>nil, "updated_at"=>nil}).merge(super)
    end

    def types
      @types ||= ActiveMocker::HashProcess.new({ id: Fixnum, rateable_id: Fixnum, rateable_type: String, overall_avg: Float, created_at: DateTime, updated_at: DateTime }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= {}.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= {}.merge(super)
    end

    def mocked_class
      "OverallAverage"
    end

    private :mocked_class

    def attribute_names
      @attribute_names ||= ["id", "rateable_id", "rateable_type", "overall_avg", "created_at", "updated_at"] | super
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "overall_averages" || super
    end

  end
# _attributes.erb
  def id
    read_attribute(:id)
  end

  def id=(val)
    write_attribute(:id, val)
  end
  def rateable_id
    read_attribute(:rateable_id)
  end

  def rateable_id=(val)
    write_attribute(:rateable_id, val)
  end
  def rateable_type
    read_attribute(:rateable_type)
  end

  def rateable_type=(val)
    write_attribute(:rateable_type, val)
  end
  def overall_avg
    read_attribute(:overall_avg)
  end

  def overall_avg=(val)
    write_attribute(:overall_avg, val)
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
    include OverallAverageMock::Scopes
  end

  def self.__new_relation__(collection)
    OverallAverageMock::ScopeRelation.new(collection)
  end

  private_class_method :__new_relation__
end
