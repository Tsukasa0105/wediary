# frozen_string_literal: true

module ToppagesHelper
  def profile_picture(user, width = 100)
    image_path = user.image.url(:icon).present? ? user.image.url : 'default.png'
    image_tag(image_path, width: width, class: 'image-circle')
  end

  def default_group_picture(group, width = 100)
    image_path = group.image.url(:icon).present? ? group.image.url : 'group_default.png'
    image_tag(image_path, width: width, class: 'image-circle')
  end

  def default_event_picture(event, width = 100)
    image_path = event.image.url(:icon).present? ? event.image.url : 'event_default.png'
    image_tag(image_path, width: width, class: 'image-circle')
  end
end
