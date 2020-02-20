# Petagram

An app designed to showcase and share pictures of your pets with your friends and family. 

This app powers Petagram located on Heroku at https://dashboard.heroku.com/apps/pet-a-gram-your-pets-pic-place

## Getting Started

## Software requirements

- Rails 6.0.0 or higher

- Ruby 2.3.1 or higher

- PostgreSQL 9.5.x or higher

## Navigate to the Rails application

```
$ cd /path/to/rails/application
```

## Software requirements

- Rails 6.0.0 or higher

- Ruby 2.6.3 or higher

- PostgreSQL 11.5.x or higher

## Navigate to the Rails application

```
$ cd /path/to/rails/application
```

Note:  You may need to edit the above files as necessary for your system.

## Create the database

 ```
 $ sudo service postgresql start  
 $ rails db:create
 ```

## Migrating and seeding the database

```
$ rake db:migrate
$ rake db:seed
```

## Starting the local server

```
$ rails server

   or

$ rails s
```

## Production Deployment

  ```
  $ git push heroku master
  $ heroku run rake db:migrate
  ```

## Support

Bug reports and feature requests can be filed here:

* [File Bug Reports and Features](https://github.com/jessicabrady16/Petagram/issues)

## License

Petagram is released under the [MIT license](https://mit-license.org).

## Copyright

copyright:: (c) Copyright 2020 Jessica Brady. All Rights Reserved.
