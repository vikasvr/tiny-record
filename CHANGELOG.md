### 1.0.3 - 2019-06-08

* Enhancements
  * Added fetch_where which can be used as :
  ```ruby
    User.fetch_where(city: "london", with: [:first_name, :last_name])
  ```
  to get fetch records with their first and last name.
