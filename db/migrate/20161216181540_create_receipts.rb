class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.integer :amount
      t.references :lender, index: true
      t.references :borrower, index: true

      t.timestamps null: false
    end
    add_foreign_key :receipts, :lenders
    add_foreign_key :receipts, :borrowers
  end
end
