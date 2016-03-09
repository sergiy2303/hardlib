class HomeController < ApplicationController
  expose(:books) { |default| default.display_index(params) }
  expose(:book)
  def access_denied
  end
end
