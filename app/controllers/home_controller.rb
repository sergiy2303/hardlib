class HomeController < ApplicationController
  expose(:books) { |default| default.display_index(params) }

  def access_denied
  end
end
