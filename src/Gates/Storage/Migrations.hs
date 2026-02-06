module Gates.Storage.Migrations (migrations, runMigrations) where
import Database.Sqlite.Easy

runMigrations :: SQLite ()
runMigrations = migrate migrations migrateUp migrateDown 

migrations :: [MigrationName]
migrations = []


migrateUp :: MigrationName -> SQLite ()
migrateUp "add_devices" = void (run "CREATE TABLE devices ()")

migrateDown :: MigrationName -> SQLite ()
migrateDown "add_devices" = void (run "DROP TABLE devices")
