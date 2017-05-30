# Scheduler

Acts as the main background job, running every hour and dispatching the necessary notification message tasks to subscribers.

### Environment Variables

- `TWITTER_CONSUMER_KEY`
- `TWITTER_CONSUMER_SECRET`
- `TWITTER_ACCESS_TOKEN`
- `TWITTER_ACCESS_TOKEN_SECRET`

### Adding the environment variable for development mode

```bash

touch .env

vim .env

# edit file and add the environment variables described above

source .env
```
