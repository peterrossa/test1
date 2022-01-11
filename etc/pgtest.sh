#!/bin/bash

KEYS=$(seq 1 1 4)

for ITEM in ${KEYS[@]}; do
	# echo $ITEM
	docker exec "pg${ITEM}" bash -c "psql -h localhost -U postgres -c \"\du\""
	echo "---------------------------- 1"
	docker exec "pg${ITEM}" bash -c "psql -h localhost -U 'user${ITEM}' postgres -c \"\l\""
	echo "---------------------------- 2"
	docker exec "pg${ITEM}" bash -c "psql -h localhost -U 'reader' postgres -c \"\l\""
	echo "---------------------------- 3"
done
