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
