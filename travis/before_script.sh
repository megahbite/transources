createdb -U postgres transources_test

psql -U postgres -d transources_test -c "CREATE EXTENSION postgis;"