echo "*** environment loaded from ${BASH_SOURCE[0]} via ${BASH_SOURCE[1]}"

if [ -r /workspace/.env ]; then
  source /workspace/.env
else
  echo "You might want to `cp .env.example .env` and customize"
fi