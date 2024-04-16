# Lunch and Learn

## Introduction

Lunch and Learn is an educational API that provides recipes, historical videos, and other fun and useful information about various countries. It also features user CRUD functionality, the ability to favorite resources by user, and session CRUD and authentication functionality.

## Installing Lunch and Learn API

To use the Lunch and Learn API, you will need the following:

- Ruby Version 3.x.x or higher
- A terminal application, such as Terminal (MacOS) or [Windows Terminal](https://learn.microsoft.com/en-us/windows/terminal/) (Windows)

Once these prerequisites are in place, please complete the following steps:

1. Clone down the `lunch_and_learn_be` repository to your local machine, using the green Code button.
2. Navigate to the `lunch_and_learn_be` repository with your Terminal application.
3. From the terminal application, run the command `bundle install`
4. In the same terminal session, run `rails db:{drop,create,migrate}`
5. In the same terminal session, run `rails server`

Congratulations! The Lunch and Learn API is now running on your local server, and is ready for use.

## Using Lunch and Learn API

The Lunch and Learn API exposes the following endpoints for user consumption:

- [User Endpoints](#user-endpoints)
  - [POST Create User](#post-users---create-user)
- [Favorite Endpoints](#favorite-endpoints)
  - [GET All Favorites for User](#get-favorites---all-favorites)
  - [POST Create Favorite for User](#post-favorites---create-favorite)
- [Recipe Endpoints](#recipe-endpoints)
  - [GET All Recipes for Country](#get-recipes---all-recipes)
- [Learning Resource Endpoints](#learning-resource-endpoints)
  - [GET All Learning Resources for Country](#get-learning-resources---all-learning-resources)
- [Session Endpoints](#session-endpoints)
  - [POST Create Session for User](#post-sessions---create-session)
 
### User Endpoints

#### ```POST /users``` — Create User
<details>
=  <summary>Expand</summary>

  Creates a new user within the database, and returns a JSON response indicating either successful user creation, or unsuccessful user creation with errors.

  Example Request:
```
POST localhost:3000/api/v1/users
```

Exmaple JSON Response:
```
{
    "success": "User created successfully!"
}
```
</details>

### Favorite Endpoints

#### ```POST /favorites``` — Create User
<details>
=  <summary>Expand</summary>

  Creates a new user favorite for a user, and returns a JSON response indicating either successful user creation, or unsuccessful user creation with errors.

  Example Request:
```
POST localhost:3000/api/v1/users
```

Exmaple JSON Response:
```
{
    "success": "User created successfully!"
}
```
</details>
