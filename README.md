### Issues in API Documentation

#### 1. Login Endpoint
**Problem:** The login endpoint requires all three fields: `email`, `username`, and `password` to authenticate successfully. It does not allow login with only the `email` or `username` fields, which is not stated clearly in the documentation.

**Expected Behavior:**
- The documentation should clarify that all three fields are mandatory.
- Alternatively, the API should allow login with either `email` and `password` or `username` and `password` for greater flexibility.

**Recommendation:** Update the documentation to explicitly state that all three fields (`email`, `username`, and `password`) are required for the login request to succeed.

#### Example Request:
```json
{
  "email": "abc@gmail.com",
  "username": "abcdefgh",
  "password": "abcdefgh"
}
```

---

#### 2. Update Profile Endpoint
**Problem:** Updating a user profile requires two consecutive executions of the `updateProfile` endpoint to get the correct result. On the first attempt, the returned data does not reflect the changes made in the request payload. Only after a second execution does the API return the updated data correctly.

**First Execution:**
Input:
```json
{
  "name": "ayam",
  "birthday": "aaa",
  "height": 20,
  "weight": 20,
  "interests": [
    "string"
  ]
}
```
Response:
```json
{
  "message": "Profile has been updated successfully",
  "data": {
    "email": "abc@gmail.com",
    "username": "abcdefgh",
    "name": "string",
    "birthday": "string",
    "horoscope": "Error",
    "height": 0,
    "weight": 0,
    "interests": [
      "string"
    ]
  }
}
```

**Second Execution:**
Input:
```json
{
  "name": "ayam",
  "birthday": "aaa",
  "height": 20,
  "weight": 20,
  "interests": [
    "string"
  ]
}
```
Response:
```json
{
  "message": "Profile has been updated successfully",
  "data": {
    "email": "abc@gmail.com",
    "username": "abcdefgh",
    "name": "ayam",
    "birthday": "aaa",
    "horoscope": "Error",
    "height": 20,
    "weight": 20,
    "interests": [
      "string"
    ]
  }
}
```

**Expected Behavior:**
- The profile update should succeed on the first execution, returning the updated data immediately.
- The response should correctly reflect the changes made in the request payload.



