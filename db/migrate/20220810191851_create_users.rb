# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo, default: 'https://cdn.discordapp.com/attachments/924502144810360833/1009475393054576671/e.png'
      t.text :bio
      t.integer :postscounter, default: 0

      t.timestamps
    end
  end
end
