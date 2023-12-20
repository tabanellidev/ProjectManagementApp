class MainController < ApplicationController

    skip_before_action :authenticate_user!, only: [:index]

    def index

        if current_user
            current_user.notifications.mark_as_read!
            @notifications = current_user.notifications.reverse

        end

    end

    def notauthorized
    end
end
