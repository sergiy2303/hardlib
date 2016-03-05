class Admin::CategoriesController < Admin::AdminsController
  before_action :authenticate_user!
  expose(:category, attributes: :category_params)
  expose(:categories) { |default| default.order(title: :asc).page(params[:page]).per(10) }

  def create
    if category.save
      redirect_via_turbolinks_to admin_categories_path
    end
  end

  def update
    if category.save
      redirect_via_turbolinks_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    category.destroy
    redirect_via_turbolinks_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end
end
