module ApplicationHelper
  
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Divelog"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  def emojify(content)
    h(content).to_str.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        %(<img class="emoji" title=":#$1:" alt=":#$1:" src="#{image_path("emoji/#{emoji.image_filename}")}" width="20" height="20" align="absmiddle" />)
      else
        match
      end
    end.html_safe if content.present?
  end
  
end
