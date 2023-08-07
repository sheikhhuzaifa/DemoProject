class LeadSerializer < ActiveModel::Serializer
  attributes :id, :project_name ,:client_contact,:count_phase


  has_many :phases
  def count_phase
    self.object.phases.pluck(:id).count
  end
end
