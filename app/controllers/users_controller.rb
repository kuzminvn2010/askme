class UsersController < ApplicationController
  def index
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Vadim',
      username: 'instalero',
      avatar_url: 'https://s.gravatar.com/avatar/421c1bd346e2e9d881f864d1ed66d7a6?s=80'
      )
  end
end
