
## <a name="resource-admin_text">Admin Texts</a>

Stability: `prototype`

An admin text is a text for an admin area

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *integer* | unique identifier of the Admin Text | `42` |

### <a name="link-GET-admin_text-/admin_texts">Admin Texts List</a>

Show the admin texts for the tags.

```
GET /admin_texts
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **tags** | *array* |  | `[null]` |


#### Curl Example

```bash
$ curl -n https://api.prizey.app/admin_texts
 -G \
  -d tags[]=
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
null
```


## <a name="resource-card">cards</a>

Stability: `prototype`

cards are made to Stripe transparent checkout API

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **brand** | *string* | credit card brand | `"example"` |
| **id** | *string* | identifier for the credit card on stripe | `"example"` |
| **last4** | *string* | credit card last 4 digits | `"example"` |

### <a name="link-GET-card-/cards">cards List</a>

List a new card

```
GET /cards
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **brand** | *string* | credit card brand | `"example"` |
| **id** | *string* | identifier for the credit card on stripe | `"example"` |
| **last4** | *string* | credit card last 4 digits | `"example"` |


#### Curl Example

```bash
$ curl -n https://api.prizey.app/cards
 -G \
  -d id=example \
  -d last4=example \
  -d brand=example
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
null
```


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
| **ad_diamonds_reward** | *integer* | the number of tickets received after watch Ads | `42` |
| **easy_carousel_speed** | *integer* | the easy carousel speed parameter of the game setting | `42` |
| **easy_ticket_amount** | *integer* | the number of tickets for the easy play setting | `42` |
| **hard_carousel_speed** | *integer* | the hard carousel speed parameter of the game setting | `42` |
| **hard_ticket_amount** | *integer* | the number of tickets for the hard play setting | `42` |
| **id** | *integer* | unique game setting identifier | `42` |
| **medium_carousel_speed** | *integer* | the medium carousel speed parameter of the game setting | `42` |
| **medium_ticket_amount** | *integer* | the number of tickets for the medium play setting | `42` |
| **price_multiplier** | *number* | the number that multiplies the price velocity of the game setting | `42.0` |
| **sell_it_back_amount** | *integer* | the amount set to sell it back | `42` |
| **vast_tag** | *nullable string* | VAST Tag used on Ad Player | `null` |
| **video_ads_for_reward** | *integer* | the number of video ads to watch to receive the reward | `42` |

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


## <a name="resource-order">order</a>

Stability: `prototype`

An order is a shopify order

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *integer* | The status (error, success) of the order | `42` |
| **message** | *string* | the message when order fail to create | `"example"` |

### <a name="link-POST-order-/orders">order Create</a>

Create Shopify Order

```
POST /orders
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **product_id** | *string* | the product/variant ID to use on Shopify Order | `"example"` |


#### Curl Example

```bash
$ curl -n -X POST https://api.prizey.app/orders \
  -d '{
  "product_id": "example"
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


## <a name="resource-payment">payments</a>

Stability: `prototype`

Payments are made to Stripe transparent checkout API

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **credit_card_source** | *string* | credit card from user's card list | `"example"` |
| **credit_card_token** | *string* | credit card payment token from Stripe.js | `"example"` |
| **purchase_option_id** | *integer* | identifier for the purchase option recorded on database | `42` |

### <a name="link-POST-payment-/payments">payments Create</a>

Create a new payment

```
POST /payments
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **credit_card_source** | *string* | credit card from user's card list | `"example"` |
| **credit_card_token** | *string* | credit card payment token from Stripe.js | `"example"` |
| **purchase_option_id** | *integer* | identifier for the purchase option recorded on database | `42` |


#### Curl Example

```bash
$ curl -n -X POST https://api.prizey.app/payments \
  -d '{
  "purchase_option_id": 42,
  "credit_card_token": "example",
  "credit_card_source": "example"
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


## <a name="resource-product">Product</a>

Stability: `prototype`

A product is a shopify product

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *integer* | the product id | `42` |
| **image** | *string* | the product image | `"example"` |
| **price** | *number* | the product price | `42.0` |
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


## <a name="resource-purchase_option">purchase_option</a>

Stability: `prototype`

A Purchase Options is used to choose how many tickets to buy

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *integer* | the Purchase Option id | `42` |
| **name** | *string* | the Purchase Option name | `"example"` |
| **price** | *string* | the Purchase Option price | `"example"` |
| **ticket_amount** | *number* | how many tickets you receive with this option | `42.0` |

### <a name="link-GET-purchase_option-/purchase_options/{(%23%2Fdefinitions%2Fpurchase_option%2Fdefinitions%2Fidentifier)}">purchase_option List</a>

List of purchase options

```
GET /purchase_options/{purchase_option_identifier}
```


#### Curl Example

```bash
$ curl -n https://api.prizey.app/purchase_options/$PURCHASE_OPTION_IDENTIFIER
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


## <a name="resource-success">Success</a>

Stability: `prototype`

A success represents a basic success action

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *string* | unique identifier of the success<br/> **pattern:** `^\w+$` | `"example"` |
| **message** | *string* | message of success | `"example"` |

### <a name="link-GET-success-/successs/{(%23%2Fdefinitions%2Fsuccess%2Fdefinitions%2Fidentity)}">Success Info</a>

Info for existing success.

```
GET /successs/{success_id}
```


#### Curl Example

```bash
$ curl -n https://api.prizey.app/successs/$SUCCESS_ID
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
| **source** | *nullable string* | the source that fired the transaction | `null` |


#### Curl Example

```bash
$ curl -n -X POST https://api.prizey.app/ticket_transactions \
  -d '{
  "amount": 42,
  "source": "example"
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
| **blocked** | *boolean* | the block status of the user | `true` |
| **city** | *nullable string* | the city of the user | `null` |
| **clothing_size** | *nullable string* | the clothing size of the user | `null` |
| **email** | *email* | the email of the user | `"username@example.com"` |
| **fullname** | *nullable string* | the fullname of the user | `null` |
| **id** | *integer* | unique identifier of the user | `42` |
| **shoe_size** | *nullable string* | the shoe size of the user | `null` |
| **state_province_region** | *nullable string* | the state province region of the user | `null` |
| **tickets** | *integer* | the amount of tickets user has | `42` |
| **zipcode** | *nullable string* | the postal code or zip of the user | `null` |


