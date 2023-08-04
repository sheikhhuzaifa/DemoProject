module ErrorSerializer
  def ErrorSerializer.serialize(errors, status)
    return {} if errors.nil?


    return { errors: [{ status: status, message: errors }] }

  end
end
