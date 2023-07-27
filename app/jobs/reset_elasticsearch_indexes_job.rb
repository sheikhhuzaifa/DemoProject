# frozen_string_literal: true

class ResetElasticsearchIndexesJob < ApplicationJob
  queue_as :default

  def perform
    LeadsIndex.reset!
    PhasesIndex.reset!
    ProjectsIndex.reset!
    puts "Background job completed successfully."
  end
end
