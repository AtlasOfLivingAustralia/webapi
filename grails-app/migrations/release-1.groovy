databaseChangeLog = {

	changeSet(author: "bea18c (generated)", id: "1398233629877-1") {
		createTable(schemaName: "webapi", tableName: "app") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "base_url", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "LONGTEXT") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "name", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "short_description", type: "VARCHAR(200)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "bea18c (generated)", id: "1398233629877-2") {
		createTable(schemaName: "webapi", tableName: "category") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "LONGTEXT") {
				constraints(nullable: "false")
			}

			column(name: "name", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "short_description", type: "VARCHAR(200)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "bea18c (generated)", id: "1398233629877-3") {
		createTable(schemaName: "webapi", tableName: "example") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "LONGTEXT") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "name", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "online_viewer", type: "VARCHAR(255)")

			column(name: "url_path", type: "LONGTEXT")

			column(name: "web_service_id", type: "BIGINT") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "bea18c (generated)", id: "1398233629877-4") {
		createTable(schemaName: "webapi", tableName: "example_param") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "example_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "param_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "value", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "bea18c (generated)", id: "1398233629877-5") {
		createTable(schemaName: "webapi", tableName: "format") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "name", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "bea18c (generated)", id: "1398233629877-6") {
		createTable(schemaName: "webapi", tableName: "param") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "deprecated", type: "BIT") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "LONGTEXT")

			column(name: "format", type: "VARCHAR(255)")

			column(name: "include_in_title", type: "BIT") {
				constraints(nullable: "false")
			}

			column(name: "last_updated", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "mandatory", type: "BIT") {
				constraints(nullable: "false")
			}

			column(name: "name", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "restful_param", type: "BIT") {
				constraints(nullable: "false")
			}

			column(name: "type", type: "VARCHAR(7)") {
				constraints(nullable: "false")
			}

			column(name: "web_service_id", type: "BIGINT") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "bea18c (generated)", id: "1398233629877-7") {
		createTable(schemaName: "webapi", tableName: "web_service") {
			column(autoIncrement: "true", name: "id", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true")
			}

			column(name: "version", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "app_id", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "date_created", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "deprecated", type: "BIT") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "LONGTEXT") {
				constraints(nullable: "false")
			}

			column(name: "example_output", type: "LONGTEXT") {
				constraints(nullable: "true")
			}

			column(name: "last_updated", type: "DATETIME") {
				constraints(nullable: "false")
			}

			column(name: "name", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "url", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "bea18c (generated)", id: "1398233629877-8") {
		createTable(schemaName: "webapi", tableName: "web_service_category") {
			column(name: "web_service_categories_id", type: "BIGINT")

			column(name: "category_id", type: "BIGINT")
		}
	}

	changeSet(author: "bea18c (generated)", id: "1398233629877-9") {
		createTable(schemaName: "webapi", tableName: "web_service_http_method") {
			column(name: "web_service_id", type: "BIGINT")

			column(name: "http_method_string", type: "VARCHAR(255)")
		}
	}

	changeSet(author: "bea18c (generated)", id: "1398233629877-10") {
		createTable(schemaName: "webapi", tableName: "web_service_output_format") {
			column(name: "web_service_id", type: "BIGINT")

			column(name: "output_format_string", type: "VARCHAR(255)")
		}
	}

	changeSet(author: "bea18c (generated)", id: "1398233629877-11") {
		addForeignKeyConstraint(baseColumnNames: "web_service_id", baseTableName: "example", baseTableSchemaName: "webapi", constraintName: "FKB125116AD4413B1D", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "web_service", referencedTableSchemaName: "webapi", referencesUniqueColumn: "false")
	}

	changeSet(author: "bea18c (generated)", id: "1398233629877-12") {
		addForeignKeyConstraint(baseColumnNames: "example_id", baseTableName: "example_param", baseTableSchemaName: "webapi", constraintName: "FK5B1D55783B84934E", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "example", referencedTableSchemaName: "webapi", referencesUniqueColumn: "false")
	}

	changeSet(author: "bea18c (generated)", id: "1398233629877-13") {
		addForeignKeyConstraint(baseColumnNames: "param_id", baseTableName: "example_param", baseTableSchemaName: "webapi", constraintName: "FK5B1D55788C5816E", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "param", referencedTableSchemaName: "webapi", referencesUniqueColumn: "false")
	}

	changeSet(author: "bea18c (generated)", id: "1398233629877-14") {
		addForeignKeyConstraint(baseColumnNames: "web_service_id", baseTableName: "param", baseTableSchemaName: "webapi", constraintName: "FK658188DD4413B1D", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "web_service", referencedTableSchemaName: "webapi", referencesUniqueColumn: "false")
	}

	changeSet(author: "bea18c (generated)", id: "1398233629877-15") {
		addForeignKeyConstraint(baseColumnNames: "app_id", baseTableName: "web_service", baseTableSchemaName: "webapi", constraintName: "FK5C4EA4CAD2B8CDEE", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "app", referencedTableSchemaName: "webapi", referencesUniqueColumn: "false")
	}

	changeSet(author: "bea18c (generated)", id: "1398233629877-16") {
		addForeignKeyConstraint(baseColumnNames: "category_id", baseTableName: "web_service_category", baseTableSchemaName: "webapi", constraintName: "FK72450CD3940511A6", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "category", referencedTableSchemaName: "webapi", referencesUniqueColumn: "false")
	}

	changeSet(author: "bea18c (generated)", id: "1398233629877-17") {
		addForeignKeyConstraint(baseColumnNames: "web_service_categories_id", baseTableName: "web_service_category", baseTableSchemaName: "webapi", constraintName: "FK72450CD3EDED8DD6", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "web_service", referencedTableSchemaName: "webapi", referencesUniqueColumn: "false")
	}

	changeSet(author: "bea18c (generated)", id: "1398233629877-18") {
		addForeignKeyConstraint(baseColumnNames: "web_service_id", baseTableName: "web_service_http_method", baseTableSchemaName: "webapi", constraintName: "FK86B3C083D4413B1D", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "web_service", referencedTableSchemaName: "webapi", referencesUniqueColumn: "false")
	}

	changeSet(author: "bea18c (generated)", id: "1398233629877-19") {
		addForeignKeyConstraint(baseColumnNames: "web_service_id", baseTableName: "web_service_output_format", baseTableSchemaName: "webapi", constraintName: "FK76313640D4413B1D", deferrable: "false", initiallyDeferred: "false", onDelete: "NO ACTION", onUpdate: "NO ACTION", referencedColumnNames: "id", referencedTableName: "web_service", referencedTableSchemaName: "webapi", referencesUniqueColumn: "false")
	}
}
