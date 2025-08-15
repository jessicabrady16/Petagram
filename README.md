# Petagram

An app to showcase and share pictures of your pets with friends and family.  
Originally built as a learning project for Ruby on Rails — now polished to demonstrate a modern, efficient dev workflow.

Live (Heroku): [Petagram](https://dashboard.heroku.com/apps/pet-a-gram-your-pets-pic-place)

---

## 📦 Tech Stack

- **Rails** 6.x
- **Ruby** 3.3.9 (via rbenv)
- **PostgreSQL** 11.x or newer
- **Webpacker** for asset bundling (JS/CSS)

---

## ✨ Features

- User authentication and profiles
- Post photos of pets with captions
- Comment on and like pet posts
- Responsive layout for desktop and mobile
- Live asset reloading during development
- Easy one-command dev environment

---

## 🚀 Getting Started

### 1. Prerequisites

- Ruby ≥ 3.3.9 installed with [rbenv](https://github.com/rbenv/rbenv)
- PostgreSQL ≥ 11.x
- Node.js + Yarn or npm
- Foreman (`gem install foreman`)

### 2. Clone the repo

```bash
git clone https://github.com/jessicabrady16/Petagram.git
cd Petagram
```

### 3. Install dependencies

```bash
# Ruby gems
bundle install

# JS packages
yarn install   # or: npm install
```

### 4. Setup the database

```bash
rails db:create
rails db:migrate
rails db:seed
```

---

## 💻 Development

### The easy way (all-in-one dev stack)

This project includes a [`Procfile.dev`](./Procfile.dev) and [`bin/dev`](./bin/dev) script to launch **Rails** and **Webpack** together.

```bash
bin/dev
```

Or with Make:

```bash
make dev
```

**Under the hood:**  
- `web:` process runs Rails (`bin/rails server`)  
- `webpack:` process runs the Webpacker dev server (`bin/webpack-dev-server`)  
- Foreman handles both processes in one terminal with prefixed logs.

---

## 🛠 Dev Utilities

### [`bin/rbenv-clean.sh`](./bin/rbenv-clean.sh)
Removes old Ruby versions installed by rbenv to save disk space.

```bash
# Keep current global
bin/rbenv-clean.sh

# Preview without deleting
bin/rbenv-clean.sh --dry-run

# Keep a specific version
bin/rbenv-clean.sh --keep 3.3.9
```

### `bin/dev`
Convenience script for starting Rails and Webpack Dev Server together via Foreman.

```
bin/dev
```

### `Procfile.dev`
Used by Foreman to start development processes.

Example:
```
web: bin/rails server -p 3000
js: bin/webpack-dev-server
```

## 📜 Production Deployment

```bash
git push heroku master
heroku run rails db:migrate
```

---

## 🤝 Contributing

Contributions are welcome! Here’s how to get started:

1. Fork the repository.
2. Create a new feature branch:
   ```bash
   git checkout -b feature/my-feature
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add my feature"
   ```
4. Push to your fork:
   ```bash
   git push origin feature/my-feature
   ```
5. Open a Pull Request and describe your changes.

When contributing, please:
- Follow existing code style.
- Write descriptive commit messages.
- Test your changes locally before submitting.

---

## 🐞 Support

Bug reports and feature requests: [GitHub Issues](https://github.com/jessicabrady16/Petagram/issues)

---

## 📄 License

Released under the [MIT license](https://mit-license.org).

© 2020–2025 Jessica Brady. All Rights Reserved.

---

## 🖼 Architecture & Workflow

```text
+------------------+        +-----------------------+
|  Developer CLI   |        |   Foreman (Procfile)   |
|                  |        |  Runs processes in    |
|  make dev /       +------->  parallel with logs    |
|  bin/dev         |        |                       |
+------------------+        +-----------+-----------+
                                         |
                +------------------------+------------------------+
                |                                                 |
      +---------v---------+                             +---------v---------+
      | Rails Backend     |                             | Webpacker Dev     |
      | (bin/rails s)     |                             | Server            |
      | Serves HTML/JSON  |                             | Rebuilds JS/CSS   |
      +---------+---------+                             +---------+---------+
                |                                                 |
        +-------v-------+                                 +-------v-------+
        | PostgreSQL    |                                 | Browser       |
        | Data Storage  |                                 | Live-reloaded |
        +---------------+                                 +---------------+
```

**Flow:**  
1. You run `make dev` or `bin/dev`.  
2. Foreman starts **Rails** and **Webpacker** together.  
3. Rails serves backend requests, Webpacker rebuilds frontend assets in real time.  
4. PostgreSQL stores and retrieves your data.  
5. The browser auto-refreshes changes via Webpacker’s live-reload.
