```sql
CREATE TABLE todo.User (
  id BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user_id VARCHAR(20) NOT NULL,
  name VARCHAR(100) NOT NULL,
  password_digest VARCHAR(255) NOT NULL,
  authority VARCHAR(20) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,
);
```

```sql
CREATE TABLE todo.Task {
  id BIGINT(20) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user_id VARCHAR(20) NOT NULL,
  title VARCHAR(100) NOT NULL,
  description VARCHAR(1000),
  status VARCHAR(10),
  priority VARCHAR(10),
  dead_line DATETIME,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,
};
```