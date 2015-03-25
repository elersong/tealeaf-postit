class CategoriesController < ApplicationController
  
  before_action -> { verify_admin("You do not have permission to create a category.") }, only: [:create, :new]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))
    
    if @category.save
      flash[:notice] = "The category '#{params[:category][:name]}' was successfully created."
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @category = Category.find_by(slug: params[:id])
  end
  
end