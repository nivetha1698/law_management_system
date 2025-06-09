class AddCourtCaseAndLawyerToAppointments < ActiveRecord::Migration[8.0]
  def change
    add_column :appointments, :case_id, :integer
    add_column :appointments, :lawyer_id, :integer
  end
end
