class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :new_user, :login]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :check_author, only: [:edit, :update, :destroy]


  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
  if @prototype.save
    redirect_to root_path
  else
    render :new
  end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    unless user_signed_in?
      redirect_to action: :index
    end

  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def destroy
    prototype.destroy
    redirect_to root_path
  end



  private
  def prototype_params
    params.require(:prototype).permit(:title, :image, :catch_copy, :concept).merge(user_id: current_user.id)
  end

  def check_author
    unless user_signed_in? && current_user.id == @prototype.user_id
      redirect_to root_path, alert:"他のユーザーからだと編集はできないよ"
    end
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
end
