module Gates.Storage.Migrations (migrations, runMigrations) where
import Database.Sqlite.Easy

runMigrations :: SQLite ()
runMigrations = migrate migrations migrateUp migrateDown 

migrations :: [MigrationName]
migrations = ["add_devices", "add_tasks", "add_data"]


migrateUp :: MigrationName -> SQLite ()
migrateUp "add_devices" = void (run "CREATE TABLE IF NOT EXISTS  devices (user_id TEXT, device_id TEXT, platform TEXT,  PRIMARY KEY (user_id, device_id))")
migrateUp "add_tasks" = void (run "CREATE TABLE IF NOT EXISTS  tasks ( \
  \ id INTEGER PRIMARY KEY AUTOINCREMENT,  \
 \ device_id TEXT NOT NULL, \
  \ title TEXT NOT NULL, \
  \ body TEXT NOT NULL)")
migrateUp "add_data" = void (run "ALTER TABLE tasks ADD COLUMN data BLOB")

migrateDown :: MigrationName -> SQLite ()
migrateDown "add_devices" = void (run "DROP TABLE IF EXISTS  devices")
migrateDown "add_tasks" = void (run "DROP TABLE IF  EXISTS tasks")
migrateDown "add_data" = void (run "ALTER TABLE tasks DROP COLUMN data")
  
