const express = require('express')
const path = require('path')

const app = express()

const port = process.env.PORT || 8080

app.set('view engine', 'pug')
app.use(express.static(__dirname + '/static'))

app.get("*", (req, res) => {
  res.render(path.resolve(__dirname, 'static', 'index.html'))
})


app.listen(port)
console.log("Server started")
