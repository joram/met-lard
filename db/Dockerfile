FROM postgres:latest

# Copy SQL initialization files
COPY db/*.sql /docker-entrypoint-initdb.d/

# Override entrypoint to ensure SQL files run even if database exists
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres"]

