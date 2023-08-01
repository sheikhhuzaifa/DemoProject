# frozen_string_literal: true

# lead project
class ProjectsIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      project_name: {
        tokenizer: "ngram",
        filter: ["lowercase"]
      },
      assigned_manager_id: {
        tokenizer: "ngram",
        filter: ["lowercase"]
      }
    }
  }

  index_scope Project
  field :project_name, analyzer: "project_name"
  field :assigned_manager_id, analyzer: "assigned_manager_id"
end
