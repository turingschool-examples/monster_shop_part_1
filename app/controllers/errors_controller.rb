class ErrorsController < ApplicationController
  def show
    @requested_path = request.path
    respond_to do |format|
      format.html
    end
  end
end
