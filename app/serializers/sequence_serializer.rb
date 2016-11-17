class SequenceSerializer < ActiveModel::Serializer
  attributes :id, :title, :number_of_poses, :difficulty, :repititions
  has_many :poses, serializer: SequencePoseSerializer
end
