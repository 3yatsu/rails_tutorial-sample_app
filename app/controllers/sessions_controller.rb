class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			# ユーザをサインインさせ、ユーザページにリダイレクトする	
			sign_in user
			redirect_back_or user
		else
			# エラーメッセージを表示し、サインインフォームを再描画する。
			flash.now[:error]	= 'invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
