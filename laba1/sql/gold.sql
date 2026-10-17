-- Бизнес-витрина

CREATE TABLE iceberg.lakehouse.gold_supplier_count WITH (
    format = 'PARQUET',
    compression_codec = 'ZSTD'
) AS
SELECT 
    brand,
    type,
    size,
    count(DISTINCT suppkey) AS supplier_cnt
FROM iceberg.lakehouse.silver_parts_filtered
GROUP BY brand, type, size
ORDER BY supplier_cnt DESC, brand, type, size;