# To deliver this notification:
#
#ProjectNotification.with(post: @post).deliver_later(current_user)
# ProjectNotification.with(post: @post).deliver(current_user)

class ProjectNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  def message
    params[:message]
  end

  def object
    if self.params["object"] == "Assignment"
      return "compito"
    end
    if self.params["object"] == "Project"
      return "progetto"
    end
    if self.params["object"] == "Task"
      return "task"
    end
  end

  def title
    self.params["title"]
  end

  def operation
    if self.params["type"] == "Edit"
      return "modificato"
    end
    if self.params["type"] == "Assigned"
      return "assegnato"
    end
    if self.params["type"] == "Complete"
      return "completato"
    end
    if self.params["type"] == "Expired"
      return "scaduto"
    end
  end

  #
  def url
    post_path(params[:post])
  end
end
