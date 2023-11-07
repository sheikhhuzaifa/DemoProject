# app/controllers/projects_controller.rb
class ProjectsController < ApplicationController
  # Eager load associated records
  @projects = Project.includes(:manager, :lead).all

  # Cache result of expensive operation
  @projects = Rails.cache.fetch("projects", expires_in: 5.minutes) do
    Project.all.to_a
  end

  # Extract complex code block into a separate method
  def complex_code_block
    # Code goes here...
  end

  # Use design pattern to simplify code
  class DesignPattern
    # Code goes here...
  end

  # Global exception handler
  rescue_from Exception do |exception|
    # Handle exception...
    logger.error exception.message
  end

  # This is a Javadoc-style comment
  # @param [Type] name description
  # @return [Type] description
  # @raise [ExceptionClass] description
  def method_name
    # Code goes here...
  end

  # This is a class-level comment
  class ClassName
    # This is a method-level comment
    def method_name
      # Code goes here...
    end
  end

  # Linter configuration
  require 'rubocop'
  RuboCop::CLI.new.run

  # Code formatter configuration
  require 'rubocop'
  RuboCop::Formatter::SimpleTextFormatter.new.format
end