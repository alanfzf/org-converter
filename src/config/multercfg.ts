import multer from "multer"
import crypto from "crypto"

const storage = multer.diskStorage({
  destination: "uploads/",
  filename: (_req, file, cb) => {
    const uuid = crypto.randomUUID()
    cb(null, `${uuid}-${file.originalname}`)
  },
})

const upload = multer({ storage })

const tempUpload = multer({ storage: multer.memoryStorage() })

export { upload, tempUpload }
