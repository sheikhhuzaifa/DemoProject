# frozen_string_literal: true

# lead phase
class PhasesIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      phase_type: {
        tokenizer: "ngram",
        filter: ["lowercase"]
      },
      completed: {
        tokenizer: "ngram",
        filter: ["lowercase"]
      }
    }
  }
  index_scope Phase
  field :phase_type, analyzer: "phase_type"
  field :completed, analyzer:  "completed"
end
