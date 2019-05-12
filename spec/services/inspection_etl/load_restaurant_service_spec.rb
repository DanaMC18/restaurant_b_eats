describe InspectionEtl::LoadRestaurantService do

  describe ".load" do
    context "attributes do not match an existing restaurant" do
      it "creates a new restaurant" do
        attributes = {
          camis:            3007890,
          dba:              "Paul Hollywood Breads",
          cuisine_desc:     "bread",
          building_number:  "123",
          street:           "Perfectly Prooved Way",
          boro:             "Manhattan",
          zipcode:          "12345",
          phone_number:     "2129876543"
        }

        expect(Restaurant.exists?(attributes.except(:cuisine_desc))).to be false
        InspectionEtl::LoadRestaurantService.load(attributes)
        expect(Restaurant.exists?(attributes.except(:cuisine_desc))).to be true
      end
    end

    context "attributes match an existing restaurant" do
      it "returns the existing restaurant" do
        restaurant = create(:restaurant)
        attributes = {
          camis:            restaurant.camis,
          dba:              restaurant.dba,
          cuisine_desc:     restaurant.cuisine.description,
          building_number:  restaurant.building_number,
          street:           restaurant.street,
          boro:             restaurant.boro,
          zipcode:          restaurant.zipcode,
          phone_number:     restaurant.phone_number
        }

        expect(Restaurant.exists?(attributes.except(:cuisine_desc))).to be true
        expect(InspectionEtl::LoadRestaurantService.load(attributes))
          .to eq restaurant
      end
    end
  end

  describe "#find_or_create_cuisine" do
    context "cuisine_desc in attributes does not match an existing cuisine" do
      it "creates a new cuisine" do
        attributes  = { cuisine_desc: "Great British Bakery" }
        service     = InspectionEtl::LoadRestaurantService.new(attributes)

        expect(Cuisine.exists?(description: attributes[:cuisine_desc])).to be false
        service.send(:find_or_create_cuisine)
        expect(Cuisine.exists?(description: attributes[:cuisine_desc])).to be true
      end
    end

    context "cuisine_desc in attributes matches an existing cuisine" do
      it "returns the existing cuisine" do
        cuisine     = create(:cuisine)
        attributes  = { cuisine_desc: cuisine.description }
        service     = InspectionEtl::LoadRestaurantService.new(attributes)

        expect(service.send(:find_or_create_cuisine)).to eq cuisine
      end
    end
  end
end
