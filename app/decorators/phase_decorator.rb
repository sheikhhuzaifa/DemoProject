# frozen_string_literal: true

class PhaseDecorator
  def initialize(phase)
    @phase = phase
  end

  def formatted_start_date
    @phase.start_date.strftime("%B %e, %Y")
  end
end
