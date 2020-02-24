CREATE TABLE recipe (
  recipeId STRING(32) NOT NULL,
  recipeName STRING(45) NOT NULL,
  description STRING(MAX) NOT NULL,
  cuisine STRING(25) NOT NULL,
  amount Float64 NOT NULL, 
  time INT64 NOT NULL,
  difficulty INT64 NOT NULL,
  calories FLOAT64 NOT NULL,
) PRIMARY KEY(recipeId),
  
CREATE UNIQUE INDEX recipeNameIndex ON recipe(recipeName);

CREATE TABLE product (
  recipeId STRING(32) NOT NULL,
  productId STRING(32) NOT NULL,
  productName STRING(45) NOT NULL,
  proteins FLOAT64 NOT NULL,
  fats FLOAT64 NOT NULL,
  carbohydrates FLOAT64 NOT NULL,
  measureUnit STRING(25) NOT NULL,
  calories FLOAT64 NOT NULL,
) PRIMARY KEY(recipeId, productId),
INTERLEAVE IN PARENT recipe ON DELETE CASCADE;

CREATE UNIQUE INDEX productNameIndex ON product(productName);

CREATE TABLE userSecured (
  userSecuredId STRING(32) NOT NULL,
  username STRING(45) NOT NULL,
  password STRING(45) NOT NULL,
) PRIMARY KEY(userSecuredId);

CREATE TABLE user (
  userSecuredId STRING(32) NOT NULL,
  userId STRING(32) NOT NULL,
  height INT64,
  weight INT64,
  gender STRING(45),
  activity INT64,
  blacklist ARRAY<STRING(45)>,
  includeCooked BOOL,
) RIMARY KEY(userSecuredId, userId),
  INTERLEAVE IN PARENT userSecured ON DELETE CASCADE;

CREATE TABLE cookedRecipeHistory (
  userId STRING(32) NOT NULL,
  recipeId STRING(32) NOT NULL,
  createdAt TIMESTAMP,
) PRIMARY KEY(UserId, RecipeId);

CREATE UNIQUE INDEX userSecuredIndex ON UserSecured(Username);

CREATE TABLE accessToken (
  userSecuredId STRING(32) NOT NULL,
  accessTokenId STRING(32) NOT NULL,
  issuedAt TIMESTAMP NOT NULL,
) PRIMARY KEY(userSecuredId, accessTokenId),
  INTERLEAVE IN PARENT userSecured ON DELETE CASCADE;

CREATE TABLE refreshToken (
  userSecuredId STRING(32) NOT NULL,
  accessTokenId STRING(32) NOT NULL,
  refreshTokenId STRING(32) NOT NULL,
  issuedAt TIMESTAMP NOT NULL,
) PRIMARY KEY(userSecuredId, accessTokenId, refreshTokenId),
  INTERLEAVE IN PARENT UserSecured ON DELETE CASCADE;

CREATE TABLE role (
  userSecuredId STRING(32) NOT NULL,
  roleId STRING(32) NOT NULL,
  roleName STRING(16) NOT NULL,
) PRIMARY KEY(userSecuredId, roleId),
  INTERLEAVE IN PARENT UserSecured ON DELETE NO ACTION;

CREATE UNIQUE INDEX roleNameIndex ON role(roleName);
