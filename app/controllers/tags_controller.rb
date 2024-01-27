class TagsController < ApplicationController
  skip_before_action :authenticated?, only: [:index]
  def index
    tags = Tag.all.pluck(:name).sort
    render json: { tags: }
  end
end
