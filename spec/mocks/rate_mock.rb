require 'active_mocker/mock'

class RateMock < ActiveMocker::Base
  created_with('2.0.0')

# _modules_constants.erb
#_class_methods.erb
  class << self
    def attributes
      @attributes ||= HashWithIndifferentAccess.new({"id"=>nil, "rater_id"=>nil, "rateable_id"=>nil, "rateable_type"=>nil, "stars"=>nil, "dimension"=>nil, "created_at"=>nil, "updated_at"=>nil}).merge(super)
    end

    def types
      @types ||= ActiveMocker::HashProcess.new({ id: Fixnum, rater_id: Fixnum, rateable_id: Fixnum, rateable_type: String, stars: Float, dimension: String, created_at: DateTime, updated_at: DateTime }, method(:build_type)).merge(super)
    end

    def associations
      @associations ||= {:rater=>nil}.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= {"User"=>{:belongs_to=>[:rater]}}.merge(super)
    end

    def mocked_class
      "Rate"
    end

    private :mocked_class

    def attribute_names
      @attribute_names ||= ["id", "rater_id", "rateable_id", "rateable_type", "stars", "dimension", "created_at", "updated_at"] | super
    end

    def primary_key
      "id"
    end

    def abstract_class?
      false
    end

    def table_name
      "rates" || super
    end

  end
# _attributes.erb
  def id
    read_attribute(:id)
  end

  def id=(val)
    write_attribute(:id, val)
  end
  def rater_id
    read_attribute(:rater_id)
  end

  def rater_id=(val)
    write_attribute(:rater_id, val)
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
  def stars
    read_attribute(:stars)
  end

  def stars=(val)
    write_attribute(:stars, val)
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

# belongs_to
  def rater
    read_association(:rater) || write_association(:rater, classes('User').try{ |k| k.find_by(id: rater_id)})
  end
  def rater=(val)
    write_association(:rater, val)
    ActiveMocker::BelongsTo.new(val, child_self: self, foreign_key: :rater_id).item
  end

  def build_rater(attributes={}, &block)
    association = classes('User').try(:new, attributes, &block)
    write_association(:rater, association) unless association.nil?
  end

  def create_rater(attributes={}, &block)
    association = classes('User').try(:create,attributes, &block)
    write_association(:rater, association) unless association.nil?
  end
  alias_method :create_rater!, :create_rater


# _scopes.erb
  module Scopes
    include ActiveMocker::Base::Scopes

  end

  extend Scopes

  class ScopeRelation < ActiveMocker::Association
    include RateMock::Scopes
  end

  def self.__new_relation__(collection)
    RateMock::ScopeRelation.new(collection)
  end

  private_class_method :__new_relation__
end
