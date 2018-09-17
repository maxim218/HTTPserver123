class Pair
  def init_fields (a, b)
    @a_field = a
    @b_field = b
  end

  def get_key
    @a_field.to_s
  end

  def get_value
    @b_field.to_s
  end
end
