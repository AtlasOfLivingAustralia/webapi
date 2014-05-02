databaseChangeLog = {

	changeSet(author: "bea18c (generated)", id: "1398234389792-1") {
		createTable(tableName: "example_run") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "example_runPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "end", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "example_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "start", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "url", type: "longtext") {
				constraints(nullable: "false")
			}

			column(name: "class", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "exception_class", type: "varchar(255)")

			column(name: "message", type: "longtext")

			column(name: "body", type: "mediumblob")

			column(name: "content_type", type: "varchar(255)")

			column(name: "response_code", type: "integer")
		}
	}

	changeSet(author: "bea18c (generated)", id: "1398234389792-2") {
		addColumn(tableName: "example") {
			column(name: "machine_callable", type: "bit", defaultValueBoolean="true") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "bea18c (generated)", id: "1398234389792-4") {
		createIndex(indexName: "FK8C3736363B84934E", tableName: "example_run") {
			column(name: "example_id")
		}
	}

    changeSet(author: "bea18c", id: "1398234389792-5") {
        createIndex(indexName: "EXAMPLE_RUN_START_INDEX", tableName: "example_run") {
            column(name: "start")
        }
    }

	changeSet(author: "bea18c (generated)", id: "1398234389792-3") {
		addForeignKeyConstraint(baseColumnNames: "example_id", baseTableName: "example_run", constraintName: "FK8C3736363B84934E", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "example", referencesUniqueColumn: "false")
	}
}
