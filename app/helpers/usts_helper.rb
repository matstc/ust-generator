module USTsHelper
  def fix_letter_spacing obj
    string = obj.to_s
    string.gsub("♭", "<span class='narrow'>♭</span>").html_safe
  end
end
