class ResourceDecorator < ApplicationDecorator
  delegate_all

  decorate_association :comments
end
