import convertController from "#src/controllers/convert-controller.js"
import express from "express"

const app = express()
const PORT = 3000

app.use(express.json())
app.use(express.static("public"))
app.use(convertController)

app.listen(PORT, () => console.log(`Server is running on PORT: ${PORT}`))
