class Users::SessionsController < Devise::SessionsController

  def new
    super do
      respond_to do |format|
        format.html { respond_with(resource, serialize_options(resource)) }
        format.js { render 'login_modal' }
      end
      return
    end
  end

  def create
    super { redirect_via_turbolinks_to root_path and return }
  end

  def destroy
    super { redirect_via_turbolinks_to root_path and return }
  end

end
