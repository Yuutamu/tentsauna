# TODO: ActionCable 利用予定無いので削除する

require_relative '../config/environment'
Rails.application.eager_load!

run ActionCable.server
