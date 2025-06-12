const WebSocket = require("ws");
const Redis = require("ioredis");

const wss = new WebSocket.Server({ port: 8080 });

const redisSubscriber = new Redis(process.env.REDIS_URL);

redisSubscriber.on("error", (err) => {
  console.error("Redis subscriber error:", err);
});

redisSubscriber.on("close", () => {
  console.warn("Redis subscriber connection closed.");
});

redisSubscriber.on("reconnecting", () => {
  console.info("Redis subscriber reconnecting...");
});

redisSubscriber.subscribe("headlines_channel", (err, count) => {
  if (err) {
    console.error("Failed to subscribe to Redis channel:", err);
  } else {
    console.log(`📡 Subscribed to ${count} channel(s).`);
  }
});

redisSubscriber.on("message", (_channel, message) => {
  console.log("🧨 New message:", message);
  wss.clients.forEach((client) => {
    if (client.readyState === WebSocket.OPEN) {
      try {
        client.send(message);
      } catch (err) {
        console.error("Failed to send message to client:", err);
      }
    }
  });
});

wss.on("connection", (ws) => {
  console.log("🔌 Client connected");

  ws.on("error", (err) => {
    console.error("WebSocket client error:", err);
  });

  ws.on("close", (code, reason) => {
    console.log(
      `WebSocket client disconnected. Code: ${code}, Reason: ${reason}`
    );
  });
});

process.on("uncaughtException", (err) => {
  console.error("Uncaught Exception:", err);
});

process.on("unhandledRejection", (reason, promise) => {
  console.error("Unhandled Rejection at:", promise, "reason:", reason);
});

console.log("WebSocket server running on ws://localhost:8080");
