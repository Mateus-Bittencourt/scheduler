class AddTimeZoneToProfessionals < ActiveRecord::Migration[7.1]
  def change
    add_column :professionals, :time_zone, :string, null: false, default: 'UTC'
  end
end
