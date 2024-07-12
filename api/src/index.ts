import { Glob } from 'bun'

async function getRandomFile() {
  const glob = new Glob("**/*.ogg")
  const files = []

  for await (const file of glob.scan('/music')) {
    files.push(`/music/${file}`)
  }

  return files[Math.floor(Math.random() * files.length)]
}

const server = Bun.serve({
  port: 3000,
  async fetch (req) {
    const path = new URL(req.url).pathname;
    if (path === "/ns") return new Response(await getRandomFile())
    return new Response("Page not found", { status: 404 })
  }
})

console.log(`Listening on ${server.url}`)