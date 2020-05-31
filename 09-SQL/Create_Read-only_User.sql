--- PostgreSQL - How to create a read-only user?
--- https://tableplus.com/blog/2018/04/postgresql-how-to-create-read-only-user.html


---1. To create a new user in PostgreSQL:
CREATE USER readonly WITH PASSWORD 'smu_homework';

---2. GRANT the CONNECT access:
GRANT CONNECT ON DATABASE postgres TO readonly;

---3. Then GRANT USAGE on schema:
GRANT USAGE ON SCHEMA public TO readonly;

---4. GRANT SELECT
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;
