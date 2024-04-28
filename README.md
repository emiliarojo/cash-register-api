# Cash Register API
## Overview
This backend API is designed to simulate a cash register system, capable of handling items in a shopping basket and applying discounts during the checkout process. It is tailored to interact seamlessly with a frontend application, managing baskets via session-based storage with Redis, and ensuring real-time updates on item adjustments.

## Features
- **Session Management**: Utilizes Redis to create and manage sessions, associating baskets with unique session IDs.
- **Product Management**: Allows adding, updating, and removing specific products (Green Tea 🍵, Strawberries 🍓, and Coffee ☕️) from a basket.
- **Dynamic Discounts**: Supports Buy-One-Get-One (BOGO) and bulk purchase discounts, dynamically applied during checkout based on defined rules.
- **Real-Time Updates**: Ensures that each modification to the basket is immediately reflected, providing up-to-date basket contents and totals.
- **Checkout Process**: Processes checkout operations, returning an itemized receipt with applied discounts and the final total.

## Technologies Used
- **Rails**: Framework used to build the API.
- **PostgreSQL**: Database system for persistent storage.
- **Redis**: Used for session management and storing temporary basket data.
- **RSpec**: Used for testing to ensure reliability and correctness of the API functionalities.

## Getting Started

### Prerequisites
- Ruby (version specified in .ruby-version)
- Rails
- PostgreSQL
- Redis server

### Installation
1. Clone the repository and navigate into directory:

  ```
    git clone https://github.com/emiliarojo/cash-register-api.git

    cd cash_register_api
  ```

2. Bundle install to install dependencies:

  ```
    bundle install
  ```

3. Setup the database:

  ```
    rails db:create db:migrate
  ```

4. Start the Redis server (ensure it's running on default port 6379);

  ```
    redis-serve
  ```

5. Start the Rails server:

  ```
    rails s
  ```

### Usage
**Creating a Basket**
- *POST /baskets*
  - Creates a new basket associated with a session ID, returning the basket ID.

**Adding Items to the Basket**
- *POST /baskets/:basket_id/basket_items*
  - Adds new items to the specified basket. Only specific products (Green Tea, Strawberries, and Coffee) can be added.

**Updating Basket Items**
- *PUT /baskets/:basket_id/basket_items/:id*
  -Updates the quantity of an existing item in the basket.

**Deleting Basket Items**
- *DELETE /baskets/:basket_id/basket_items/:id*
  - Removes an item from the basket.

**Checkout**
- *POST /baskets/:basket_id/checkout*
  - Finalizes the basket, applies any eligible discounts, and returns an itemized receipt with the total amount.

### Testing
Run the RSpec tests to ensure everything is working as expected:

  ```
    bundle exec rspec
  ```
