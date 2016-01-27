class CheckoutForm
  include ActiveModel::Model

  def self.snake(string)
    string.gsub(/((\w)([A-Z]))/,'\2_\3').downcase
  end

  #name params
  def self.model_name
    ActiveModel::Name.new(self, nil, "Order")
  end

  #models for update
  @@models = [ User,
               Order,
               OrderBillingAddress,
               OrderShippingAddress,
               CreditCard ]

  #attr_accessor
  attr_accessor :params
  @@models.each{ |model| attr_accessor snake(model.to_s).to_sym }

  #delegate
  @@models.each do |model|
    model.column_names.each do |attr|
      delegate attr.to_sym, "#{attr}=".to_sym,
               to: snake(model.to_s).to_sym,
               prefix: snake(model.to_s).to_sym
    end
  end

  #validation
  validate :validation_models

  def initialize(current_user, items: nil, params: {}, order: nil)
    self.user                   = current_user
    self.order                  = Order.new(user_id: current_user.id) unless self.order = order
    self.order_billing_address  = OrderBillingAddress.new             unless self.order_billing_address  = self.order.order_billing_address
    self.order_shipping_address = OrderShippingAddress.new            unless self.order_shipping_address = self.order.order_shipping_address
    self.credit_card            = CreditCard.new                      unless self.credit_card = self.user.credit_card

    self.params                 = params                              unless params.empty?
    items.each{ |item| self.order.order_items << item if item.class == OrderItem } if items and self.order.order_items.empty?
  end

  def submit
    update_attributes
  end

  def save
    if valid?
      models = get_model_for_save
      while model1 = models.delete( models[0] )
        @@models.each{ |model2| save_models(model1, model2) }
      end

      return true
    end
    false
  end

  private

  def save_models(model1, model2)
    self_model1 = method( self.class.snake(model1.to_s) ).call
    self_model2 = method( self.class.snake(model2.to_s) ).call

    case get_association(model1, model2)
      when :belongs_to
        self_model1.send( "#{self.class.snake(model2.to_s)}=", self_model2 )
        self_model1.save
      when :has_one
        self_model1.send( "#{self.class.snake(model2.to_s)}=", self_model2 )
        self_model1.save
      when :has_many
        self_model1.send( "#{self.class.snake(model2.to_s)}<<", self_model2 )
        self_model1.save
      when :has_and_belongs_to_many
        self_model1.send( "#{self.class.snake(model2.to_s)}<<", self_model2 )
        self_model1.save
    end
  end

  def validation_models
    get_model_for_save.each do |model|
      set_errors( method(self.class.snake(model.to_s)).call.errors ) unless method( self.class.snake(model.to_s) ).call.valid?
    end
  end

  def set_errors(model_errors)
    model_errors.each do |attribute, message|
      errors.add(attribute, message)
    end
  end

  def update_attributes
    @@models.each do |model|
      model_attributes = []
      model.column_names.each do |name|
        model_attributes << "#{self.class.snake(model.to_s)}_#{name}"
      end
      update_attributes = {}
      hash_attributes   = params.slice(*model_attributes)
      hash_attributes.each{ |attr, val| update_attributes[attr.gsub(/#{self.class.snake(model.to_s)}_(.*)/, '\1')] = val }
      method( self.class.snake(model.to_s) ).call.assign_attributes(update_attributes)
    end
  end

  def get_model_for_save
    keys = params.keys
    models = []
    @@models.each do |model|
      model.column_names.each do |name|
        keys.each do |key|
          models << model if key.to_s == "#{self.class.snake(model.to_s)}_#{name}"
        end
      end
    end
    models.uniq!
  end

  def get_association(class1, class2)
    class1.reflections.slice(self.class.snake(class2.to_s), class2.table_name).values.first&.macro
  end

end