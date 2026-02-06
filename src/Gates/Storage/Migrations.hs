module Gates.Storage.Migrations (migrations, runMigrations) where
import Database.Sqlite.Easy

runMigrations :: SQLite ()
runMigrations = migrate migrations migrateUp migrateDown 

migrations :: [MigrationName]
migrations = []


migrateUp :: MigrationName -> SQLite ()
migrateUp "add_devices" = void (run "CREATE TABLE IF NOT EXISTS  devices (user_id TEXT, device_id TEXT, platform TEXT,  PRIMARY KEY (user_id, device_id))")
migrateUp "add_tasks" = void (run "CREATE TABLE IF NOT EXISTS  tasks ( \
  \ id INTEGER PRIMARY KEY AUTOINCREMENT,  -- или просто INTEGER PRIMARY KEY \
 \ device_id TEXT NOT NULL, \
  \ title TEXT NOT NULL, \
  \ body TEXT NOT NULL)")

migrateDown :: MigrationName -> SQLite ()
migrateDown "add_devices" = void (run "DROP TABLE IF EXISTS  devices")
migrateDown "add_tasks" = void (run "DROP TABLE IF  EXISTS tasks")
  
