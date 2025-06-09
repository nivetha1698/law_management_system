class AddAppointmentIdToNotes < ActiveRecord::Migration[8.0]
  def change
    add_reference :notes, :appointment, foreign_key: true
  end
end
