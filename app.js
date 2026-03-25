const express = require("express");
const app = express();
const PORT = 3000;

app.get("/", (req, res) => {
  console.log("Here");
  res.sendStatus(500);
  res.send("Hi");
});

app.listen(PORT);
