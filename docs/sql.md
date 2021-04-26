```sql
CREATE TABLE todo.user (
    number INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    id VARCHAR(100),
    name TEXT,
    password VARCHAR(100),
    authority TEXT
);
```

```sql
CREATE TABLE todo.task {
    number INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name TEXT,
    deadline datetime,
    priority TEXT
    status TEXT,
    date datetime,
};
```