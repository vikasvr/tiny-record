## 1.1.2 - 2020-01-02

### Improvements

* Now fetch_where supports string queries, for eg. 
```ruby
  User.fetch_where("first_name = ?", "John")
``` 

## 1.1.1 - 2019-12-30

### Bugfixes

* Fix tiny column's configuration not working when used in multiple classes. 


## 1.0.3 - 2019-06-08

### Improvements
  * Added fetch_where which can be used as :
  ```ruby
    User.fetch_where(city: "london", with: [:first_name, :last_name])
  ```
  to get fetch records with their first and last name.
