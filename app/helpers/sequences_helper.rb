module SequencesHelper
  def longest_sequence
    Sequence.most_poses.first
  end

  def sequence_title
    @sequence.title.titleize
  end
end
