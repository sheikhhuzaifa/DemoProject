require 'rack/utils'
class ErrorSerializer
  def initialize(title: nil, status: nil)
    @title = title
    @status = status
  end

  def to_h
    {
      error: {
        status: Rack::Utils.status_code(@status),
        title: @title
      }
    }
  end

end
