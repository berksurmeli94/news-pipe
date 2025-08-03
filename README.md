# News Pipe

**News Pipe** is a multi-component application designed to scrape news headlines, store them, and stream them in real time. It utilizes Redis for data passing and includes metadata enrichment powered by ChatGPT.

## ✨ Features

- **Worker: Scraper**  
  Collects headlines from sources like Hacker News and TechCrunch and stores them in the database.

- **Worker: Metadata Generator**  
  Enriches each headline with metadata such as topics, summary, sentiment, and keywords using OpenAI’s GPT model.

- **Backend API**  
  A C#-based API for exposing REST endpoints for functionality like search, filters, and historical queries.

- **WebSocket Server**  
  A Node.js service that streams real-time headlines to connected clients via WebSocket, powered by Redis pub/sub.

## 📁 Project Structure

```
news-pipe/
├── backend/              # Backend API written in C#
├── worker-scraper/       # Ruby-based scraper to fetch news
├── worker-metadata/      # Ruby-based metadata generator using OpenAI
├── websocket-server/     # Node.js WebSocket server
├── docker-compose.yml    # Docker Compose configuration
├── LICENSE               # MIT License
└── README.md             # Project documentation
```

### Prerequisites

- Docker
- Docker Compose
- Redis
- PostgreSQL (used by backend and workers)

### Installation

1. Clone the repository:

   ```sh
   git clone https://github.com/berksurmeli94/news-pipe.git
   cd news-pipe

   ```

2. Start all services:
   docker-compose up --build

## 📁 Architecture Overview

       +------------------+
       |  News Websites   |
       +--------+---------+
                |
                v
       +------------------+
       | Scraper Worker   |  (Ruby)
       +--------+---------+
                |
         Saves to DB
                |
                v
       +--------------------------+
       | Metadata Worker (Ruby)  |
       |  + OpenAI Integration   |
       +-----------+-------------+
                   |
          Publishes to Redis
                   |
                   v
        +----------------------+
        | WebSocket Server     | (Node.js)
        +----------------------+
                   ^
                   |
            Client UI (TBD)
