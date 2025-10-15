# ADN Evaluation API

Small .NET 9 evaluation project for ADN — implements user registration and login using ASP.NET Core Identity and JWT authentication.

## What this project contains
- ASP.NET Core (.NET 9) Web API
- ASP.NET Core Identity with a custom ApplicationUser (FirstName, LastName)
- JWT bearer authentication
- EF Core migrations (InitialSetup created tables for Identity)
- Swagger (enabled in Development)

## Prerequisites
- .NET 9 SDK installed
- MYSQL server/mysql mariaDB instance
- Optional: Visual Studio 2022 or any .NET editor
- EF Core CLI tools if you use the CLI (__dotnet tool install --global dotnet-ef__)

## Configuration
Primary settings live in `appsettings.json`

## Database (migrations)
A migration has already been added which creates the Identity schema.
To apply migrations:
- From CLI:
  - __dotnet ef database update__
- From Visual Studio:
  - Open __Package Manager Console__ and run: __Update-Database__

Ensure the connection string points to a valid MYSQL before running.

## Running the API
- From CLI: __dotnet run__
- Or run via Visual Studio (F5 / __Debug > Start Debugging__).

When running in Development, Swagger UI is available for quick testing (typically at `/swagger`).

## Authentication endpoints
Register
POST /api/auth/register
Request body (JSON)
{
  "firstName": "Jane",
  "lastName": "Doe",
  "email": "jane.doe@example.com",
  "password": "P@ssw0rd!"
}

Login
POST /api/auth/login
Request body (JSON)
{
  "email": "jane.doe@example.com",
  "password": "P@ssw0rd!"
}