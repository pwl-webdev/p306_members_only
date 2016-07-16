class PostsController < ApplicationController
	before_action :require_login, only: [:new, :create]

	def new
		@post = Post.new
	end
	def create
		@post = Post.new(:title => params[:post][:title], :body => params[:post][:body], :user => current_user)
		@post.save
		redirect_to posts_path
	end
	def index
		@posts = Post.all
	end
end
