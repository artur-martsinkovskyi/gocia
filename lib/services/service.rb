class Service
  private_class_method :new

  def self.call(*attributes)
    new(*attributes).send(:call)
  end
end
