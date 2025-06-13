# News Pipe

News Pipe is a multi-component application designed to scrape news headlines from various sources, publish them to Redis, and serve them to WebSocket clients. It consists of several services, including a scraper, a backend API, and a WebSocket server.

## Features

- **Scraper**: Collects headlines from sources like Hacker News, BBC, and TechCrunch, and publishes them to Redis.
- **Backend API**: Provides endpoints for additional functionality (e.g., weather forecasting).
- **WebSocket Server**: Streams real-time updates of headlines to connected clients.

## Project Structure

```
news-pipe/
├── backend/            # Backend API written in C#
├── scrapers/           # Ruby-based scraper service
├── websocket-server/    # Node.js WebSocket server
├── docker-compose.yml   # Docker Compose configuration
├── LICENSE              # MIT License
└── README.md            # Project documentation
```

## Getting Started

### Prerequisites

- Docker
- Docker Compose
- Redis

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/berksurmeli94/news-pipe.git
   cd news-pipe
   ```
