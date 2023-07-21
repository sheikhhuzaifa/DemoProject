
class LeadsIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      project_name: {
        tokenizer: 'keyword',
        filter: ['lowercase']
      }
    }
  }

  index_scope Lead
  field :project_name, analyzer: 'project_name'
end
