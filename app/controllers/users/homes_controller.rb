class Users::HomesController < ApplicationController
  def top
    @posts = Post.all.order(created_at: :desc).limit(3)
    @tags = Tag.all
  end

  def about
  end
end
