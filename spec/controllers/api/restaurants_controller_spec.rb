describe Api::RestaurantsController do
  describe "#search" do
    context "no parameters specified" do
      it "returns all the serialized restaurants as JSON" do
        restaurant1 = create(:restaurant)
        restaurant2 = create(:restaurant)
        expected_json = [
          {
            id:             restaurant1.id,
            name:           restaurant1.dba,
            type:           restaurant1.cuisine.description,
            city_address:   restaurant1.city_address,
            phone_number:   restaurant1.phone_number,
            grade:          restaurant1.current_grade,
            graded_on:      restaurant1.current_grade_date.strftime("%Y-%m-%d")
          },
          {
            id:             restaurant2.id,
            name:           restaurant2.dba,
            type:           restaurant2.cuisine.description,
            city_address:   restaurant2.city_address,
            phone_number:   restaurant2.phone_number,
            grade:          restaurant2.current_grade,
            graded_on:      restaurant2.current_grade_date.strftime("%Y-%m-%d")
          }
        ].to_json

        allow(Builders::Restaurants::ByCuisineAndMinGradeBuilder)
          .to receive(:build)
          .and_return([restaurant1, restaurant2])

        get :search
        expect(response.body).to eq expected_json
      end
    end

    context "parameters specified" do
      it "returns all restaurants with the specified cuisine_type as JSON" do
        cuisine     = create(:cuisine, description: "Pizza")
        pizza_place = create(:restaurant, cuisine: cuisine)
        not_pizza   = create(:restaurant)

        expected_json = [
          {
            id:             pizza_place.id,
            name:           pizza_place.dba,
            type:           pizza_place.cuisine.description,
            city_address:   pizza_place.city_address,
            phone_number:   pizza_place.phone_number,
            grade:          pizza_place.current_grade,
            graded_on:      pizza_place.current_grade_date.strftime("%Y-%m-%d")
          }
        ].to_json

        allow(Builders::Restaurants::ByCuisineAndMinGradeBuilder)
          .to receive(:build)
          .and_return([pizza_place])

        get :search, cuisine: "za"
        expect(response.body).to eq expected_json
      end

      it "returns all restuarants with the specified grade or better as JSON" do
        c_food      = create(:restaurant, current_grade: "C")
        better_food = create(:restaurant)

        expected_json = [
          {
            id:             better_food.id,
            name:           better_food.dba,
            type:           better_food.cuisine.description,
            city_address:   better_food.city_address,
            phone_number:   better_food.phone_number,
            grade:          better_food.current_grade,
            graded_on:      better_food.current_grade_date.strftime("%Y-%m-%d")
          }
        ].to_json

        allow(Builders::Restaurants::ByCuisineAndMinGradeBuilder)
          .to receive(:build)
          .and_return([better_food])

        get :search, grade: "B"
        expect(response.body).to eq expected_json
      end
    end
  end
end
