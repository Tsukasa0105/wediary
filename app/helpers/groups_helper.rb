# frozen_string_literal: true

module GroupsHelper
  def the_event
    @event = @group.events.find(map_id: id)
  end
end
