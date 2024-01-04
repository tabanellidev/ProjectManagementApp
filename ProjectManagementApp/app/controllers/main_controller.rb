class MainController < ApplicationController

    #Per accedere alla pagina principale non è necessaria l'autenticazione
    skip_before_action :authenticate_user!, only: [:index]

    def index

        if current_user

            @notifications = current_user.notifications.reverse
            current_user.notifications.mark_as_read!

        end

    end

    def notauthorized
    end

    def errors
        @error = params[:id]
    end
end
