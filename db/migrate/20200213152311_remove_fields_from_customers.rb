class RemoveFieldsFromCustomers < ActiveRecord::Migration[6.0]
  def change

    remove_column :customers, :email, :string

    remove_column :customers, :password_digest, :string
  end
end
