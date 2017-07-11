class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string   :title
      t.boolean  :completed, default: false
      t.string   :description
      t.integer  :priority
      t.date     :due_date
      t.integer  :user_id
      t.timestamps
    end
  end
end
