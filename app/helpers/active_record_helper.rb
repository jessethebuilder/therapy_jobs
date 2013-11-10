module ActiveRecordHelper
  def acts_like_an_array(*args)
    delin = '<!@--@!>'

    args.each do |arg|

      define_method(arg) do
        attr = read_attribute(arg)
        attr ? attr.split(delin) : []
      end

      define_method("#{arg.to_s}=") do |array|
        write_attribute(arg, array.join(delin))
      end

      define_method("add_#{arg.to_s}") do |array_items|
        array_items.class == Array ? items = array_items : items = [array_items]
        arr = send(arg)
        items.each{ |item| arr << item }
        write_attribute(arg, arr.uniq.join(delin))
      end

    end
  end
end

