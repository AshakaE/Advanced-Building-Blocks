# Rebuilding some basic enumerable methods in Ruby 

The Enumerable module provides a collection of methods that get "mixed in", or included, with other classes like Array and Hash. The class must provide a method each, which yields successive members of the collection.

The task is to rebuild the methods, list of method rebuilt as follows:
- `my_each`
- `my_each_with_index`
- `my_select`
- `my_all`
- `my_map`
- `my_any`
- `my_none`
- `my_count`
- `my_inject`

```ruby
  p [3, 4, 6, 9].my_each_with_index { |x, i| p "we have index of #{i} for case #{x}"}
  =>  "we have index of 0 for case 3"
      "we have index of 1 for case 4"
      "we have index of 2 for case 6"
      "we have index of 3 for case 9"
      [3, 4, 6, 9]
```


## Built With

![Ruby](https://www.vectorlogo.zone/logos/ruby-lang/ruby-lang-horizontal.svg)

## Getting Started

To get a local copy up and running follow these simple example steps.

- git clone git@github.com:AshakaE/Advanced-Building-Blocks.git
- cd Advanced-Building-Blocks
- git checkout -b basic-enumerable-feature
- git pull origin basic-enumerable-feature
- Run ruby script.rb


## Authors

👤 **Ashaka**

- Github : [AshakaE](https://github.com/AshakaE)
- Twitter : [shaqzee](https://twitter.com/shaqzee_)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

## Show your support

Give a ⭐️ if you like this project!

