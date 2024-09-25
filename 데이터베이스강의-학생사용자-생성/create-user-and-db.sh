#!/usr/bin/zsh

# CSV 파일 경로
CSV_FILE="user-info.csv"

# PostgreSQL 접속 정보
PGUSER="권한있는사용자"
PGDB="데이터베이스이름"
PGHOST="서버"
PGPORT="포트"

USERPW="통일된 학생들 비밀번호"

export PGPASSFILE="/home/postgres/.pgpass"

while IFS=',' read -r username dbname; do
    echo "Creating user: $username and database: $dbname"

    psql -U "$PGUSER" -d "$PGDB" -h "$PGHOST" -p "$PGPORT" <<END
    CREATE USER "$username" WITH PASSWORD '$USERPW';
    CREATE DATABASE "$dbname" OWNER "$username";
    GRANT CREATE ON DATABASE "$dbname" TO "$username";
END


done < "$CSV_FILE"

echo "done"