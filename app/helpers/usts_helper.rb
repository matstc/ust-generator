module USTsHelper
  def fix_letter_spacing obj
    string = obj.to_s
    string.gsub(" ", "&thinsp;").gsub("♭", "<span class='narrow'>♭</span>").gsub("♯", "<span class='narrow'>♯</span>").gsub("△", "<span class='maj7'>△</span>").html_safe
  end
end
