module NotificationsHelper

   def notification_form(notification)
      @visiter = notification.visiter
      @group = notification.group
      @event = notification.event
      
      case notification.action
        when "follow" then
          if current_user.following?(@visiter)
            tag.a(@visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"があなたの友達申請を承認をしました"
          else
            tag.a(@visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"があなたに友達申請をしました"
          end
        when "new_event" then
          tag.a(@visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a(@group.name, href:group_path(@group), style:"font-weight: bold;")+"に"+tag.a("新規イベント", href:group_event_path(@group, @event), style:"font-weight: bold;")+"を作成しました"
        when "edit_event" then
          tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a(@event.name, href:group_event_path(@group, @event), style:"font-weight: bold;")+"を編集しました"
        when "invitation" then
          tag.a(@group.name, href:group_path(@group), style:"font-weight: bold;")+"に招待されました"
      end
    end
        
    def unchecked_notifications
        @notifications = current_user.passive_notifications.where(checked: false)
    end
end
