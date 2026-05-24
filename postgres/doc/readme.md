# Run docker services:
```
docker compose up -d
```

# Logs

```
docker logs -f varasto-postgres
```

# Backup

```
docker exec varasto-postgres pg_dumpall -c -U postgres > backup/backup.sql
```

# Restore

``` 
docker exec varasto-postgres psql -U postgres < backup/backup.sql
```

# Stop and remove db

```
docker compose down -v
```

```
Remove-Item -Recurse -Force .\postgres\data\*
```

