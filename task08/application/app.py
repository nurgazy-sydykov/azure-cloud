import os
from flask import Flask
import redis

app = Flask(__name__)

creator = os.getenv("CREATOR", "Unknown")
redis_host = os.getenv("REDIS_URL")
redis_pwd = os.getenv("REDIS_PWD")
redis_port = int(os.getenv("REDIS_PORT", "6380"))
redis_ssl = os.getenv("REDIS_SSL_MODE", "True") == "True"

r = redis.Redis(
    host=redis_host,
    port=redis_port,
    password=redis_pwd,
    ssl=redis_ssl,
    ssl_cert_reqs=None,
)

@app.route("/")
def index():
    try:
        r.incr("visits")
        visits = int(r.get("visits") or 0)
    except Exception:
        visits = -1

    if creator == "ACI":
        greeting = "Hello from ACI"
    elif creator == "K8S":
        greeting = "Hello from K8S"
    else:
        greeting = "Hello from App"

    return f"{greeting}. Visits: {visits}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.getenv("PORT", "80")))
