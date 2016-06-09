class Chord
  def initialize root, quality, extensions, comment=nil
    @root = root
    @quality = quality
    @extensions = extensions
    @comment = comment
  end

  def to_s
    string = "#{@root}#{@quality}#{@extensions}"
    string += " :#{@comment}" if @comment
    string
  end

end
