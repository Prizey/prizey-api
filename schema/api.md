
## <a name="resource-error">Error</a>

Stability: `prototype`

An error represents a failed action in the API

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *string* | unique identifier of error<br/> **pattern:** `^\w+$` | `"example"` |
| **message** | *string* | message of error | `"example"` |

### <a name="link-GET-error-/errors/{(%23%2Fdefinitions%2Ferror%2Fdefinitions%2Fidentity)}">Error Info</a>

Info for existing error.

```
GET /errors/{error_id}
```


#### Curl Example

```bash
$ curl -n https://api.prizey.app/errors/$ERROR_ID
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": "example",
  "message": "example"
}
```


## <a name="resource-game_setting">Game Setting</a>

Stability: `prototype`

The game setting is a set of information for the game configuration

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **easy_carousel_speed** | *integer* | the easy carousel speed parameter of the game setting | `42` |
| **easy_ticket_amount** | *integer* | the number of tickets for the easy play setting | `42` |
| **hard_carousel_speed** | *integer* | the hard carousel speed parameter of the game setting | `42` |
| **hard_ticket_amount** | *integer* | the number of tickets for the hard play setting | `42` |
| **id** | *integer* | unique game setting identifier | `42` |
| **medium_carousel_speed** | *integer* | the medium carousel speed parameter of the game setting | `42` |
| **medium_ticket_amount** | *integer* | the number of tickets for the medium play setting | `42` |
| **price_multiplier** | *integer* | the number that multiplies the price velocity of the game setting | `42` |

### <a name="link-GET-game_setting-/game_setting">Game Setting Info</a>

Info for the existing game setting

```
GET /game_setting
```


#### Curl Example

```bash
$ curl -n https://api.prizey.app/game_setting
 -G \
  -d 
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
null
```


## <a name="resource-product">Product</a>

Stability: `prototype`

A product is a shopify product

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *integer* | the product id | `42` |
| **image** | *string* | the product image | `"example"` |
| **price** | *string* | the product price | `"example"` |
| **title** | *string* | the product title | `"example"` |

### <a name="link-GET-product-/products/{(%23%2Fdefinitions%2Fproduct%2Fdefinitions%2Fidentifier)}">Product List</a>

List of products

```
GET /products/{product_identifier}
```


#### Curl Example

```bash
$ curl -n https://api.prizey.app/products/$PRODUCT_IDENTIFIER
 -G \
  -d 
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
null
```


## <a name="resource-ticket_transaction">ticket transaction</a>

Stability: `prototype`

The ticket transaction is a set of information for the game configuration

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **amount** | *integer* | the amount of tickets | `42` |
| **created_at** | *date-time* | when the ticket transaction was created | `"2015-01-01T12:00:00Z"` |
| **id** | *integer* | unique ticket transaction identifier | `42` |
| **user** | *object* | the owner of the ticket transaction |  |

### <a name="link-GET-ticket_transaction-/ticket_transactions">ticket transaction List</a>

List of tick transactions

```
GET /ticket_transactions
```


#### Curl Example

```bash
$ curl -n https://api.prizey.app/ticket_transactions
 -G \
  -d 
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
null
```

### <a name="link-POST-ticket_transaction-/ticket_transactions">ticket transaction Create</a>

Create a new ticket_transaction

```
POST /ticket_transactions
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **amount** | *integer* | the amount of tickets | `42` |


#### Curl Example

```bash
$ curl -n -X POST https://api.prizey.app/ticket_transactions \
  -d '{
  "amount": 42
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
null
```


## <a name="resource-user">User</a>

Stability: `prototype`

A user is a person registered in the platform

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **address** | *nullable string* | the address of the user | `null` |
| **city** | *nullable string* | the city of the user | `null` |
| **clothing_size** | *nullable string* | the clothing size of the user | `null` |
| **email** | *email* | the email of the user | `"username@example.com"` |
| **fullname** | *nullable string* | the fullname of the user | `null` |
| **id** | *integer* | unique identifier of the user | `42` |
| **shoe_size** | *nullable string* | the shoe size of the user | `null` |
| **state_province_region** | *nullable string* | the state province region of the user | `null` |
| **tickets** | *integer* | the amount of tickets user has | `42` |
| **zipcode** | *nullable string* | the postal code or zip of the user | `null` |

### <a name="link-PUT-user-/auth">User Update</a>

Update existing user.

```
PUT /auth
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **address** | *nullable string* | the address of the user | `null` |
| **city** | *nullable string* | the city of the user | `null` |
| **clothing_size** | *nullable string* | the clothing size of the user | `null` |
| **fullname** | *nullable string* | the fullname of the user | `null` |
| **shoe_size** | *nullable string* | the shoe size of the user | `null` |
| **state_province_region** | *nullable string* | the state province region of the user | `null` |
| **zipcode** | *nullable string* | the postal code or zip of the user | `null` |


#### Curl Example

```bash
$ curl -n -X PUT https://api.prizey.app/auth \
  -d '{
  "fullname": "example",
  "address": "example",
  "city": "example",
  "state_province_region": "example",
  "zipcode": "example",
  "clothing_size": "example",
  "shoe_size": "example"
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
null
```


