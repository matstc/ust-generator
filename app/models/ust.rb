class UST
  attr_accessor :dominant_seventh_extensions,
    :major_seventh_extensions,
    :minor_seventh_extensions,
    :minor_seventh_flat_five_extensions,
    :diminished_seventh_extensions
 
  DOMINANT_SEVENTH_EXTENSIONS = ["♭9♭13", "♯11", "♯9", "♭5♭9", "♯9♭13", "♭9", "sus4"]
  MAJOR_SEVENTH_EXTENSIONS = ["♯11", "9"]
  MINOR_SEVENTH_EXTENSIONS = ["13", "♭13", "11"]
  MINOR_SEVENTH_FLAT_FIVE_EXTENSIONS = ["♭13", "11"]
  DIMINISHED_SEVENTH_EXTENSIONS = ["♯11", "13", "#9♭13", "#9♯11"]

  def initialize params
    params.keys.each {|key| instance_variable_set(:"@#{key}", params[key])}
  end

  def generate_progression
    keys = %w(A B♭ B C D♭ D E♭ E F G♭ G A♭)
    usts = {}
    usts["7"] = @dominant_seventh_extensions
    usts["△"] = @major_seventh_extensions
    usts["–7"] = @minor_seventh_extensions
    usts["–7♭5"] = @minor_seventh_flat_five_extensions
    usts["º"] = @diminished_seventh_extensions

    usts.flat_map {|quality, alternatives|
      next if alternatives.blank?

      alternatives.flat_map {|alternative|
        keys.map {|key|
          Chord.new key, quality, alternative
        }
      }
    }.compact
  end

end
