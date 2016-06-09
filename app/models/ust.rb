class UST
  attr_accessor :dominant_enabled, :major_enabled, :minor_enabled, :minor_flat_five_enabled, :diminished_enabled
 
  def initialize params
    @dominant_enabled = true
    @major_enabled = true
    @minor_enabled = true
    @minor_flat_five_enabled = true
    @diminished_enabled = true

    params.keys.each {|param| instance_variable_set(:"@#{param}", params[param] == "1")}
  end

  def generate_progression
    keys = %w(A B♭ B C D♭ D E♭ E F G♭ G A♭)
    usts = {}
    usts["7"] = ["♭9♭13", "♯11", "♯9", "♭5♭9", "♯9♭13", "♭9", "sus4"] if @dominant_enabled
    usts["△"] = ["♯11", "9"] if @major_enabled
    usts["-7"] = ["13", "♭13"] if @minor_enabled
    usts["-7♭5"] = ["♭13", "11"] if @minor_flat_five_enabled
    usts["º"] = ["13", "♯11"] if @diminished_enabled

    usts.flat_map {|quality, alternatives|
      alternatives.flat_map {|alternative|
        keys.map {|key|
          Chord.new key, quality, alternative
        }
      }
    }.shuffle
  end

end
