FROM python:3.11-slim
WORKDIR /app
# Install ODBC dependencies for pyodbc + Microsoft SQL Server
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl gnupg2 unixodbc unixodbc-dev && \
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg && \
    curl https://packages.microsoft.com/config/debian/12/prod.list -o /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql18 && \
    rm -rf /var/lib/apt/lists/*
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip "setuptools>=78.1.1" "jaraco.context>=6.1.0" "wheel>=0.46.2" "msgpack>=1.2.1" && pip install --no-cache-dir -r requirements.txt
COPY app/ ./app/
EXPOSE 8000
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app.main:app"]
