class WelcomeController < ApplicationController
  def index
    cookies[:curso] = "Curso de Ruby on Rails - Werbson Yuri [COOKIE]"
    session[:curso] = "Development Ruby on Rails - Werbson Yuri [ SESSION]"
    @meu_nome = params[:nome]
    @curso = params[:curso]
  end
end
