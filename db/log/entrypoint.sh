#!/bin/bash

# Start PostgreSQL server with the specified configuration
postgres -c config_file=/etc/postgresql/postgresql.conf &

# Wait for PostgreSQL to start
sleep 15

# Output the PostgreSQL log file
FILE=/var/lib/postgresql/data/pg_log/postgresql_logQueries.log
if [ -f $FILE ]; then
  echo "Log file found. Displaying contents:"
  cat $FILE
else
  echo "Log file doesn't exist."
fi

# Keep the container running
# This assumes that PostgreSQL has been started and will keep running
tail -f /var/lib/postgresql/data/pg_log/postgresql_logQueries.log


##!/bin/bash
#set -e
#
## Iniciar PostgreSQL con el archivo de configuración especificado en segundo plano
#postgres -c config_file=/etc/postgresql/postgresql.conf &
#
## Esperar a que PostgreSQL esté completamente operativo
#echo "Esperando a que PostgreSQL esté listo para aceptar conexiones..."
#until pg_isready -q -h localhost -p 5432; do
#  sleep 1
#done
#
## Ejecutar el script de inicialización
#echo "Ejecutando el script de creación de tablas..."
#psql -U $POSTGRES_USER -d $POSTGRES_DB -f /docker-entrypoint-initdb.d/tables_creation.sql
#
## Mantener el contenedor en ejecución
#echo "PostgreSQL está en funcionamiento."
#tail -f /var/lib/postgresql/data/pg_log/postgresql.log
