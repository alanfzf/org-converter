import convertController from "#src/controllers/convert-controller.js"
import express from "express"

const app = express()
const PORT = process.env.PORT || 3000

app.use(express.json())
app.use(convertController)

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`)
})
