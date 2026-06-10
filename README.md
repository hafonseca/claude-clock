# Claude Clock

A lightweight cron-based utility that sends scheduled prompts to Claude and stores responses in local log files.

Useful for:
- Availability monitoring
- Daily check-ins
- Session warm-up
- Prompt benchmarking
- Personal workflow automation

## Schedule

| Time | Message |
|--------|----------|
| 04:58 | Good morning! |
| 09:59 | Hello! |
| 15:00 | Good afternoon! |

## Setup

Clone repository:

```bash
git clone <repo>
cd claude-clock
```

Create environment file:

```bash
cp .env.example .env
```

Edit:

```bash
vim .env
```

Insert your Anthropic API key.

Make script executable:

```bash
chmod +x scripts/send_message.sh
```

Install cron jobs:

```bash
crontab cron/claude-clock.cron
```

## Test manually

```bash
./scripts/send_message.sh "Test message"
```

## Logs

Logs are stored in:

```text
logs/YYYY-MM-DD.log
```

Example:

```bash
tail -f logs/$(date +%F).log
```
