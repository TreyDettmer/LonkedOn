# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    redirect_to new_user_session_path and return
    super
  end



=begin
<p class="title">Sign Up</p>
  <div class="inline">
    <div class="field">
      <%= f.label :first_name, class:"label" %>
      <%= f.text_field :first_name, class:"text-input" %>
    </div>
    <div class="field">
      <%= f.label :last_name, class:"label" %>
      <%= f.text_field :last_name, class:"text-input" %>
    </div>
  </div>

  <div class="field">
    <%= f.label :email, class:"label" %>
    <%= f.email_field :email, class:"text-input", autofocus: true, autocomplete: "email" %>
  </div>

  <div class="field">
    <%= f.label :headline, class:"label" %>
    <%= f.text_field :headline, class:"text-input headline-input" %>
  </div>

  <div class="field">
    <%= f.label :avatar, class:"label" %>
    <%= f.file_field :avatar %>
  </div>



  <div class="field">
    <%= f.label :password, class:"label" %>

    <%= f.password_field :password, class:"text-input", autocomplete: "new-password" %>
    <% if @minimum_password_length %>
      <p class="sub-label">(<%= @minimum_password_length %> characters minimum)</p>
    <% end %><br />
  </div>

  <div class="field">
    <%= f.label :password_confirmation, class:"label" %>
    <%= f.password_field :password_confirmation, class:"text-input", autocomplete: "new-password" %>
  </div>


  <div class="sign-up-container">
    <%= f.submit class:"sign-up-button" %>
  </div>
=end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :headline, :avatar, :about])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :headline, :avatar, :about])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  def update_resource(resource, params)
    # Require current password if user is trying to change password
    return super if params["password"]&.present?

    # Allows user to update registration information without password
    resource.update_without_password(params.except("current_password"))
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
