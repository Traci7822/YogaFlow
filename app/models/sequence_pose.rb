class SequencePose < ActiveRecord::Base
  belongs_to :sequence
  belongs_to :pose
end
