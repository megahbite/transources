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

  def score_for(user)
    score = object.scores.find_by(user_id: user.id)
    score ? score.value : 0
  end

  def score
    m = 3
    c = 5
    n = object.scores.count
    sum = object.scores.reduce(0) { |s, i| s + i.value }

    ((c * m) + sum) / (c + n)
  end
end
