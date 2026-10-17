-- Очистка, фильтрация и джойны

CREATE TABLE iceberg.lakehouse.silver_bad_suppliers WITH ( -- Выделяем плохих поставщиков в отдельную таблицу 
    format = 'PARQUET',
    compression_codec = 'ZSTD'
) AS
SELECT DISTINCT suppkey
FROM iceberg.lakehouse.bronze_supplier
WHERE comment LIKE '%Customer%Complaints%';


CREATE TABLE iceberg.lakehouse.silver_parts_filtered WITH ( -- Основная очищенная таблица: джойним детали и поставки, применяем бизнес-фильтры
    format = 'PARQUET',
    compression_codec = 'ZSTD'
) AS
SELECT 
    p.partkey,
    p.brand,
    p.type,
    p.size,
    ps.suppkey
FROM iceberg.lakehouse.bronze_part p
JOIN iceberg.lakehouse.bronze_partsupp ps ON p.partkey = ps.partkey
WHERE p.brand <> 'Brand#45'
  AND p.type NOT LIKE 'MEDIUM POLISHED%'
  AND p.size IN (49, 14, 23, 45, 19, 3, 36, 9)
  AND ps.suppkey NOT IN (SELECT suppkey FROM iceberg.lakehouse.silver_bad_suppliers);