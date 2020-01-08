class AddDefaultToItemImage < ActiveRecord::Migration[5.1]
  def change
    change_column :items, :image, :string, :default => 'https://media3.s-nbcnews.com/j/newscms/2019_33/2203981/171026-better-coffee-boost-se-329p_67dfb6820f7d3898b5486975903c2e51.fit-760w.jpg'
  end
end
