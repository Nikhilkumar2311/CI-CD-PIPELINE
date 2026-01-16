const http = require("http");

const PORT = process.env.PORT || 3000;

const server = http.createServer((req, res) => {
  if (req.url === "/health") {
    res.writeHead(200);
    res.end("OK");
  } else {
    res.writeHead(200);
    res.end("CI/CD Pipeline App Running");
  }
});

server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
