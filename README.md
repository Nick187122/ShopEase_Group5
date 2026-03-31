# ShopEase API

A simple REST API for managing products in a shop, built with Node.js, Express, and PostgreSQL.

## Features

- Product CRUD operations
- PostgreSQL database integration using `pg`
- JSON request/response handling
- Interactive API documentation via Swagger UI

## Tech Stack

- Node.js
- Express
- PostgreSQL
- Swagger UI (`swagger-ui-express` + `yamljs`)

## Project Structure

```
ShopEase/
|-- app.js
|-- package.json
|-- config/
|   `-- db.js
|-- controllers/
|   `-- productController.js
|-- routes/
|   `-- productRoutes.js
|-- swagger/
|   `-- swagger.yaml
```

## Prerequisites

- Node.js (v18+ recommended)
- PostgreSQL

## Installation

1. Install dependencies:

```bash
npm install
```

2. Create a `.env` file in the project root and add:

```env
DB_USER=your_db_user
DB_HOST=localhost
DB_NAME=your_db_name
DB_PASSWORD=your_db_password
DB_PORT=5432
```

3. Ensure your PostgreSQL database has a `products` table. Example:

```sql
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  price NUMERIC(10,2) NOT NULL,
  stock INTEGER NOT NULL
);
```

## Running the App

Start the app directly:

```bash
node app.js
```

The API runs on:

- `http://localhost:3000`

## Available Endpoints

Base path: `/api/products`

- `GET /api/products` - Get all products
- `GET /api/products/:id` - Get product by ID
- `POST /api/products` - Create a product
- `PUT /api/products/:id` - Update a product
- `DELETE /api/products/:id` - Delete a product

### Example Request Body (POST/PUT)

```json
{
  "name": "Wireless Mouse",
  "price": 29.99,
  "stock": 50
}
```

## API Documentation

Swagger UI is available at:

- `http://localhost:3000/api-docs`

## NPM Scripts

Current script in `package.json`:

- `npm run devStart` -> `nodemon server.js`

If your entry file is `app.js`, either run `node app.js` directly or update the script to target `app.js`.

## License

ISC
