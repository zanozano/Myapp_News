# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
   #before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    if user_signed_in?
      redirect_to articles_path
    else
      super
    end
  end

  # POST /resource/sign_in
def create
  self.resource = warden.authenticate(auth_options)
  if resource.nil?
    flash.now[:alert] = "Credenciales inválidas. Por favor, verifica tu correo electrónico y contraseña."
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('login-form', partial: '/devise/shared/alert', locals: { message: flash.now[:alert] }) }
      format.html { render :new }
      format.js { render partial: '/devise/shared/alert', locals: { message: flash.now[:alert] }, status: :unprocessable_entity }
    end
  else
    super
  end
end


  # DELETE /resource/sign_out
  def destroy
    sign_out_all_scopes # Limpiar la sesión de todos los ámbitos (por ejemplo, usuario y administrador)
    reset_session # Limpiar la sesión actual
    redirect_to root_path and return # Redirigir a la vista raíz y finalizar la acción
  end


  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
