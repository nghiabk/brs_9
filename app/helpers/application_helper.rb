module ApplicationHelper
  def full_title page_title=''
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
  
  def render_stars value
    output = ''
    floored = value.floor
    floored.times {output += image_tag('star-on.png')}
    output += image_tag('star-half.png') if(value - floored) >= 0.5
    (5 - value).round.times {output += image_tag('star-off.png')}
    output.html_safe
  end  

  def link_to_remove_fields name, f
    link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields name, f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    link_to title, params.merge(sort: column, page: nil)
  end  
end