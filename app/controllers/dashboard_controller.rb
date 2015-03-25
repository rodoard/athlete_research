class DashboardController < ApplicationController
  DEFAULT_DATE = Date.parse('2015-03-16')

  def index
    @players = Player.all
  end

  private

  def date
    @date ||= params[:date] ? date_from_params : DEFAULT_DATE
  end

  def date_from_params
    Date.parse(params[:date])
  rescue ArgumentError
    DEFAULT_DATE
  end
  helper_method :date
end