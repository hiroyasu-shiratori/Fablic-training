```sql
CREATE TABLE todo.user (
    number INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    id VARCHAR(20),
    name VARCHAR(100),
    password VARCHAR(100),
    authority VARHCAR(10),
);
```

```sql
CREATE TABLE todo.task {
    number INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(100),
    deadline datetime,
    priority VARCHAR(10),
    status VARCHAR(10),
    date datetime,
};
```