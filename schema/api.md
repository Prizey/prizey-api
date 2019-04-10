
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


## <a name="resource-setting">Setting</a>

Stability: `prototype`

A setting is a set of information saved for a configuration

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **easy_carousel_speed** | *integer* | the setting foth the easy carousel speed | `42` |
| **easy_tickets** | *integer* | the setting foth the easy tickets | `42` |
| **hard_carousel_speed** | *integer* | the setting foth the hard carousel speed | `42` |
| **hard_tickets** | *integer* | the setting foth the hard tickets | `42` |
| **id** | *integer* | unique setting identifier | `42` |
| **medium_carousel_speed** | *integer* | the setting foth the medium carousel speed | `42` |
| **medium_tickets** | *integer* | the setting foth the medium tickets | `42` |

### <a name="link-GET-setting-/settings">Setting List</a>

List of settings

```
GET /settings
```


#### Curl Example

```bash
$ curl -n https://api.prizey.app/settings
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


