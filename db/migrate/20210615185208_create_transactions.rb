class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :transactionId
      t.integer :carte_id
      t.decimal :transactionAmount
      t.integer :fee
      t.string :productName
      t.string :providerResponseCode
      t.string :providerResponseMessage
      t.string :providerReference
      t.string :transactionReference
      t.string :uniqueReferenceDetails
      t.integer :status
      t.decimal :productId
      t.string :uniqueReference
      t.string :paymentReference
      t.string :paymentType
      t.string :paymentResponseCoe
      t.string :paymentResponseMessage
      t.integer :amountConfirmed
      t.integer :currencyId
      t.string :narration
      t.string :indicator
      t.string :dateCreated
      t.string :statusName
      t.string :description
      t.string :currency
      t.string :merchantName
      t.string :transactionDescription

      t.timestamps
    end
  end
end
