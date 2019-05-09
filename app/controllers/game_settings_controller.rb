# frozen_string_literal: true

class GameSettingsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    render json: GameSetting.last
  end
end
