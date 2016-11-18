class SequenceCommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user, :created_at
  has_one :sequence, serializer: SequenceCommentSerializer
  has_one :user, serializer: UserSerializer
end
