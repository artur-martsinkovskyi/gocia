class Service
  def self.call(*attributes)
    new(*attributes).send(:call)
  end
end
