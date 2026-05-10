import { upload } from "#src/config/multercfg.js"
import convertOrgToPdf from "#src/services/convert-service.js"
import express from "express"

const convertController = express.Router()

convertController.post("/convert", upload.single("file"), async (req, res) => {
  if (!req.file) {
    return res.status(400).json({ error: "No file uploaded" })
  }

  const result = await convertOrgToPdf(req.file)

  res.download(result)
})

export default convertController
