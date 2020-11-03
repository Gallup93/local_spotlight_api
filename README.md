# README

LOCAL SPOTLIGHT

# Endpoints

---

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
      "password": "password",
      "password_confirmation": "password"
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
