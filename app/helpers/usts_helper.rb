module USTsHelper
  def fix_letter_spacing obj
    string = obj.to_s
    string.gsub(" ", "&thinsp;").html_safe
  end
end
