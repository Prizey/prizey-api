
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
| **hard_carousel_speed** | *integer* | the hard carousel speed parameter of the game setting | `42` |
| **id** | *integer* | unique game setting identifier | `42` |
| **medium_carousel_speed** | *integer* | the medium carousel speed parameter of the game setting | `42` |
| **price_multiplier** | *integer* | the number that multiplies the price velocity of the game setting | `42` |

### <a name="link-GET-game_setting-/game_settings">Game Setting List</a>

List of game settings

```
GET /game_settings
```


#### Curl Example

```bash
$ curl -n https://api.prizey.app/game_settings
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


