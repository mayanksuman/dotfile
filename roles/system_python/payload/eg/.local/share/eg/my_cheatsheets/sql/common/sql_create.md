# CREATE statement in SQL

	create a table/view
- Crete a table
	CREATE TABLE {{table_name}} (
	   {{column1_name}} {{datatype}},
	   {{column2_name}} {{datatype}},
	   {{column3_name}} {{datatype}},
	   {{column4_name}} {{datatype}}
	);

- Create a view by selecting {{column1, column2}} from table with condition
	CREATE VIEW {{view_name}} AS SELECT {{column1, column2}} FROM {{table_name}} WHERE {{condition}};
