# Scheduling API

## About this project

This project is a backend API for a simple professional appointment scheduling system, developed as a solution to a technical challenge for a U.S.-based wellness startup.

The main goal is to provide a robust and well-structured API that handles the business logic of scheduling, including time constraints, professional availability, and time zone awareness.


### ✨ Key Features

- Appointment Management: Create, list, and cancel appointments for a simulated user.

- Business Rules Validation: The system strictly enforces the following rules:
    - Appointments have a fixed duration of 30 minutes.
    - Appointments must be scheduled within business hours (09:00 to 17:00), Monday through Friday, respecting the professional's local time zone.
    - Professionals cannot have overlapping appointments.

- Time Zone Aware: All business hour validations are performed in the professional's specific time zone, ensuring accuracy for a distributed team. All data is stored in UTC.

- Paginated Lists: All listing endpoints are paginated to ensure efficient data retrieval.

- Centralized Error Handling: Provides consistent and predictable error responses for invalid requests or missing resources.


### 🛠️ Tech Stack

- Ruby 3.2+

- Ruby on Rails 7+ (API Only Mode)

- PostgreSQL 12+

- Pagy for pagination

- Puma as the web server


#### 🚀 Getting Started

Follow these instructions to get the project up and running on your local machine.

##### Prerequisites

Make sure you have the following installed:

    - Ruby (preferably managed by a version manager like asdf or rvm).

    - Bundler gem (gem install bundler).

    - PostgreSQL database.

##### Setup Instructions

   1. Clone the repository, then enter project folder:
   ```bash
   git clone git@github.com:Mateus-Bittencourt/scheduler.git
   ```

   2. Install dependencies:
   ```bash
   bundle install
   ```

   3. Configure the database:
   - config/database.yml already provided.
   - Configure with your local PostgreSQL username and password.

   4. Create, migrate, and seed the database:
   - This command will create the database, run all migrations, and populate the database with an initial set of users and professionals.
   ```bash
   rails db:setup
   ```

   5. Run the application server:
   ```bash
   rails server
   ```

### 📖 API Endpoints Documentation

The base URL for all endpoints is /api/v1. For simplicity, authentication is not required; the system simulates a current_user.

#### Professionals

GET /professionals

Lists all available professionals.

    - Query Parameters:

        - page (optional): The page number for pagination.

    - Success Response (200 OK):
   ```json
{
  "data": [
    {
      "id": 1,
      "name": "Dr. Emily Carter",
      "specialty": "Cardiology",
      "time_zone": "America/New_York"
    }
  ],
  "pagination": {
    "current_page": 1,
    "total_items": 10,
    "total_pages": 1,
    "page_size": 20
  }
}
   ```

#### Appointments

GET /appointments

Lists all appointments for the current simulated user, sorted by start time.

    - Query Parameters:

        - page (optional): The page number for pagination.

    - Success Response (200 OK):
   ```json
{
  "data": [
    {
      "id": 1,
      "appointment_date": "08/21/2025",
      "appointment_time": "10:30 AM",
      "professional": {
        "name": "Dr. Jessica Davis",
        "specialty": "Nutrition"
      },
      "user": {
        "name": "Lorem User"
      },
      "time_zone": "America/New_York"
    }
  ],
  "pagination": { ... }
}
   ```

POST /appointments

Creates a new appointment.

    - Request Body:
   ```json
{
  "appointment": {
    "professional_id": 1,
    "start_time": "2025-09-22T14:30:00Z"
  }
}
   ```
Note: start_time must be in ISO 8601 format and will be validated against the professional's business hours and availability.

   - Success Response (201 Created):
   ```json
{
  "id": 2,
  "appointment_date": "09/22/2025",
  "appointment_time": "11:30 AM",
  ...
}
   ```

DELETE /appointments/:id

- Cancels an appointment for the current user.

    - URL Parameters:

        - id (required): The ID of the appointment to be canceled.

    - Success Response (204 No Content):

        - An empty response with a 204 status code.

#### 🏛️ Architectural Decisions

- Service Objects: Business logic for complex actions (like listing or creating appointments) is encapsulated in service objects (app/services). This keeps controllers thin and focused on handling HTTP requests and responses.

- Serializers: The JSON representation of models is handled by serializer classes (app/serializers). This separates the data model from its presentation layer, making the API responses easier to manage and modify.

- Time Zone Strategy: The application is configured to operate in UTC. All timestamps are stored in UTC in the database. For validations and display, timestamps are converted to the appropriate local time zone (either the professional's or the user's), ensuring correctness and eliminating ambiguity.

##### For easier testing, a Postman collection file (.json) containing all API requests is available in the project's root directory.