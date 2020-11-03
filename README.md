# README

LOCAL SPOTLIGHT

# Endpoints

## __Create an Account__ if one does not already exist

**URL** : `/api/v1/users/`

**Method** : `POST`

**Auth required** : NO

**Headers** : N/A

**raw JSON example body**
```json
{
    "user": {
      "username": "Joliet Jake",
      "email": "TheBluesBrothers@gmail.com",
      "password": "CheezWhiz1060",
      "password_confirmation": "CheezWhiz1060"
    }
}
```

### Success Response

**Condition** : If everything is OK and an Account didn't exist for this User.

**Code** : `201 CREATED`

**Content example**
```json
{
    "auth_token": "eyJhbG...ISiFM"
}
```

### Error Responses

**Condition** : If Account already exists or a field is missed.

**Code** : `422 Unprocessable Entity`

**Content example**
```json
{
    "email": [
        "has already been taken"
    ]
}
```
---
## __Log Into Account__ with valid credentials

**URL** : `/api/v1/users/login`

**Method** : `POST`

**Auth required** : NO

**Headers** : N/A

**raw JSON example body**
```json
{
    "user": {
      "email": "TheBluesBrothers@gmail.com",
      "password": "CheezWhiz1060"
    }
}
```

### Success Response

**Condition** : If everything is OK and credentials are valid

**Code** : `201 CREATED`

**Content example**
```json
{
    "auth_token": "eyJhb...4Z1cjY"
}
```

### Error Responses

**Condition** : If credentials are missing or invalid

**Code** : `401 Unauthorized`

**Content example**
```json
{
    "error": "Invalid username/password"
}
```
---
## __Create New Artist__ if one doesn't already exist

**URL** : `/api/v1/artists`

**Method** : `POST`

**Auth required** : YES (TYPE: BEARER TOKEN)

**Headers** : N/A

**raw JSON example body**
```json
{ "spotify_id":"2vnB6tuQMaQpORiRdvXF9H", "city":"Chicago", "state":"IL"}
```

### Success Response

**Condition** : If everything is OK and artist doesnt already exist

**Code** : `201 CREATED`

**Content example**
```json
{
    "artist": 40
}
```
The newly created aritst's ID is returned in the response.

### Error Responses

**Condition** : If aritst's spotify ID is invalid or already exists in the databse

**Code** : `400 Bad Request`

**Content example**
```json
{
    "error": {
        "message": "Artist already exists",
        "artist_id": 40
    }
}
```
Along with the error message, the existing artist's ID is returned in response.
