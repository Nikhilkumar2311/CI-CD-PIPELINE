const http = require("http");
const client = require("prom-client");

const PORT = process.env.PORT || 3000;

// Prometheus setup
const register = new client.Registry();

// Collect default Node.js metrics
client.collectDefaultMetrics({ register });

// custom metric: total HTTP requests
const httpRequestCounter = new client.Counter({
  name: "http_requests_total",
  help: "Total number of HTTP requests",
  labelNames: ["method", "route", "status"],
});

register.registerMetric(httpRequestCounter);

// HTTP SERVER

const server = http.createServer(async(req, res) => {
  if (req.url === "/health") {
    res.writeHead(200);
    res.end("OK");
  } else if (req.url === "/metrics") {
    res.writeHead(200, { "Content-Type": register.contentType });
    const metrics = await register.metrics();
    res.end(metrics);
  } else {
    res.writeHead(200);
    res.end("CI/CD Pipeline App Running");
  }


  // Increment metric After response
  httpRequestCounter.inc({
    method: req.method,
    route: req.url,
    status: 200,
  });
});

server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
