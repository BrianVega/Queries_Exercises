# Queries_Exercises

## Project Overview
This project is a Docker-based setup that utilizes PostgreSQL to manage a database schema related to geographical and demographic data. The database consists of tables for continents, countries, people, and their relationships, including citizenship. The setup is designed to demonstrate various SQL queries and their results based on the provided schema and data.

### Docker Setup 
The Docker setup uses the `postgres:latest` image to create a PostgreSQL container. Below is a breakdown of the Docker configuration:

```bash
services:
  database:
    image: postgres:latest
    container_name: generic_task
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: generic
    ports:
      - 5432:5432
    volumes:
      - db_data:/var/lib/postgresql/data
      - ./db:/docker-entrypoint-initdb.d
volumes:
  db_data:
```
#### Image: postgres:latest
- This is the PostgreSQL database image.
#### Container Name: generic_task 
- The name of the PostgreSQL container.
#### Environment Variables:
- **POSTGRES_USER:** user 
- **POSTGRES_PASSWORD:** password 
- **POSTGRES_DB:** generic
#### Ports ####
Maps the container's port 5432 to the host's port 5432.
#### Volumes ####
  - **db_data:** Persistent storage for database data.
  - **./db:** Directory containing SQL initialization scripts.  
  

### SQL Schema and Data

The `/db` directory contains `SQL` scripts that initialize the database schema and populate it with data. Here's a summary of the schema and data:

#### Schema tables: ####
- **Continent:** Stores information about continents. Includes entries like Africa, Asia, Europe, etc.
- **Country:** Stores information about countries including their populations and areas. Includes entries with attributes such as population and area.
- **Person:** Stores information about people. Includes a list of individuals.
- **Person_Citizenship:** Many-to-many relationship table between Person and Country. Maps people to countries where they hold citizenship.

## Instructions ##
 
### Clone the Repository ###

1. Open your terminal or command prompt.
2. Run the following command to clone the repository:

   ```bash
   git clone <https://github.com/BrianVega/Queries_Exercises.git>
   ```
3. Navigate to project repository
    ```bash
      cd Queries_Exercises
    ```

### Run the container ###
1. Ensure Docker and Docker Compose are installed on your machine.
2. Start the Docker container with:
    ``` bash
    docker-compose up
    ```
This command will build and start the PostgreSQL container as specified in the docker-compose.yml file.
**You will see the tables creation as well as the requested queries executed, like in the following image:**
<img width="1113" alt="image" src="https://github.com/user-attachments/assets/0835bfa4-a31f-480f-a072-0da4ebce7ac7">

3. Stop the docker container
    ```bash
    docker-compose down --volumes
    ```