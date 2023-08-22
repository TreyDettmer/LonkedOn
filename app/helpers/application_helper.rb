module ApplicationHelper
    def is_active(action)
        if current_user
            puts current_user.id.to_s
        end
        url = request.path_info
        if url.include?(action)
            "active"
        else
            ""
        end
    end
end
