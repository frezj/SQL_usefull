DECLARE @schemaName NVARCHAR(128) = 'schema'; 
DECLARE @tableName NVARCHAR(128) = 'table';

IF EXISTS (SELECT * FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE t.name = @tableName AND s.name = @schemaName)
BEGIN
    DECLARE @createTableScript NVARCHAR(MAX) = 'CREATE TABLE ' + QUOTENAME(@schemaName) + '.' + QUOTENAME(@tableName) + ' (' + CHAR(13);

    SELECT @createTableScript = @createTableScript + 
        '    [' + c.name + '] ' + 
        TYPE_NAME(c.system_type_id) + 
        CASE
            WHEN TYPE_NAME(c.system_type_id) IN ('nvarchar', 'nchar', 'varchar', 'char') THEN '(' + CASE WHEN c.max_length = -1 THEN 'MAX' ELSE CAST(c.max_length AS NVARCHAR(10)) END + ')'
            WHEN TYPE_NAME(c.system_type_id) IN ('decimal', 'numeric') THEN '(' + CAST(c.precision AS NVARCHAR(5)) + ',' + CAST(c.scale AS NVARCHAR(5)) + ')'
            ELSE ''
        END +
        CASE 
            WHEN c.is_nullable = 1 THEN ' NULL'
            ELSE ' NOT NULL'
        END + ',' + CHAR(13)
    FROM sys.columns c
    INNER JOIN sys.tables t ON c.object_id = t.object_id
    INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE t.name = @tableName AND s.name = @schemaName
    ORDER BY c.column_id;

    SET @createTableScript = LEFT(@createTableScript, LEN(@createTableScript) - 2) + CHAR(13); -- Remove trailing comma
    SET @createTableScript = @createTableScript + ');';

    PRINT @createTableScript;
END
ELSE
BEGIN
    PRINT N'Таблица ' + QUOTENAME(@schemaName) + '.' + QUOTENAME(@tableName) + N' не существует.';
END
