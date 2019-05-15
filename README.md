# Restaurant B-Eats

This application was created for a coding challenge.
It was built using **Ruby 2.3** and **Rails 5.0**.

The purpose of this challenge was to create a backend application that
1. creates an ETL service to Extract, Transform, and Load a large CSV file of NYC Restaurant/Inspection data
2. provides an API endpoint to search on this data

## Database and Schema
This app uses a **MySql 8.0** database.
Included in the repo is the database [schema](https://github.com/DanaMC18/restaurant_b_eats/blob/master/db/schema.rb) and a database [backup](https://github.com/DanaMC18/restaurant_b_eats/blob/master/db/backup.sql) of about ~25k records.

## ETL
The code related to ingesting the CSV file consists of
* various [services](https://github.com/DanaMC18/restaurant_b_eats/tree/master/app/services/inspection_etl) that read the CSV, parse each row, and load data into respective database tables
* and a [rake task](https://github.com/DanaMC18/restaurant_b_eats/blob/master/lib/tasks/import_inspections.rake) -- it should be noted that the rake task takes in an optional parameter of `ROW_COUNT`. This argument was used when testing locally and to also limit the size of the production database in hopes of keeping it small/free.

## API Endpoint
The end goal of this challenge was to provide an API endpoint that returns a list of restaurants based on a given "cuisine" (e.g. "Thai", "Pizza", etc) and NYC Inspection Grade (e.g. "A", "B", etc).

It was assumed that the results should include any restaurant with the specified Grade or better.

#### Using the Search
To `GET` a list of restaurants, a user can CURL against the following endpoint `https://restaurant-b-eats.herokuapp.com/api/restaurants/search?cuisine=CUISINE_TYPE&grade=GRADE` like so
```
$ curl https://restaurant-b-eats.herokuapp.com/api/restaurants/search?cuisine=pizza&grade=A
```

In addition to using CURL, a user can also visit the above [URL](https://restaurant-b-eats.herokuapp.com/api/restaurants/search?cuisine=pizza&grade=A) in their browser.

Both `cuisine` and `grade` are optional parameters.

#### The Code
Code related to the above endpoint starts at the [controller action](https://github.com/DanaMC18/restaurant_b_eats/blob/master/app/controllers/api/restaurants_controller.rb).

The controller calls upon a [builder service](https://github.com/DanaMC18/restaurant_b_eats/blob/master/app/services/builders/restaurants/by_cuisine_and_min_grade_builder.rb) where the SQL Query for searching is written using `ActiveRecord / Arel`.

When the controller action receives results from the query builder, it serializes the restaurant data before rendering results in JSON.

## Tests
The [spec folder](https://github.com/DanaMC18/restaurant_b_eats/tree/master/spec) includes rspec tests for the ETL Services, the query builder, and the API Controller.
