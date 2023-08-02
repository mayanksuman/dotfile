# ALTER statement in SQL

	Altering/Modifying Table Queries

- Add a column with name {{column_name}} and data type {{datatype}}
	ALTER TABLE {{table_name}} ADD {{column_name datatype}};

- Change data type of existing column to {{new_datatype}}
	ALTER TABLE {{table_name}} MODIFY {{column_name new_datatype}};

- Delete a column
	ALTER TABLE {{table_name}} DROP COLUMN {{column_name}};
