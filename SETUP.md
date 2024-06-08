# URL Shortener

## Setup

1. Install dependencies:
   ```sh
   bundle install
   ```

2. Setup database:
   ```sh
   rails db:create db:migrate
   ```

3. Run the server:
   ```sh
   rails s
   ```

## Running tests
   ```sh
   rspec
   ```

## Encode Endpoint API

**URL**: `POST /encode`

**Request Body**
```json5
{
  "url": "https://codesubmit.io/library/react"
}
```

### Success Response

**Code** : `200 OK`

**Content example**

```json5
{
  "url": "https://codesubmit.io/library/react",
  "short_url": "https://short.est/GeAi9K"
}
```

## Decode Endpoint API

**URL**: `POST /decode`

**Request Body**
```json5
{
  "short_url": "https://short.est/GeAi9K"
}
```

### Success Response

**Code** : `200 OK`

**Content example**

```json5
{
  "url": "https://codesubmit.io/library/react",
  "short_url": "https://short.est/GeAi9K"
}
```
