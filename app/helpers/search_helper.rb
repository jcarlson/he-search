module SearchHelper
  def sort_by(field)
    case params[:sort]
    when field
      link_to 'sort &#9650;'.html_safe, search_index_path(sort: "-#{field}")
    when "-#{field}"
      link_to 'sort &#9660;'.html_safe, search_index_path
    else
      link_to 'sort', search_index_path(sort: field)
    end
  end
end
