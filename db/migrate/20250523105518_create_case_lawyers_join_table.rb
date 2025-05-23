class CreateCaseLawyersJoinTable < ActiveRecord::Migration[7.2]
  def change
    create_table :case_lawyers, id: false do |t|
      t.references :case, null: false, foreign_key: true
      t.references :lawyer, null: false, foreign_key: { to_table: :users }

      t.index [:case_id, :lawyer_id], unique: true, name: "index_case_lawyers_on_case_id_and_lawyer_id"
    end
  end
end
