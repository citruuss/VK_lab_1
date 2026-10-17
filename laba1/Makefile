.PHONY: up down logs

up:
	@echo "Запускаем Lakehouse "
	docker-compose up -d
	@echo "Готово"

down:
	@echo "Останавливаем стек"
	docker-compose down

logs:
	docker-compose logs -f trino