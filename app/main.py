from flask import Flask, jsonify
from app.db import get_connection

app = Flask(__name__)


@app.route("/")
def hello_world():
    return {"message": "Hello, World! - Melior DevSecOps Internship"}


@app.route("/db-test")
def db_test():
    try:
        conn = get_connection()
        row = conn.execute(
            "SELECT DB_NAME() AS database_name, SUSER_SNAME() AS login_name"
        ).fetchone()
        conn.close()

        return jsonify({
            "status": "connected",
            "database": row.database_name,
            "user": row.login_name
        })

    except Exception as e:
        return jsonify({
            "status": "error",
            "message": str(e)
        }), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
