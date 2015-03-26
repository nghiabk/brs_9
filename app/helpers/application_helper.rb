module ApplicationHelper
  def full_title(page_title='')
    base_title = "Ruby on rails"
    if page_title.empty?
      base_title
    else
      "#{page_title}|#{base_title}"
    end
  end

  def render_blank_stars
    output = ''
    5.times {output += image_tag('star-off.png')}
    output.html_safe
  end
  
  def render_stars(value)
    output = ''
    floored = value.floor
    floored.times {output += image_tag('star-on.png')}
    output += image_tag('star-half.png') if(value - floored) >= 0.5
    (5 - value).round.times {output += image_tag('star-off.png')}
    output.html_safe
  end  
end