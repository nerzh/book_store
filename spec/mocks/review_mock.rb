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
      @associations ||= {:user=>nil, :book=>nil, :rate_average_without_dimension=>nil, :rating_average=>nil, :rates_without_dimension=>nil, :raters_without_dimension=>nil, :rating_rates=>nil, :rating_raters=>nil}.merge(super)
    end

    def associations_by_class
      @associations_by_class ||= {"User"=>{:belongs_to=>[:user], :has_many=>[:raters_without_dimension, :rating_raters]}, "Book"=>{:belongs_to=>[:book]}, "RatingCache"=>{:has_one=>[:rate_average_without_dimension, :rating_average]}, "Rate"=>{:has_many=>[:rates_without_dimension, :rating_rates]}}.merge(super)
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

# has_one
  def rate_average_without_dimension
    read_association(:rate_average_without_dimension)
  end

  def rate_average_without_dimension=(val)
    write_association(:rate_average_without_dimension, val)
    ActiveMocker::HasOne.new(val, child_self: self, foreign_key: 'cacheable_id').item
  end

  def build_rate_average_without_dimension(attributes={}, &block)
    write_association(:rate_average_without_dimension, classes('RatingCache').new(attributes, &block)) if classes('RatingCache')
  end

  def create_rate_average_without_dimension(attributes={}, &block)
    write_association(:rate_average_without_dimension, classes('RatingCache').new(attributes, &block)) if classes('RatingCache')
  end
  alias_method :create_rate_average_without_dimension!, :create_rate_average_without_dimension
  def rating_average
    read_association(:rating_average)
  end

  def rating_average=(val)
    write_association(:rating_average, val)
    ActiveMocker::HasOne.new(val, child_self: self, foreign_key: 'cacheable_id').item
  end

  def build_rating_average(attributes={}, &block)
    write_association(:rating_average, classes('RatingCache').new(attributes, &block)) if classes('RatingCache')
  end

  def create_rating_average(attributes={}, &block)
    write_association(:rating_average, classes('RatingCache').new(attributes, &block)) if classes('RatingCache')
  end
  alias_method :create_rating_average!, :create_rating_average

# has_many
  def rates_without_dimension
    read_association(:rates_without_dimension, -> { ActiveMocker::HasMany.new([],foreign_key: 'rateable_id', foreign_id: self.id, relation_class: classes('Rate'), source: '') })
  end

  def rates_without_dimension=(val)
    write_association(:rates_without_dimension, ActiveMocker::HasMany.new(val, foreign_key: 'rateable_id', foreign_id: self.id, relation_class: classes('Rate'), source: ''))
  end
  def raters_without_dimension
    read_association(:raters_without_dimension, -> { ActiveMocker::HasMany.new([],foreign_key: 'rater_id', foreign_id: self.id, relation_class: classes('User'), source: 'rater') })
  end

  def raters_without_dimension=(val)
    write_association(:raters_without_dimension, ActiveMocker::HasMany.new(val, foreign_key: 'rater_id', foreign_id: self.id, relation_class: classes('User'), source: 'rater'))
  end
  def rating_rates
    read_association(:rating_rates, -> { ActiveMocker::HasMany.new([],foreign_key: 'rateable_id', foreign_id: self.id, relation_class: classes('Rate'), source: '') })
  end

  def rating_rates=(val)
    write_association(:rating_rates, ActiveMocker::HasMany.new(val, foreign_key: 'rateable_id', foreign_id: self.id, relation_class: classes('Rate'), source: ''))
  end
  def rating_raters
    read_association(:rating_raters, -> { ActiveMocker::HasMany.new([],foreign_key: 'rater_id', foreign_id: self.id, relation_class: classes('User'), source: 'rater') })
  end

  def rating_raters=(val)
    write_association(:rating_raters, ActiveMocker::HasMany.new(val, foreign_key: 'rater_id', foreign_id: self.id, relation_class: classes('User'), source: 'rater'))
  end

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
