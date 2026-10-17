-- Загрузка сырых данных 

CREATE SCHEMA IF NOT EXISTS iceberg.lakehouse; -- Создаем схему для наших таблиц

CREATE TABLE iceberg.lakehouse.bronze_part WITH ( -- Сырые данные о деталях
    format = 'PARQUET',
    compression_codec = 'ZSTD'
) AS
SELECT partkey, brand, type, size
FROM tpch.sf1.part;

CREATE TABLE iceberg.lakehouse.bronze_partsupp WITH ( -- Сырые данные о связях деталей и поставщиков
    format = 'PARQUET',
    compression_codec = 'ZSTD'
) AS
SELECT partkey, suppkey
FROM tpch.sf1.partsupp;

CREATE TABLE iceberg.lakehouse.bronze_supplier WITH ( -- Сырые данные о поставщиках 
    format = 'PARQUET',
    compression_codec = 'ZSTD'
) AS
SELECT suppkey, comment
FROM tpch.sf1.supplier;