#!/bin/bash

cd ./terraform

# rm null_resource from TF state (`count` will prevent it from running redundantly)
for ITEM in $(terraform state list | grep null_resource); do
	# echo $ITEM
	terraform state rm $ITEM
done

# rm PG DB resources from TF state that might have been deleted/commented in `docker-compose.yml`
for ITEM in $(terraform state list | grep "postgresql_database" | sed -e 's/^[^\.]*\.//' -e 's/\..*$//'); do
	# echo $ITEM
	if [[ $(cat db_gen.tf | grep "module \"${ITEM}\"" | wc -l) == 0 ]]; then
		RES=$(terraform state list | grep "postgresql_database" | grep $ITEM)
		terraform state rm $RES
	fi
done
