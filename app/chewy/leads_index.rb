# frozen_string_literal: true

# lead index
class LeadsIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      project_name: {
        tokenizer: 'ngram',
        filter: ['lowercase']
      },
      client_email: {
        tokenizer: 'ngram',
        filter: ['lowercase']
      },
      client_name: {
        tokenizer: 'ngram',
        filter: ['lowercase']
      },
      sale: {
        tokenizer: 'ngram',
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
