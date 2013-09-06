module BasicHelper
  def random_value(collection)
    collection[Random.rand(0...collection.count)]
  end
end