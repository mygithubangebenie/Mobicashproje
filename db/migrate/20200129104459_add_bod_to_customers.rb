class AddBodToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :dob, :date
    add_column :customers, :phone, :string
    add_column :customers, :nationality, :string
  end
end
