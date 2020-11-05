# README

LOCAL SPOTLIGHT

# ENDPOINTS

## AUTHORIZATION HEADER EXAMPLE:

Authorization is accomplished with an OAuth2.0 Bearer Token that is included in the header.
```json
    {
       Authorization: "Bearer eyJhd...iIp0"
    }
```

## __USER SIGNUP__ 

**URL** : `/api/v1/users/`

**Method** : `POST`

**Auth required** : NO

**Headers** : N/A

**JSON example body**
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

**Success content example**
```json
{
    "auth_token": "eyJhbG...ISiFM"
}
```
Successful requests are returned a JSON Web Token to be used inorder to authorize future requests. 

### Error Responses

**Condition** : If email is already in use

**Code** : `422 Unprocessable Entity`

**Error content example**
```json
{
    "email": [
        "has already been taken"
    ]
}
```
---
## __USER LOGIN__ 

**URL** : `/api/v1/users/login`

**Method** : `POST`

**Auth required** : NO

**Headers** : N/A

**JSON example body**
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

**Success content example**
```json
{
    "auth_token": "eyJhb...4Z1cjY"
}
```
Successful requests are returned a JSON Web Token to be used inorder to authorize future requests. 

### Error Responses

**Condition** : If credentials are missing or invalid

**Code** : `401 Unauthorized`

**Error content example**
```json
{
    "error": "Invalid username/password"
}
```
---
## __ARTIST CREATION__

**URL** : `/api/v1/artists`

**Method** : `POST`

**Auth required** : YES (TYPE: BEARER TOKEN)

**Headers** : N/A

**JSON example body**
```json
{ "spotify_id":"2vnB6tuQMaQpORiRdvXF9H", "city":"Chicago", "state":"IL"}
```

### Success Response

**Condition** : If everything is OK and artist doesnt already exist

**Code** : `201 CREATED`

**Success content example**
```json
{
    "artist": 40
}
```
The newly created aritst's ID is returned in the response.

### Error Responses

**Condition** : If aritst's spotify ID is invalid or already exists in the databse

**Code** : `400 Bad Request`

**Error content example**
```json
{
    "error": {
        "message": "Artist already exists",
        "artist_id": 40
    }
}
```
Along with the error message, the existing artist's ID is returned in response.

---
## __ARTISTS BY CITY__ 

**URL** : `/api/v1/artists`

**Method** : `GET`

**Auth required** : YES (TYPE: BEARER TOKEN)

**Headers** : N/A

**JSON example body**
```json
{
    "artist": {
      "city": "Rockford",
      "state": "IL",
      "sort": "alphabetical"
    }
}
```
city and state are required parameters while sort is an optional parameter that if left blank will return the artists in a random sort. The current sorting options are 'alphabetical', 'followers', and 'random'.

### Success Response

**Condition** : If everything is OK and city/state are valid

**Code** : `200 OK`

**Success content example**
```json
{
    "artists": [
        {
            "id": 39,
            "spotify_id": "2oWWnEqDToq3n0Hv1zPZQJ",
            "name": "Name The Moon",
            "city": "Rockford",
            "state": "IL",
            "followers": 87
        },
        {
            "id": 36,
            "spotify_id": "3EusnQEaJ7atdju9f3QoB0",
            "name": "Purple Hell",
            "city": "Rockford",
            "state": "IL",
            "followers": 24
        },
        ...
    ]
}        
```

### Error Responses

**Condition** : If there are no matching artists (either due to none matching the city, or an invalid city/state) an empty array will be returned.

**Code** : `200 OK`

**Error content example**
```json
{
    "artists": []
}
```
