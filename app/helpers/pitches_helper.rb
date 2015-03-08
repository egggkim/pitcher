module PitchesHelper
  def pitch_owner
    current_user == @pitch.user
  end
end
