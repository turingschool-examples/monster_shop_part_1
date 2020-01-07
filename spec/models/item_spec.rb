require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image }
    it { should validate_presence_of :inventory }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :reviews}
    it {should have_many :item_orders}
    it {should have_many(:orders).through(:item_orders)}
  end

  describe "instance methods" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @item_2 = create :item, merchant: @bike_shop, active?: false
      @review_1 = @chain.reviews.create(title: "Great place!", content: "They have great bike stuff and I'd recommend them to anyone.", rating: 5)
      @review_2 = @chain.reviews.create(title: "Cool shop!", content: "They have cool bike stuff and I'd recommend them to anyone.", rating: 4)
      @review_3 = @chain.reviews.create(title: "Meh place", content: "They have meh bike stuff and I probably won't come back", rating: 1)
      @review_4 = @chain.reviews.create(title: "Not too impressed", content: "v basic bike shop", rating: 2)
      @review_5 = @chain.reviews.create(title: "Okay place :/", content: "Brian's cool and all but just an okay selection of items", rating: 3)
    end

    it "calculate average review" do
      expect(@chain.average_review).to eq(3.0)
    end

    it "sorts reviews" do
      top_three = @chain.sorted_reviews(3,:desc)
      bottom_three = @chain.sorted_reviews(3,:asc)

      expect(top_three).to eq([@review_1,@review_2,@review_5])
      expect(bottom_three).to eq([@review_3,@review_4,@review_5])
    end

    it 'no orders' do
      expect(@chain.no_orders?).to eq(true)
      user = create :random_reg_user_test
      order = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: user.id)
      order.item_orders.create(item: @chain, price: @chain.price, quantity: 2)
      expect(@chain.no_orders?).to eq(false)
    end

    it "top_five" do
      item_1 = create(:item)

      create(:item_order, item_id: item_1.id, quantity: 5)

      item_2 = create(:item)
      create(:item_order, item_id: item_2.id, quantity: 4)

      item_3 = create(:item)
      create(:item_order, item_id: item_3.id, quantity: 3)

      item_4 = create(:item)
      create(:item_order, item_id: item_4.id, quantity: 2)

      item_5 = create(:item)
      create(:item_order, item_id: item_5.id, quantity: 1)

      top_five = Item.top_five
      expect(top_five[0].id).to eq(item_1.id)
      expect(top_five[1].id).to eq(item_2.id)
      expect(top_five[2].id).to eq(item_3.id)
      expect(top_five[3].id).to eq(item_4.id)
      expect(top_five[4].id).to eq(item_5.id)

      expect(top_five[3].quantity).to eq(2)
    end

    it "bottom_five" do
      #adding
      item_1 = create(:item)
      create(:item_order, item_id: item_1.id, quantity: 5)
      item_2 = create(:item)
      create(:item_order, item_id: item_2.id, quantity: 4)
      item_3 = create(:item)
      create(:item_order, item_id: item_3.id, quantity: 3)
      item_4 = create(:item)
      create(:item_order, item_id: item_4.id, quantity: 2)
      item_5 = create(:item)
      create(:item_order, item_id: item_5.id, quantity: 1)

      bottom_five = Item.bottom_five
      expect(bottom_five[0].id).to eq(item_5.id)
      expect(bottom_five[1].id).to eq(item_4.id)
      expect(bottom_five[2].id).to eq(item_3.id)
      expect(bottom_five[3].id).to eq(item_2.id)
      expect(bottom_five[4].id).to eq(item_1.id)

      expect(bottom_five[3].quantity).to eq(4)
    end

    it 'not_active' do
      expect(@item_2.not_active?).to be true
    end
  end
end
