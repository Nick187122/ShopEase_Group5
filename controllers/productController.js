const pool = require("../config/db");

// Get all products
exports.getProducts = async (req, res) => {
  const result = await pool.query("SELECT * FROM products");
  res.json(result.rows);
};

// Get one product
exports.getProductById = async (req, res) => {
  const { id } = req.params;
  const result = await pool.query("SELECT * FROM products WHERE id=$1", [id]);
  res.json(result.rows[0]);
};

// Create product
exports.createProduct = async (req, res) => {
  const { name, price, stock } = req.body;
  const result = await pool.query(
    "INSERT INTO products(name, price, stock) VALUES($1,$2,$3) RETURNING *",
    [name, price, stock],
  );
  res.json(result.rows[0]);
};

// Update product
exports.updateProduct = async (req, res) => {
  const { id } = req.params;
  const { name, price, stock } = req.body;

  const result = await pool.query(
    "UPDATE products SET name=$1, price=$2, stock=$3 WHERE id=$4 RETURNING *",
    [name, price, stock, id],
  );

  res.json(result.rows[0]);
};

// Delete product
exports.deleteProduct = async (req, res) => {
  const { id } = req.params;
  await pool.query("DELETE FROM products WHERE id=$1", [id]);
  res.send("Product deleted");
};
