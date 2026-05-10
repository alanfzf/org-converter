import { execa } from "execa"

async function convertOrgToPdf(file: Express.Multer.File): Promise<string> {
  const input = file.path
  const output = `${input}.pdf`

  await execa("pandoc", [input, "-o", output, "--pdf-engine=xelatex"], {
    timeout: 30_000,
  })

  return output
}

export default convertOrgToPdf
