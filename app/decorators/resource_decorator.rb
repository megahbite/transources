class ResourceDecorator < ApplicationDecorator
  include ActionView::Helpers::OutputSafetyHelper
  delegate_all

  decorates_association :comments

  def address(join_string)
    safe_join([address_line_1, address_line_2, town, country], join_string.html_safe)
  end

  def categories_list
    object.categories.map(&:name).join(', ')
  end
end
