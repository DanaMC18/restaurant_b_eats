describe Builders::Restaurants::ByCuisineAndMinGradeBuilder do
  describe ".build" do
    context "no parameters are specified" do
      it "builds a query to search for all restaurants" do
        restaurant1 = create(:restaurant)
        restaurant2 = create(:restaurant)
        expect(Builders::Restaurants::ByCuisineAndMinGradeBuilder.build(nil, nil))
          .to eq [restaurant1, restaurant2]
      end
    end

    context "a cuisine is specified" do
      it "builds a query to search for all restuarants with a matching cuisine_type" do
        cuisine         = create(:cuisine, description: "thai")
        thai_restaurant = create(:restaurant, cuisine: cuisine)
        bakery          = create(:restaurant)
        builder         = Builders::Restaurants::ByCuisineAndMinGradeBuilder

        expect(builder.build(cuisine.description, nil)).to eq [thai_restaurant]
      end
    end

    context "a grade is specified" do
      it "builds a query to search all restaurants with the grade or better" do
        c_food    = create(:restaurant, current_grade: "C")
        meh_food  = create(:restaurant, current_grade: "B")
        aces_food = create(:restaurant, current_grade: "A")

        expect(Builders::Restaurants::ByCuisineAndMinGradeBuilder.build(nil, "B"))
          .to eq [meh_food, aces_food]
      end
    end

    context "a cuisine and a grade are specified" do
      it "searches for all restaurants matching the cuisine and with the grade or better" do
        pizza       = create(:cuisine, description: "pizza")
        not_pizza   = create(:cuisine)
        pizza_place = create(:restaurant, cuisine: pizza, current_grade: "B")
        dominos     = create(:restaurant, cuisine: not_pizza, current_grade: "A")
        pizza_bros  = create(:restaurant, cuisine: pizza, current_grade: "C")

        expect(Builders::Restaurants::ByCuisineAndMinGradeBuilder.build("za", "B"))
          .to eq [pizza_place]
      end
    end
  end
end
