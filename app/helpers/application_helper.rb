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
  
  # Automatically convert URLs to HTML links, and make them open on a new page
  # Remove protocol http:// or https:// from the link text
  def render_links(content)
    auto_link(content, :html => { :target => '_blank' }) do |text|
      # .sub(...)  only replaces the visualized text
      # .sub!(...) replaces the actual link AND the visualized text
      text.sub(/^https?\:\/\//, '')
    end
  end
  
end
