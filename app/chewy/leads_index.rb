# frozen_string_literal: true

# lead index
class LeadsIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      project_name: {
        tokenizer: 'keyword',
        filter: ['lowercase']
      },
      client_email: {
        tokenizer: 'keyword',
        filter: ['lowercase']
      },
      client_name: {
        tokenizer: 'standard',
        filter: ['lowercase']
      },
      sale: {
        tokenizer: 'keyword',
        filter: ['lowercase']
      }
    }
  }

  index_scope Lead
  field :project_name, analyzer: 'project_name'
  field :client_email, analyzer: 'client_email'
  field :client_name, analyzer: 'client_name'
  field :sale, analyzer: 'sale'
end
