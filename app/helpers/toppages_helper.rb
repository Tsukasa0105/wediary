module ToppagesHelper
    def profile_picture user, width = 100
        image_path = user.image.present? ? user.image.thumb.url : "default.png" 
        image_tag(image_path, width: width, class: "image-circle") 
    end
    
    def default_group_picture group, width = 100
        image_path = group.image.present? ? group.image.thumb.url : "group_default.png" 
        image_tag(image_path, width: width, class: "image-circle") 
    end
    
    def default_event_picture event, width = 100
        image_path = event.image.present? ? event.image.thumb.url : "event_default.png" 
        image_tag(image_path, width: width, class: "image-circle") 
    end
end
