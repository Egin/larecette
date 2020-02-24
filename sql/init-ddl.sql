CREATE TABLE Product (
  ProductId STRING(32) NOT NULL,
  ProductName STRING(45) NOT NULL,
  Proteins FLOAT64 NOT NULL,
  Fats FLOAT64 NOT NULL,
  Carbohydrates FLOAT64 NOT NULL,
  MeasureUnit STRING(25) NOT NULL,
  Calories FLOAT64 NOT NULL,
) PRIMARY KEY(ProductId);

CREATE UNIQUE INDEX ProductNameIndex ON Product(ProductName);

CREATE TABLE Recipe (
  ProductId STRING(32) NOT NULL,
  RecipeId STRING(32) NOT NULL,
  RecipeName STRING(45) NOT NULL,
  Description STRING(MAX) NOT NULL,
  Cuisine STRING(25) NOT NULL,
  Amount INT64 NOT NULL, 
  Time INT64 NOT NULL,
  Difficulty INT64 NOT NULL,
  Calories FLOAT64 NOT NULL,
) PRIMARY KEY(ProductId, RecipeId),
  INTERLEAVE IN PARENT Product ON DELETE CASCADE;

CREATE UNIQUE INDEX RecipeNameIndex ON Recipe(RecipeName);

CREATE TABLE UserSecured (
  UserSecuredId STRING(32) NOT NULL,
  Username STRING(45) NOT NULL,
  Password STRING(45) NOT NULL,
) PRIMARY KEY(UserSecuredId);

CREATE TABLE User (
  UserSecuredId STRING(32) NOT NULL,
  UserId STRING(32) NOT NULL,
  Height INT64,
  Weight INT64,
  Gender STRING(45),
  Activity INT64,
  Blacklist ARRAY<STRING(45)>,
  IncludeCooked BOOL,
) PRIMARY KEY(UserSecuredId, UserId),
  INTERLEAVE IN PARENT UserSecured ON DELETE CASCADE;

CREATE TABLE CookedRecipeHistory (
  UserId STRING(32) NOT NULL,
  RecipeId STRING(32) NOT NULL,
  CreatedAt TIMESTAMP,
) PRIMARY KEY(UserId, RecipeId);

CREATE UNIQUE INDEX UserSecuredIndex ON UserSecured(Username);

CREATE TABLE AccessToken (
  UserSecuredId STRING(32) NOT NULL,
  AccessTokenId STRING(32) NOT NULL,
  IssuedAt TIMESTAMP NOT NULL,
) PRIMARY KEY(UserSecuredId, AccessTokenId),
  INTERLEAVE IN PARENT UserSecured ON DELETE CASCADE;

CREATE TABLE RefreshToken (
  UserSecuredId STRING(32) NOT NULL,
  AccessTokenId STRING(32) NOT NULL,
  RefreshTokenId STRING(32) NOT NULL,
  IssuedAt TIMESTAMP NOT NULL,
) PRIMARY KEY(UserSecuredId, AccessTokenId, RefreshTokenId),
  INTERLEAVE IN PARENT UserSecured ON DELETE CASCADE;

CREATE TABLE Role (
  UserSecuredId STRING(32) NOT NULL,
  RoleId STRING(32) NOT NULL,
  RoleName STRING(16) NOT NULL,
) PRIMARY KEY(UserSecuredId, RoleId),
  INTERLEAVE IN PARENT UserSecured ON DELETE CASCADE;

CREATE UNIQUE INDEX RoleNameIndex ON Role(RoleName);
