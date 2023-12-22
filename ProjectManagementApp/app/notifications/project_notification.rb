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
      return "stato modificato"
    end
    if self.params["type"] == "Assigned"
      return "stato assegnato a te"
    end
    if self.params["type"] == "Deallocated"
      return "stato rimosso dalle tue mansioni"
    end
    if self.params["type"] == "Completed"
      return "stato completato"
    end
    if self.params["type"] == "Expired"
      return "scaduto"
    end
    if self.params["type"] == "Soon Expired"
      return "in scadenza"
    end
    if self.params["type"] == "Delayed"
      return "stato completato ma è in ritardo"
    end
    if self.params["type"] == "Created"
      return "stato creato"
    end
    if self.params["type"] == "Deleted"
      return "stato eliminato"
    end

  end

  #
  def url
    post_path(params[:post])
  end
end
