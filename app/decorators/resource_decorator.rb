class ResourceDecorator < ApplicationDecorator
  delegate_all

  decorates_association :comments
end
